# Laporan Resmi Sistem Operasi

**Anggota Kelompok**

Nama  : Samuel C. Y. Sinambela

NRP   : 05111840000036

Kelas : Sistem Operasi - D

Nama  : Ryukazu Andara S

NRP   : 05111840000129

Kelas : Sistem Operasi - D

Kelompok D11

**Asisten**

Nama  : Furqan Aliyuddien

NRP   : 05111740000124


**Departemen Teknik Informatika**

**Fakultas Teknik Elektro Dan Informatika Cerdas**

**Insitut Teknologi Sepuluh Nopember**

**Surabaya**

**2020**

Soal : 

1. Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :
a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.
*Gunakan Awk dan Command pendukung

**Jawaban**: 
a. 

...
a=`awk -F "\t" 'FNR == 1 {next} {totalRegion[$13]+=$21} END{for(region in totalRegion){print totalRegion[region],region}}' Sample-Superstore.tsv | sort -g | awk 'NR<2{print $2}'`
echo 'Region dengan profit terendah adalah' $a
...




