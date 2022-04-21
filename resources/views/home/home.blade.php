@extends('layouts.stisla')



{{--========================================= ROLE ADMIN====================================== --}}
@if(
Auth::user()->role_id == 1)
@section('title','Validasi DP')
@section('section-header','Verifikasi Dp')
@section('content')

<table class="table table-hover text-center" id="search-verifikasi-member">
    <thead>
        <tr>
            <th scope="col" class="text-center">No</th>
            <th scope="col" class="text-center">No Pemesanan</th>
            <th scope="col" class="text-center">Tanggal Pesan</th>
            <th scope="col" class="text-center">Tanggal Kick-Off</th>
            <th scope="col" class="text-center">Kick-Off</th>
            <th scope="col" class="text-center">Nama Pemesan</th>
            <th scope="col" class="text-center">Status</th>
            <th scope="col" class="text-center">Verifikasi</th>
            {{-- <th scope="col" class="text-center">Batal</th> --}}
        </tr>
    </thead>
    <tbody>
        @foreach ($validasi_dp as $dp)
        <tr>
            <th scope="row">{{$loop->iteration}}</th>
            <td class="text-uppercase text-center">{{$dp->jadwal}}</td>
            <td class="text-uppercase text-center">{{ \Carbon\Carbon::parse($dp->created_at)->format('d/m/Y H:i')}}</td>
            <td class="text-uppercase text-center">
                {{ \Carbon\Carbon::parse($dp->tanggal_pertandingan)->format('d/m/Y')}}</td>
            <td class="text-uppercase text-center">{{ \Carbon\Carbon::parse($dp->jam_pertandingan)->format('H:i')}}</td>
            <td class="text-uppercase text-center">{{$dp->nama_pemesan}}</td>
            <td>
                <h3 @if ($dp->flag_status ==1)
                    class="badge bg-warning text-light font-weight-bold"
                    @endif
                    class="badge bg-success text-light font-weight-bold" >{{$dp->status_deskripsi}}</h3>
            </td>
            <td>
                <button @if ($dp->flag_status == 1)
                    hidden
                    @endif onclick="detail_validasi_dp({{$dp->id_non_member}})" class="badge bg-primary
                    text-light"><i class="fas fa-info-circle mx-1"></i>VERIFIKASI</button>
               

        </tr>
        @endforeach
    </tbody>
</table>
<!-- Detail DP Modal -->
<div class="modal fade" id="detailDP" tabindex="-1" role="dialog" aria-labelledby="detailDPLabel" aria-hidden="true"
    data-backdrop="false">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <form method="POST" action="/update_verifikasi_dp">
                @csrf
                <div class="modal-header">
                    <h5 class="modal-title" id="detailDPLabel">Detail Verifikasi DP</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="refresh">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-success">Verifikasi</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
@endif

<script>
    function detail_validasi_dp(id_non_member) {
        var token = '{{ csrf_token() }}';
        $.ajax({
            method: 'post',
            url: '{{url('detail_validasi_dp ')}}',
            data: {
                '_token': '{{csrf_token()}}',
                'id_non_member': id_non_member
            },
            success: function (resp) {
                $('#detailDP').modal('show');
                $("#refresh").html(resp);
            }
        })
    }

</script>


{{--========================================= ROLE OWNER====================================== --}}

@if(Auth::user()->role_id == 2 )
@section('title','Laporan Keuangan')
@section('section-header','Laporan Keuangan Futsal')
@section('content')
<div class="row">
    <div class="col-3">
        <div class="form-group mb-3">
            <select name="status" id="status" class="form-control">
                <option selected disabled value="">PILIH USER</option>
                <option value="0">SEMUA</option>
                <option value="1">MEMBER</option>
                <option value="2">NON MEMBER</option>
            </select>
        </div>
    </div>
    <div class="col-3">
        <div class="input-group mb-3">
            <input type="date" class="form-control" id="tanggal1">
        </div>
    </div>
    <div class="col-3">
        <div class="input-group mb-3" z>
            <input type="date" class="form-control" id="tanggal2">
        </div>
    </div>
    <div class="col-2 mt-2">
        <div class="">
            <button onclick="filtertanggalfutsal()" class="badge bg-primary text-light"><i class="fas fa-filter mx-1"></i>Filter</button>
        </div>
    </div>
</div>
            <button onclick="window.print()" class="btn btn-primary mb-3"><i class="fas fa-print mx-1"></i>Cetak Laporan</button>

<div class="row" id="refresh">
    <table class="table table-hover table-responsive" id="search-keuangan-futsal">
        <thead>
            <tr>
                <th scope="col">No</th>
                <th scope="col">Nama</th>
                <th scope="col">Tanggal Pertandingan</th>
                <th scope="col">Jam Pertandingan</th>
                <th scope="col">Tanggal Divalidasi</th>
                <th scope="col">Status Pesanan</th>
                <th scope="col">User</th>
                <th scope="col">Harga Total</th>
                <th scope="col" class="text-center">Action</th>
            </tr>
        </thead>
        <tbody>
            <?php 
              $batal_transaksi = 0;
              $selesai_transaksi = 0;
              $total_pesanan = 0;
              $harga = 0;  
            ?>
            @foreach ($pesanan as $row)
            <tr>
                <?php
                    if ($row->paket == 0) {
                      $harga =  ($row->harga+$row->biaya_tambahan+$row->tambahan_rompi)/5;
                    }
                    else {
                      $harga =  $row->harga+$row->biaya_tambahan+$row->tambahan_rompi;
                    }
                    if ($row->flag_status == 5) {
                        $batal_transaksi = $jml_batal_transaksi*20000;
                    }
                    else {
                        $selesai_transaksi += $harga;
                    }
                    $total_pesanan = $batal_transaksi+$selesai_transaksi;
                    
                ?>
                <th scope="row">{{$loop->iteration}}</th>
                <td class="text-uppercase">
                    @if ($row->paket == 0)
                        {{ $row->nama_member }}
                    @else
                        {{ $row->nama_non_member }}
                    @endif
                </td>
                <td>{{ \Carbon\Carbon::parse($row->tanggal)->format('d-M-y')}}</td>
                <td>{{ \Carbon\Carbon::parse($row->jam)->format('H:i')}}</td>
                <td>{{ \Carbon\Carbon::parse($row->updated_at)->format('d/m/Y H:i')}}</td>
                <td>
                    <h3 @if ($row->flag_status==4)
                        class="badge bg-success text-light text-center"
                        @endif class="badge bg-danger text-light sm"
                        >{{$row->deskripsi}}</h3>
                </td>
                <td>
                    @if($row->paket == 0)
                        <h3 class="badge bg-info text-light text-center">MEMBER</h3>
                    @else
                        <h3 class="badge bg-warning text-light sm">NON MEMBER</h3>
                    @endif
                </td>
                <td>
                    @if($row->flag_status != 5) 
                    {{$row->harga+$row->biaya_tambahan+$row->tambahan_rompi}}
                    @else 
                    20000
                    @endif
                </td>
                <td class="text-center">
                        <button onclick="detail_keuangan_futsal({{$row->jadwal}})" class="badge bg-primary text-light"><i class="fas fa-info-circle mx-1"></i>Detail</button>
                </td>
            </tr>
            @endforeach
        </tbody>
        
        <tfoot class="bg-light">
            <tr>
                <td class="font-weight-bold font-italic" colspan="8">BATAL TRANSAKSI</td>
                <td>{{ $batal_transaksi }}</td>
            </tr>
            <tr>
                <td class="font-weight-bold font-italic" colspan="8">SELESAI PESANAN</td>
                <td>{{ $selesai_transaksi }}</td>
            </tr>
            <tr>
                <td class="font-weight-bold font-italic" colspan="8">TOTAL</td>
                <td>{{ $total_pesanan }}</td>
            </tr>
        </tfoot>
    </table>
</div>



<!-- Detail Keuangan Futsal -->
<div class="modal fade" id="DetailKeuanganFutsal" tabindex="-1" role="dialog"
    aria-labelledby="DetailKeuanganFutsalLabel" aria-hidden="true" data-backdrop="false">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <form method="POST">
                @csrf
                <div class="modal-header">
                    <h5 class="modal-title" id="DetailKeuanganFutsalLabel">Detail Laporan Futsal</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="refresh-keuangan-futsal">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function detail_keuangan_futsal(jadwal) {
        var token = '{{ csrf_token() }}';
        $.ajax({
            method: 'POST',
            url: "{{url('detail_keuangan_futsal')}}",
            data: {
                '_token': token,
                'jadwal': jadwal
            },
            success: function (resp) {
                $("#refresh-keuangan-futsal").html(resp);
                $('#DetailKeuanganFutsal').modal('show');
            },
            error: function(resp){
                console.log(resp);
            }
        });
    }

    function filtertanggalfutsal() {
        var filtertanggal1 = $('#tanggal1').val();
        var filtertanggal2 = $('#tanggal2').val();
        var status = $('#status').val();
        var token = '{{csrf_token()}}';
        var myurl = "{{url('filtertanggalmaen')}}";
        var formDataFilter = {
            '_token': token,
            'tanggalfilter1': filtertanggal1,
            'tanggalfilter2': filtertanggal2,
            'status': status
        }
        $.ajax({
            method: 'post',
            url: myurl,
            data: formDataFilter,
            success: function (resp) {

                $("#refresh").html(resp);
            }
        })
    }

</script>
@endsection
@endif



{{--========================================= ROLE MEMBER====================================== --}}

@if(Auth::user()->role_id == 3)
@section('title','Paket Anda')
@section('section-header','Paket Anda')

@section('content')
    @if (session('status'))
    <div class="alert alert-info">
        {{ session('status') }}
    </div>
    @elseif (session('reschedule'))
    <div class="alert alert-warning">
        {{ session('reschedule') }}
    </div>
    @endif
    <div class="alert alert-danger text-uppercase">
           <strong>Perhatian ! Reschedule H-1 booking</strong>
    </div>
    <div class="alert alert-info ">
           <strong class="text-uppercase">Harga Member Rp.350.000</strong>
           <p >5 Kali pertandingan bonus air mineral & rompi ganti jadwal sepuasnya</p>
    </div>
<button type="button" class="btn btn-primary mb-3" onclick="pesanMember()">
    <i class="fas fa-user-plus mx-1"></i>Masukan Pemesanan
</button>
<br>
<?php
    $isHidden = 'hidden';
    foreach ($member as $item){
        if($item->flag_status > 2){
            $isHidden = 'hidden';
        }else if ($cek_jumlah_pesanan->jml_pesanan >= 5){
            $isHidden = '';
        }else{
            $isHidden = 'hidden';
        }
    }
?>
<a href="{{url('/resi_member')}}" class="btn btn-success mb-3" {{$isHidden}}>
    <i class="fas fa-shopping-cart"></i> Lanjut Pembayaran
</a>

<table class="table table-hover">
    <thead>
        <tr>
            <th scope="col" class="text-center">No</th>
            <th scope="col" class="text-center">Tanggal Pertandingan</th>
            <th scope="col" class="text-center">Jadwal Pertandingan</th>
            <th scope="col" class="text-center">Status</th>
            <th scope="col" class="text-center">Action</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($member as $raw)
        <tr>
            <th scope="row" class="text-center">{{$loop->iteration}}</th>
            <td class="text-center">{{ \Carbon\Carbon::parse($raw->tanggal_pertandingan)->format('d/m/Y')}}</td>
            <td class="text-center">{{ \Carbon\Carbon::parse($raw->jam_pertandingan)->format('H:i')}}</td>
            <td class="text-center"><h3 @if ($raw->flag_status == 1)
                        class="badge bg-warning text-light text-center"
                        @endif class="badge bg-success text-light sm"
                        >{{$raw->status_deskripsi}}
                    </h3></td>
            <td class="text-center">
                @if ($date_now_1 < $raw->tanggal_pertandingan)
                    <button class="badge bg-primary text-light text-center" data-toggle="modal" data-target="#exampleModal{{$raw->jadwal}}">Ganti Jadwal</button>
                @else
                    <h3 class="badge bg-info text-light text-center">JADWAL TIDAK DAPAT DIUBAH</h3>
                @endif
                
            </td>
        </tr>
        @endforeach
    </tbody>
</table>

<div class="modal fade" tabindex="-1" id="modalPesanMember" data-backdrop="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Pesan Member</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="isi_pesan_member">
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
@foreach ($member as $raw)
    <div class="modal fade" id="exampleModal{{$raw->jadwal}}" data-backdrop="false" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Pesan Lapangan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                <form method="POST" action="/reschedule_pesanan">
                        @csrf
                        <div class="form-group">
                            <label for="tang">Tanggal</label>
                            <input type="date" class="form-control @error ('tanggal') is-invalid @enderror" id="tanggal_re_{{ $raw->jadwal }}"
                                placeholder="Pilih tanggal" name="tanggal" value="{{$raw->tanggal_pertandingan}}" {{old('tanggal')}}>
                            @error('tanggal')
                            <div class="invalid-feedback">
                                {{$message}}
                            </div>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="tang">Jam</label>
                            <select name="jam" class="form-control @error ('jam') is-invalid @enderror" id="jam_re_{{ $raw->jadwal }}">
                                @error('jam')
                                <div class="invalid-feedback">
                                    {{$message}}
                                </div>
                                @enderror
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '08:00') selected @endif value="08:00">08:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '09:00') selected @endif value="09:00">09:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '10:00') selected @endif value="10:00">10:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '11:00') selected @endif value="11:00">11:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '12:00') selected @endif value="12:00">12:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '13:00') selected @endif value="13:00">13:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '14:00') selected @endif value="14:00">14:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '15:00') selected @endif value="15:00">15:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '16:00') selected @endif value="16:00">16:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '17:00') selected @endif value="17:00">17:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '18:00') selected @endif value="18:00">18:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '19:00') selected @endif value="19:00">19:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '20:00') selected @endif value="20:00">20:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '21:00') selected @endif value="21:00">21:00</option>
                                <option @if (substr($raw->jam_pertandingan, 0, 5) == '22:00') selected @endif value="22:00">22:00</option>
                            </select>
                        </div>
                </div>
                <input type="text" id="id_jadwal" name="id_jadwal" value="{{ $raw->jadwal }}" hidden>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                    <button hidden type="submit" class="btn btn-primary" id="reschedule">Pesan</button>
                    <button type="button" class="btn btn-primary" onclick="cekReschedule({{ $raw->jadwal }})">Pesan</button>
                </div>
                </form>
            </div>
        </div>
    </div>
@endforeach
<input type="text" name="user_id" id="user_id" value="{{ Auth::user()->id }}" hidden>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

    function cekPesanan() {
        var tanggal = $("#tanggal").val();
        var jam = $("#jam").val();
        var token = '{{ csrf_token() }}';
        var date_now = '{{$date_now}}';

        if(tanggal < date_now){
            alert("Anda tidak dapat memesan dengan tanggal kurang dari tanggal hari ini");
        }else{
            $.ajax({
                method: "POST",
                url: '{{url('check_pesanan')}}',
                data: {
                    '_token': token,
                    'jam': jam,
                    'tanggal': tanggal
                },
                dataType: "json",
                success: function (res) {
                    if (res.exists) {
                        alert("Jam Sudah Di Pesan");
                    } else {
                        return cekJumlah();
                    }
                },
                error: function (jqXHR, exception) {

                }
            });
        }

    }
    function cekReschedule(id_jadwal) {
        var tanggal = $("#tanggal_re_"+id_jadwal).val();
        var jam = $("#jam_re_"+id_jadwal).val();
        var token = '{{ csrf_token() }}';
        console.log(tanggal,jam);

        $.ajax({
            method: "POST",
            url: '{{url('check_pesanan')}}',
            data: {
                '_token': token,
                'jam': jam,
                'tanggal': tanggal
            },
            dataType: "json",
            success: function (res) {
                if (res.exists) {
                    alert("Jam Sudah Di Pesan");
                } else {
                    document.getElementById("reschedule").click();
                }
            },
            error: function (jqXHR, exception) {

            }
        });

    }

    function cekJumlah() {
        var user_id = $("#user_id").val();
        var jam = $("#jam").val();
        var token = '{{ csrf_token() }}';
        var my_url = "{{url('/cek_jumlah_pesanan')}}";
        var formData = {
                    '_token': token, 
                    'user_id': user_id
                  };

        $.ajax({
              method: 'POST',
              url: my_url,
              data: formData,
              dataType: 'json',
              success: function(data){
                $.each(data, function(i,n){
                    if(n["jml_pesanan"] >= 5){
                        alert('Maaf jumlah pesanan anda sudah melebihi batas!,Silahkan Checkout');
                        location.reload();
                    }
                    else {
                        document.getElementById("submit_pesan").click();
                  }
                });
              },
                  error: function (resp){
                        console.log(resp);
                      }

            });

    }
    
    function pesanMember() {
        var token = '{{ csrf_token() }}';
        $.ajax({
            method: 'post',
            url: '{{url('detail_pesan_member ')}}',
            data: {'_token': '{{csrf_token()}}'
            },
            success: function (resp) {
                $('#modalPesanMember').modal('show');
                $('.modal-backdrop').removeAttr('modal-backdrop');
                $("#isi_pesan_member").html(resp);
            },
            error: function (resp) {
                console.log(resp);
            }
        });
    }

</script>

@endsection
@endif