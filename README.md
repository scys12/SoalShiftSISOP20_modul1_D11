# Laporan Praktikum Modul 1 Sistem Operasi

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
a=`awk -F "\t" 'FNR == 1 {next} {totalRegion[$13]+=$21} 
    END{for(region in totalRegion){print totalRegion[region],region}}' 
        Sample-Superstore.tsv | sort -g | awk 'NR<2{print $2}'`
echo 'Region dengan profit terendah adalah' $a
```

b)
```
b=`awk -F "\t" -v resultA="$a" 'FNR == 1 {next} {if($13 ==resultA) totalState[$11]+=$21} 
    END{for(state in totalState){print totalState[state],state}}' 
        Sample-Superstore.tsv | sort -g | awk 'NR<3{print $2}'`
firstState=`echo "$b" | sed -n "1p"`
secondState=`echo "$b" | sed -n "2p"`

echo -e '\n2 State dengan profit terendah adalah'  $firstState "dan" $secondState
```

c)
```
c=`awk -F "\t" -v firstState="$firstState" -v secondState="$secondState" 'FNR == 1 {next} 
    {if($11 == firstState || $11 == secondState) totalProduct[$17]+=$21} 
        END{for(product in totalProduct){print totalProduct[product]"=="product}}' 
            Sample-Superstore.tsv | sort -g | awk -F "==" 'NR<11{print $2}'`
echo -e '\n10 Produk dengan profit terendah adalah :\n'"$c"
```
**Penjelasan**
---

a)

*```

* ``` {totalRegion[$13]+=$21} ``` Array yang bernama totalRegion memiliki indeks berupa kolom 13 dan isi dari array itu akan dijumlahkan dengan kolom 21 yang sebaris. 

* ```{for(region in totalRegion){print totalRegion[region],region}}' ``` Perintah ini berguna untuk looping dengan menggunakan indeks region dalam array totalRegion, setelah itu akan dicetak isi dari array totalRegion berindeks region beserta nama regionnya. 

* ```awk 'NR<2{print $2}'``` Karena diminta untuk menampilkan hanya 1, maka digunakan sintaks NR<2 agar menampilkan profit yang terendah lalu print argumen kedua yaitu region.

* ```echo 'Region dengan profit terendah adalah' $a``` Print hasil dari a

b)

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

* ``` 'FNR == 1 {next}``` Agar baris pertama dalam Sample-Superstore.tsv tidak diikutkan dalam operasi awk.

* ```sort -g``` Sorting nilai terendah ke tertinggi

* ```END``` Digunakan agar kode dijalankan hanya sekali saja

2. Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.
HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script

**Jawaban** 
---
Enkripsi: 
```
#!/bin/bash

create=`date '+%H'`
filename=${1%.txt}
rotation=$((${create} % 26))
padding=$(printf "%${rotation}s")
newFileName=$(echo "$filename" | tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z")
newFileName=$newFileName.txt
head /dev/urandom | tr -dc A-Za-z0-9 | head -c28 > $newFileName
```

Dekripsi: 
```
#!/bin/bash

dateModified=`date -r $1 "+%H"`
filename=${1%.txt}
rotation=$((26-(${dateModified} % 26)))
padding=$(printf "%${rotation}s")
newFileName=$(echo "$filename" | tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z")
newFileName=$newFileName.txt
mv $1 $newFileName
```
**Penjelasan**
---
Enkripsi: 
* ```create=`date '+%H'``` Untuk mengetahui waktu pembuatan file kemudian disimpan dalam variable create

* ```filename=${1%.txt}``` Membuat sebuah variabel yang bernama filename yang berisikan nama file yang dibuat dengan 1% untuk menyimpan argumen yang diinputkan.

* ``` rotation=$((${create} % 26)) ```

* ```padding=$(printf "%${rotation}s")```
