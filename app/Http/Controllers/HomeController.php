<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    // public function __construct()
    // {
    //     $this->middleware('auth');
    // }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    //TODO INDEX
    public function home()
    {
        $user_id = Auth::user()->id;
        $inventory = DB::table("inventory")->get();
        $date_now = date('Y-m-d', strtotime(date("Y-m-d")));
        $date_now_1 = date('Y-m-d', strtotime("+1 day", strtotime(date("Y-m-d"))));
        $validasi_dp = DB::TABLE('non_member')
                       ->LEFTJOIN("jadwal_pertandingan","non_member.jadwal","jadwal_pertandingan.id_pertandingan")
                                ->LEFTJOIN("paket","jadwal_pertandingan.paket","paket.id_paket")
                                ->LEFTJOIN("status_pesanan","jadwal_pertandingan.flag_status","status_pesanan.id_status_pesanan")
                                ->SELECT(
                                    'non_member.*',
                                    'jadwal_pertandingan.jam_pertandingan',
                                    'jadwal_pertandingan.flag_status',
                                    'jadwal_pertandingan.tanggal_pertandingan',                
                                    'status_pesanan.deskripsi AS status_deskripsi',                                 
                                )
                        ->WHEREIN('flag_status',[1,2])
                        ->GET();
        $member = DB::table('member')
                                ->LEFTJOIN("jadwal_pertandingan","member.jadwal","jadwal_pertandingan.id_pertandingan")
                                ->LEFTJOIN("paket","jadwal_pertandingan.paket","paket.id_paket")
                                ->LEFTJOIN("status_pesanan","jadwal_pertandingan.flag_status","status_pesanan.id_status_pesanan")
                                ->SELECT(
                                    'member.*',
                                    'jadwal_pertandingan.*',                
                                    'status_pesanan.deskripsi AS status_deskripsi'                               
                                )  
                                ->WHERE('member.id_user_member', '=', $user_id)
                                ->GET();
        $cek_jumlah_pesanan = DB::table('member')
                                    ->select(
                                        
                                    DB::raw('count(id_user_member) as jml_pesanan')  
                                    )
                                    ->where('id_user_member', $user_id)
                                    ->first();


        $pesanan = DB::table('jadwal_pertandingan')
                        ->LEFTJOIN('member','jadwal_pertandingan.id_pertandingan', 'member.jadwal')
                        ->LEFTJOIN('non_member','jadwal_pertandingan.id_pertandingan', 'non_member.jadwal')
                        ->LEFTJOIN('paket','jadwal_pertandingan.paket', 'paket.id_paket')
                        ->LEFTJOIN('status_pesanan', 'jadwal_pertandingan.flag_status', 'status_pesanan.id_status_pesanan')
                        ->LEFTJOIN('users', 'member.id_user_member', 'users.id')
                        ->select(
                            'jadwal_pertandingan.id_pertandingan as jadwal',
                            'jadwal_pertandingan.tanggal_pertandingan as tanggal',
                            'jadwal_pertandingan.jam_pertandingan as jam',
                            'jadwal_pertandingan.nama_tim',
                            'jadwal_pertandingan.paket',
                            'jadwal_pertandingan.flag_status',
                            'member.id_user_member',
                            'member.updated_at',
                            'non_member.tambahan_rompi',
                            'non_member.id_non_member',
                            'non_member.biaya_tambahan',
                            'non_member.updated_at',
                            'non_member.nama_pemesan as nama_non_member',
                            'users.name as nama_member',
                            'paket.deskripsi as nama_paket',
                            'paket.harga',
                            'status_pesanan.deskripsi',
                        )
                        ->whereIn('jadwal_pertandingan.flag_status', [4, 5])
                        ->get();
                        // dd($pesanan);
        $status_pesanan = DB::table('jadwal_pertandingan')
                            ->LEFTJOIN('member','jadwal_pertandingan.id_pertandingan', 'member.jadwal')
                            ->LEFTJOIN('non_member','jadwal_pertandingan.id_pertandingan', 'non_member.jadwal')
                            ->select(
                                DB::raw('count(case when jadwal_pertandingan.flag_status = 5 then jadwal_pertandingan.id_pertandingan else null end) as batal_transaksi'),
                                DB::raw('count(case when jadwal_pertandingan.flag_status != 5 then jadwal_pertandingan.id_pertandingan else null end) as selesai_transaksi')
                            )
                            ->get();
                            // dd($pesanan);
        foreach ($status_pesanan as $key) {
            $jml_batal_transaksi = $key->batal_transaksi;
            $jml_selesai_transaksi = $key->selesai_transaksi;
        }

        // dd($member);
         return view('home.home',compact('inventory','validasi_dp','member', 'date_now', 'date_now_1', 'cek_jumlah_pesanan','pesanan', 'jml_batal_transaksi', 'jml_selesai_transaksi'));
    }

     //TODO SIMPAN INVENTORY
   public function store_inventory(Request $request)
    {
        $date_now = Carbon::now('Asia/Jakarta');
        $request->validate([
            'barang'=>'required | unique:inventory,nama_barang',
            'jumlah'=>'required | integer',
        ]); 

        DB::table('inventory')->insert([
            'nama_barang' => $request->barang,
            'jumlah' => $request->jumlah,
            'created_at' => $date_now,
        ]);
        return redirect('/home')->with('status', 'Inventory Ditambahkan!');
       
    }

    //TODO DELETE INVENTORY
     public function destroy_inventory($id_inventory)

    {
        DB::table('inventory')->where('id_inventory',$id_inventory)->delete();
         return redirect('/home')->with('status-delete', 'Snack Berhasil Di Hapus!');
    }

    
    
    //TODO EDIT INVENTORY
    public function edit_inventory(Request $request){
        $id_inventory = $request->id_inventory;
        $edit = DB::table('inventory')
              ->SELECT(
                    'nama_barang' ,
                    'jumlah',
              )
              ->where('id_inventory', $id_inventory)
              ->first(); 
          
           return view('home.edit.inventory-edit',compact("edit", "id_inventory"));


    }   

    //TODO UPDATE INVENTORY
    public function update_inventory(Request $request){
        $id_inventory = $request->id_inventory;
        $date_now = Carbon::now('Asia/Jakarta');
       
        $update = DB::table('inventory')
              ->where('id_inventory', '=', $id_inventory)
                    ->UPDATE([
                    'jumlah' =>$request->jumlah,
                    'updated_at'=>$date_now
                    ]);
           return redirect('/home')->with('status', 'Inventory Berhasil Diubah!');                                
    }
    
}


 
