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

**Soal 1:** 
---
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit.

b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a.

c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b.

Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.
*Gunakan Awk dan Command pendukung*

**Jawaban**: 
---

a)

```bash
a=`awk -F "\t" 'FNR == 1 {next} {totalRegion[$13]+=$21} 
    END{for(region in totalRegion){print totalRegion[region],region}}' 
        Sample-Superstore.tsv | sort -g | awk 'NR<2{print $2}'`
echo 'Region dengan profit terendah adalah' $a
```

**Penjelasan**
---

```awk -F "\t"``` berguna untuk menjadi separator antar kolom yang dipisahkan dengan tab, lalu ```’FNR == 1 {next} ``` digunakan agar baris pertama dalam Sample-Superstore.tsv tidak diikutkan dalam proses operasi awk ```{totalRegion[$13]+=$21} 
    END{for(region in totalRegion){print totalRegion[region],region}}' 
        Sample-Superstore.tsv | ``` yaitu pada data Sample-Superstore.tsv dilakukan proses yang dimulai dari array yang bernama totalRegion memiliki indeks berupa kolom 13 dan isi dari array tersebut akan dijumlahkan dengan kolom 21 yang sebaris. Lalu terdapat perintah looping dengan menggunakan indeks region dalam array totalRegion, setelah itu akan dicetak isi dari array totalRegion berindeks region beserta nama regionnya. ```END``` berfungsi agar kode hanya dijalankan satu kali saja. Setelah proses tersebut selesai, maka dilakukan sorting menggunakan ``` sort –g | ``` untuk mengurutkan nilai terendah ke nilai tertinggi, setelah diurutkan maka akan ditampilkan hanya 1 baris, dan kan mencetak argumen kedua yaitu nama regionnya saja dengan sintaks ```awk 'NR<2{print $2}' ``` .


b)
```bash
b=`awk -F "\t" -v resultA="$a" 'FNR == 1 {next} {if($13 ==resultA) totalState[$11]+=$21} 
    END{for(state in totalState){print totalState[state],state}}' 
        Sample-Superstore.tsv | sort -g | awk 'NR<3{print $2}'`
firstState=`echo "$b" | sed -n "1p"`
secondState=`echo "$b" | sed -n "2p"`

echo -e '\n2 State dengan profit terendah adalah'  $firstState "dan" $secondState
```

**Penjelasan**
---

```awk -F "\t"``` berguna untuk menjadi separator antar kolom yang dipisahkan dengan tab lalu digunakan ```-v resultA="$a"``` untuk memberi akses awk kepada variabel resultA dengan nilai a yang didapat dari soal nomor 1a. Kemudian ```’FNR == 1{next} ``` digunakan agar baris pertama dalam Sample-Superstore.tsv tidak diikutkan dalam proses operasi awk lalu untuk ```{if($13 ==resultA) totalState[$11]+=$21}``` berguna untuk cek apakah $13 itu sama dengan hasil dari resultA, kemudian sebuah array yang bernama totalState dengan indeks kolom 11 yang kemudian dijumlahkan dengan kolom 21 yang sebaris. Lalu dilakukan looping dengan ```{for(state in totalState){print totalState[state],state}}' Sample-Superstore.tsv```  menggunakan indeks state dalam array totalState, setelah itu akan dicetak isi dari array totalState berindeks state beserta nama regionnya. ```END``` berfungsi agar kode dijalankan sekali saja. Ketika kode telah dijalankan, maka dilanjutkan dengan sorting menggunakan ``` sort –g |``` untuk mengurutkan nilai dari yang terendah ke nilai tertinggi. Ketika sudah diurutkan maka dilakukan ```awk ‘NR<3{print $2}’``` untuk melakukan print argumen kedua pada 2 baris teratas. ```firstState=`echo "$b" | sed -n "1p"` dan secondState=`echo "$b" | sed -n "2p"``` untuk menampilkan baris pertama dan keduanya.


c)
```bash
c=`awk -F "\t" -v firstState="$firstState" -v secondState="$secondState" 'FNR == 1 {next} 
    {if($11 == firstState || $11 == secondState) totalProduct[$17]+=$21} 
        END{for(product in totalProduct){print totalProduct[product]"=="product}}' 
            Sample-Superstore.tsv | sort -g | awk -F "==" 'NR<11{print $2}'`
echo -e '\n10 Produk dengan profit terendah adalah :\n'"$c"
```

**Penjelasan**
---

```awk –F “\t” ``` berguna untuk menjadi separator antar kolom yang dipisahkan dengan tab lalu digunakan ```-v firstState="$firstState" -v secondState="$secondState"``` untuk memberi akses awk kepada variabel firstState dan variabel secondState dengan nilai firstState dan secondState dari soal 1b. ```'FNR == 1 {next} ``` digunakan agar baris pertama dalam Sample-Superstore.tsv tidak diikutkan dalam proses operasi awk lalu untuk ```{if($11 == firstState || $11 == secondState) totalProduct[$17]+=$21} 
        END{for(product in totalProduct){print totalProduct[product]"=="product}}' 
            Sample-Superstore.tsv | ``` potongan kode tersebut dimulai dari proses pengecekan apakah kolom 11 sama dengan nilai dari firstState dan secondState kemudian array bernama totalProduct dengan indeks kolom 17 dijumlahkan dengan kolom 21 yang sebaris. Selanjutnya dilakukan looping dengan menggunakan indeks product dalam array totalProduct, yang kemudian akan dicetak isi dari array totalProduct dengan indeks product beserta nama productnya dengan pemisah berupa “==”, kemudian dilakukan sorting menggunakan sintaks ``` sort –g |``` untuk mengurutkan nilai terendah ke nilai tertinggi.``` awk -F "==" 'NR<11{print $2}'``` berguna untuk separator antar kolom yang dipisahkan dengan “==” kemudian print argumen kedua yang berada di 10 baris pertama.


**Soal 2:** 
---
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
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
```bash
#!/bin/bash

create=`date '+%H'`
create=10#$create
filename=${1%.txt}
rotation=$((${create} % 26))
padding=$(printf "%${rotation}s")
newFileName=$(echo "$filename" | tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z")
newFileName=$newFileName.txt
for((i=1;i<=28;i++))
do
    if (( $i % 3 == 1 ))
    then
        char=`head /dev/urandom | tr -dc A-Z| head -c 1`
        password+=$char
    fi
    if (( $i % 3 == 2 ))
    then
        char=`head /dev/urandom | tr -dc a-z| head -c 1`
        password+=$char
    fi
    if (( $i % 3 == 0 ))
    then
        char=`head /dev/urandom | tr -dc 0-9| head -c 1`
        password+=$char
    fi
done
echo "$password" > $newFileName
```
**Penjelasan**
---
Enkripsi:

``` create=`date '+%H' ``` berguna untuk mengekstrak jam yang ada disistem untuk disimpan ke variable ```create```. Disini variabel ```create``` menginterpretasi jam sebagai bilangan oktal untuk jam 00-09 dan bilangan oktal hanya berlaku untuk digit 0-7. Jika kita mengakses pada jam 08-09 akan terjadi error sehingga untuk mengatasinya ditambah ``` create=10#$create ``` untuk membuat variable ```create``` untuk menghilangkan angka 0 didepan. ``` filename=${1%.txt} ``` untuk mengambil nama file tanpa menyertakan ekstensinya yaitu .txt.

Lalu bagian ``` rotation=$((${create} % 26)) ``` berguna untuk melakukan operator aritmatika variable ```create``` modulo 26. ``` padding=$(printf "%${rotation}s") ``` berguna untuk membuat variable ``` padding ``` menyimpan hasil. ``` tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z") ``` berguna untuk merubah isi dari variable ```filename```. Huruf di variable ```filename``` akan tershift dengan cara menambahkan huruf dengan variable ```padding``` dan disimpan di variable ```newFileName```. ```newFileName=$newFileName.txt``` akan ditambahkan ekstensi .txt dibelakang isi variable ```newFileName```. 

Lalu perintah soalnya membuat 28 karakter yang berisi **setidaknya** mempunyai huruf kecil, huruf besar, dan angka. Konsep jawaban disini adalah setiap karakter ke 1,4,7,10,13,16,19,22,25,28 pasti berisi huruf random kapital dan dimasukkan ke akhir dari isi variable ```password```. Sedangkan untuk setiap karakter ke 2,5,8,11,14,17,20,23,26 pasti berisi huruf random yang kecil dan dimasukkan ke akhir dari isi variable ```password```. Dan untuk setiap karakter ke 3,6,9,12,15,18,21,24,27 pasti berisi angka random dan dimasukkan ke akhir dari isi variable ```password```. Lalu isi string variable ```password``` akan dimasukkan ke file dengan nama variable ```newFileName```.

Dekripsi: 
```bash
#!/bin/bash

dateModified=`date -r $1 "+%H"`
dateModified='10#$dateModified
filename=${1%.txt}
rotation=$((26-(${dateModified} % 26)))
padding=$(printf "%${rotation}s")
newFileName=$(echo "$filename" | tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z")
newFileName=$newFileName.txt
mv $1 $newFileName
```
**Penjelasan**
---
Dekripsi: 

``` dateModified=`date -r $1 "+%H"` ``` berguna untuk mengekstrak jam yang ada file bernama argumen 1 dimana jam yang diekstrak berupa jam terakhir file dimodifikasi untuk disimpan ke variable ```dateModified```. Disini variabel ```dateModified``` menginterpretasi jam sebagai bilangan oktal untuk jam 00-09 dan bilangan oktal hanya berlaku untuk digit 0-7. Jika kita mengakses pada jam 08-09 akan terjadi error sehingga untuk mengatasinya ditambah ``` dateModified=10#$dateModified ``` untuk membuat variable ```dateModified``` untuk menghilangkan angka 0 didepan. ``` filename=${1%.txt} ``` untuk mengambil nama file tanpa menyertakan ekstensinya yaitu .txt.

Lalu bagian ``` rotation=$((26-(${dateModified} % 26))) ``` berguna untuk melakukan operator aritmatika variable ```dateModified``` modulo 26 lalu hasilnya dikurangi 26(Konsep dekripsi ini bukan untuk mengurangi huruf dengan bilangan yang ada di variable ```rotation``` tapi untuk menambah huruf dengan ```rotation```( bilangan 26 dikurangi variable ```dateModified```)). ``` padding=$(printf "%${rotation}s") ``` berguna untuk membuat variable ``` padding ``` menyimpan hasil. ``` tr "${padding}a-z" "a-za-z" | tr "${padding}A-Z" "A-ZA-Z") ``` berguna untuk merubah isi dari variable ```filename```. Huruf di variable ```filename``` akan tershift dengan cara menambahkan huruf dengan variable ```padding``` dan disimpan di variable ```newFileName```. ```newFileName=$newFileName.txt``` akan ditambahkan ekstensi .txt dibelakang isi variable ```newFileName```. ``` mv $1 $newFileName ``` akan merubah nama file yang ada di argumen 1 menjadi  isi dari  variable```newFileName```.


**Soal 3:** 
---
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

**Jawaban**: 
---

a)

```bash
#!/bin/bash

lastNumber=$(ls | sed 's/pdkt_kusuma_//' | sort -n | tail -1)
if [[ !($lastNumber =~ [0-9]) ]];then
    lastNumber=0
elif [[ ($lastNumber =~ [0-9]) && ($lastNumber =~ [a-zA-Z]) ]];then
    lastNumber=0
fi
echo $lastNumber
for ((i=lastNumber+1; i<=lastNumber+28; i++))
do
    wget -O "pdkt_kusuma_${i}" "https://loremflickr.com/320/240/cat" 2>&1 | tee -a wget.log
done
```

**Penjelasan**
---

``` ls | sed 's/pdkt_kusuma_//' ``` berguna untuk menampilkan file yang bernama ``` pdkt_kusuma_```, dan menghilangkan nama dari suatu file jika dia memiliki nama ```pdkt_kusuma_```(berarti yang tersisa hanya angka). Lalu perintah ``` sort -n ``` untuk mengurutkan angka dari yang terkecil ke terbesar. Karena file ``` pdkt_kusuma_``` mempunyai angka dibelakang sehingga akan terurut dari nomor terkecil ke terbesar. Lalu ``` tail -1 ``` untuk menampilkan angka terbesar dan akan di simpan di variable ```lastNumber```.

```
if [[ !($lastNumber =~ [0-9]) ]];then
    lastNumber=0
elif [[ ($lastNumber =~ [0-9]) && ($lastNumber =~ [a-zA-Z]) ]];then
    lastNumber=0
fi
```
Jika misalnya belum ada file bernama pdkt_kusuma yang berarti hanya ada file bernama soal3a.sh, maka variable ```lastNumber``` akan berisi nama file yang ada di folder dan tentunya itu tidak diinginkan. Dan itu artinya bahwa belum ada file bernama ``` pdkt_kusuma_angka``` terdownload. Sehingga kita membuat variable ``` lastNumber ``` menjadi 0.

```
for ((i=lastNumber+1; i<=lastNumber+28; i++))
do
    wget -O "pdkt_kusuma_${i}" "https://loremflickr.com/320/240/cat" 2>&1 | tee -a wget.log
done
```

berguna untuk menjadikan indeks i berupa bilangan yang di variable ```lastNumber```  ditambah 1 dan mendownload sebanyak 28 kali di url ```https://loremflickr.com/320/240/cat``` dengan nama file ```pdkt_kusuma_${i}``` dan akan meredirect stderr dari hasil mendownload menjadi stdinp file ```wget.log```.


b)
Pertama buka terminal lalu ketikkan
``` 
crontab -e
```
lalu setelah file crontab terbuka ketik
```
5 6-23/8 * * 0-5 /home/samuel/Documents/Sisop/Modul1/SoalPraktikum/soal3/soal3a.sh
```
yang berarti file yang bernama ```soal3a.sh``` akan dijalankan tepat pukul 5 menit setiap 5 jam mulai jam 6 pagi hingga 11 malam pada hari Minggu hingga Jumat.

c)
```bash
#!/bin/bash

curr=$(pwd)
loc=($(awk -F "/" '/^Location: /{ url[i++] = $4 }/Saving to: /{ filename[j++] = $NF }
    END{for(k=0;k<i;k++)print url[k]","filename[k]}' wget.log | awk -F "," 'a[$1]++{print $2}' | sed 's/Saving to: //g'))

for num in "${loc[@]}"; do
    fileNumber=`echo $num | sed "s/[^0-9]//g"`
    nameFile=$(ls *$fileNumber*)
    newName="duplicate_$fileNumber"
    
    mv $nameFile $newName
    if [[ ! -d "$curr/duplicate" ]]; then
	    mkdir duplicate
    fi
    mv $newName "duplicate/"
done

for file in pdkt_kusuma_*
do
    fileNumber=`echo $file | sed "s/[^0-9]//g"`
    newName="kenangan_$fileNumber"
    mv $file $newName
    if [[ ! -d "$curr/kenangan" ]]; then
	    mkdir kenangan
    fi
    mv $newName "kenangan/"
done
mv "wget.log" "wget.log.bak"
```

**Penjelasan**
---

``` curr=$(pwd) ``` mengakses direktori dimana file dibuat
```
awk -F "/" '/^Location: /{ url[i++] = $4 }/Saving to: /{ filename[j++] = $NF }
    END{for(k=0;k<i;k++)print url[k]","filename[k]}' wget.log 
```
berfungsi untuk menjalankan awk dengan pemisah "/" dengan pola seleksi yaitu "Location: ". Jika ditemukan pola "Location: " maka akan mengopi baris tersebut kedalam array url. Lalu untuk pola seleksi "Saving to: ", jika ditemukan baris yang ada pola tersebut akan dikopi baris tersebut kedalam array filename. Lalu akan diprint berupa array url dan filename.

```
awk -F "," 'a[$1]++{print $2}' | sed 's/Saving to: //g'))
```

berfungsi untuk menjalankan awk dengan pemisah "," dan inputan berupa hasil yaitu array url dan filename dan akan dihilangkan kalimat yang mempunyai pattern "Saving to: " dan disimpan di variable ```loc```

```
for num in "${loc[@]}"; do
    fileNumber=`echo $num | sed "s/[^0-9]//g"`
    nameFile=$(ls *$fileNumber*)
    newName="duplicate_$fileNumber"
    
    mv $nameFile $newName
    if [[ ! -d "$curr/duplicate" ]]; then
	    mkdir duplicate
    fi
    mv $newName "duplicate/"
done
```
Pertama, iterasi menggunakan variable ```num``` di array yang bernama ```loc``` yang telah kita olah sebelumnya. ```fileNumber=`echo $num | sed "s/[^0-9]//g"` ```berguna untuk mengambil angkanya yang berasal dari variable ```num``` dan disimpan di variable ```fileNumber```.``` nameFile=$(ls *$fileNumber*) ``` berguna menampilkan semua file yang memiliki angka sesuai dengan variable ```filNumber``` dan ditaruh di variable ```nameFile```, lalu diganti namanya menjadi duplicate_nomor file tersebut. Setelah itu dibuat direktori bernama duplicate jika belum ada dan dipindahkan file yang isinya ada di variable ```newName``` ke direktori duplicate

```
for file in pdkt_kusuma_*
do
    fileNumber=`echo $file | sed "s/[^0-9]//g"`
    newName="kenangan_$fileNumber"
    mv $file $newName
    if [[ ! -d "$curr/kenangan" ]]; then
	    mkdir kenangan
    fi
    mv $newName "kenangan/"
done
mv "wget.log" "wget.log.bak"

```

``` file in pdkt_kusuma_* ```berguna untuk mengiterasi semua file yang bernama ```pdkt_kusuma_```(jadi yang dilooping hanya file bernama pdkt_kusuma_). variable fileNumber akan berisi dengan angka yang ada di nama file pdkt_kusuma_ yang sedang diiterasi. lalu file akan diganti namanya menjadi kenangan_fileNumber dan disimpan di variable ```newName``` dan dibuat direktori baru jika belum ada yang bernama kenangan. File yang sedang dipilih akan dipindah ke direktori baru tersebut. Lalu setelah semua proses selesai, file wget.log akan diganti menjadi wget.log.bak
