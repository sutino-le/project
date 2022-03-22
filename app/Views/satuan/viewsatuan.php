<?= $this->extend('main/layout'); ?>

<?= $this->section('judul') ?>
<?= $judul ?>
<?= $this->endSection('judul') ?>

<?= $this->section('subjudul') ?>
<?= $subjudul ?>
<?= $this->endSection('subjudul') ?>

<?= $this->section('isi') ?>


<div class="card">
    <div class="card-header">
        <?= form_button('', '<i class="fa fa-plus-circle"></i> Tambah Data', [
            'class'     => 'btn btn-sm btn-primary',
            'onclick'   => "location.href=('" . site_url('satuan/formtambah') . "')"
        ]) ?>
    </div>
    <!-- /.card-header -->
    <div class="card-body">

        <?= session()->getFlashdata('sukses'); ?>
        <?= ""; //form_open('satuan/index'); 
        ?>
        <!-- <div class="input-group mb-3">
            <input type="text" name="cari" value="<?= ""; //$cari; 
                                                    ?>" class="form-control" placeholder="Cari data Satuan"
                aria-label="Cari data Satuan" aria-describedby="button-addon2">
            <div class="input-group-append">
                <button class="btn btn-outline-primary" type="submit" id="tombolcari" name="tombolcari"><i
                        class="fas fa-search"></i></button>
            </div>
        </div> -->
        <?= ""; //form_close(); 
        ?>

        <table id="example1" class="table table-sm table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Nama Satuan</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // $no = 1 + (($nohalaman - 1) * 5);
                $no = 1;
                foreach ($tampildata as $row) :
                ?>
                <tr>
                    <td><?= $no++; ?></td>
                    <td><?= $row['satnama']; ?></td>
                    <td>
                        <button type="button" class="btn btn-sm btn-info" title="Edit Data"
                            ondblclick="edit('<?= $row['satid'] ?>')"><i class="fas fa-edit"></i></button>
                        <button type="button" class="btn btn-sm btn-danger" title="Hapus Data"
                            ondblclick="hapus('<?= $row['satid'] ?>')"><i class="fas fa-trash-alt"></i></button>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <!-- <div class="float-center m-1">
            <?= ""; //$pager->links('satuan', 'paging'); 
            ?>
        </div> -->
    </div>
    <!-- /.card-body -->
</div>
<!-- /.card -->

<script>
function edit(id) {
    window.location = ('/satuan/formedit/' + id);
}

function hapus(id) {
    $pesan = confirm('Apakah Anda ingin menghapus data satuan ?');

    if ($pesan) {
        window.location = ('/satuan/hapus/' + id);
    } else {
        return false;
    }
}
</script>


<?= $this->endSection('isi') ?>