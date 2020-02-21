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

**Soal :** 
---
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
*Gunakan Awk dan Command pendukung*

**Jawaban**: 
---

a)

```
a=`awk -F "\t" 'FNR == 1 {next} {totalRegion[$13]+=$21} END{for(region in totalRegion){print totalRegion[region],region}}' Sample-Superstore.tsv | sort -g | awk 'NR<2{print $2}'`
echo 'Region dengan profit terendah adalah' $a
```

b)
```
b=`awk -F "\t" -v resultA="$a" 'FNR == 1 {next} {if($13 ==resultA) totalState[$11]+=$21} END{for(state in totalState){print totalState[state],state}}' Sample-Superstore.tsv | sort -g | awk 'NR<3{print $2}'`
firstState=`echo "$b" | sed -n "1p"`
secondState=`echo "$b" | sed -n "2p"`

echo -e '\n2 State dengan profit terendah adalah'  $firstState "dan" $secondState
```

c)
```
c=`awk -F "\t" -v firstState="$firstState" -v secondState="$secondState" 'FNR == 1 {next} {if($11 == firstState || $11 == secondState) totalProduct[$17]+=$21} END{for(product in totalProduct){print totalProduct[product]"->"product}}' Sample-Superstore.tsv | sort -g | awk -F "->" 'NR<11{print $2}'`
echo -e '\n10 Produk dengan profit terendah adalah :\n'"$c"
```
**Penjelasan**
---

a)

* ``` {totalRegion[$13]+=$21} ``` Array yang bernama totalRegion memiliki indeks berupa kolom 13 dan isi dari array itu akan dijumlahkan dengan kolom 21 yang sebaris. 

* ```{for(region in totalRegion){print totalRegion[region],region}}' ``` Untuk print jumlah region yang berada pada array totalRegion beserta nama regionnya saja.

* ``` Sample-Superstore.tsv``` Mengambil data pada Sample-Superstore.tsv, 

* ```sort -g``` Berguna untuk sorting nilai terendah ke tertinggi
* ```awk 'NR<2{print $2}'``` Karena diminta untuk menampilkan hanya 1, maka digunakan sintaks NR<2 agar menampilkan profit yang terendah lalu print argumen kedua yaitu region.

* ```echo 'Region dengan profit terendah adalah' $a``` Print hasil dari a

b)
* ``` awk -F "\t" ``` Digunakan sebagai separator antar kolom yang dipisah dengan tab atau "  "

* ``` -v resultA="$a" ``` Untuk memberi akses awk kepada variabel resultA dengan nilai a (dari soal 1a)

* ```{if($13 ==resultA) totalState[$11]+=$21} ```Digunakan untuk mengecek apakah $13 itu sama dengan hasil dari resultA, kemudian sebuah array yang bernama totalState dengan indeks kolom 11 yang kemudian dijumlahkan dengan kolom 21 yang sebaris.

* ```{for(state in totalState){print totalState[state],state}}'``` Untuk print jumlah state yang berada pada array totalState dan print nama statenya saja

* ```awk 'NR<3{print $2}'```Berguna untuk menampilkan 2 baris teratas lalu print argumen kedua yang merupakan nama state

* ``` firstState=`echo "$b" | sed -n "1p"``` Menampilkan baris pertama
* ``` secondState=`echo "$b" | sed -n "2p"``` Menampilkan baris kedua

c)
* ``` -v firstState="$firstState ``` Untuk memberi akses awk kepada variabel firstState dengan nilai dari firstState (soal 1b)

* ``` -v secondState="$secondState" ``` Untuk memberi akses awk kepada variabel secondState dengan nilai dari secondState (soal 1b)

* ``` {if($11 == firstState || $11 == secondState) totalProduct[$17]+=$21} ``` Cek apakah $11 sama dengan nilai dari firstState atau secondState kemudian array bernama totalProduct dengan indeks kolom 17 dijumlahkan dengan kolom 21 yang sebaris. 

* ``` {for(product in totalProduct){print totalProduct[product]"->"product}}' ```

* ``` awk -F "->" 'NR<11{print $2}' ``` 

**Poin-Poin**
---

* ``` `awk -F "\t"``` Digunakan sebagai separator antar kolom yang dipisah dengan tab atau "  "

* ``` 'FNR == 1 {next}``` Agar baris pertama dalam Sample-Superstore.tsv tidak dihitung dalam array.

* ```sort -g``` Sorting nilai terendah ke tertinggi

* ```END``` Digunakan agar kode dijalankan hanya sekali saja
