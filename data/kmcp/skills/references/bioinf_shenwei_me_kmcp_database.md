[ ]
[ ]

[Skip to content](#database)

[![logo](../favicon.svg)](.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")

KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

Databases

Initializing search

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

[![logo](../favicon.svg)](.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")
KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

* [Home](..)
* [Download](../download/)
* [ ]

  Databases
  [Databases](./)

  Table of contents
  + [Prebuilt databases](#prebuilt-databases)

    - [A). Databases for metagenomic profiling](#a-databases-for-metagenomic-profiling)
    - [B). Databases for genome similarity estimation](#b-databases-for-genome-similarity-estimation)
  + [Building databases](#building-databases)

    - [GTDB](#gtdb)
    - [RefSeq viral or fungi](#refseq-viral-or-fungi)
    - [Genbank viral](#genbank-viral)
    - [Human genome](#human-genome)
    - [Refseq plasmid](#refseq-plasmid)
  + [Building databases (prokaryotic genome collections)](#building-databases-prokaryotic-genome-collections)

    - [HumGut (30,691 clusters)](#humgut-30691-clusters)
    - [proGenomes](#progenomes)
  + [Building databases (viral genome collections)](#building-databases-viral-genome-collections)

    - [MGV](#mgv)
  + [Building custom databases](#building-custom-databases)

    - [Step 1. Computing k-mers](#step-1-computing-k-mers)
    - [Step 2. Building databases](#step-2-building-databases)
  + [Merging GTDB and NCBI taxonomy](#merging-gtdb-and-ncbi-taxonomy)
* [Usage](../usage/)
* [ ]

  Tutorials

  Tutorials
  + [Taxonomic profiling](../tutorial/profiling/)
  + [Detecting specific pathogens](../tutorial/detecting-pathogens/)
  + [Detecting contaminated sequences](../tutorial/detecting-contaminated-seqs/)
  + [Sequence and genome searching](../tutorial/searching/)
* [ ]

  Benchmarks

  Benchmarks
  + [Taxonomic profiling](../benchmark/profiling/)
  + [Sequence and genome searching](../benchmark/searching/)
* [FAQs](../faq/)
* [More tools](https://github.com/shenwei356)

Table of contents

* [Prebuilt databases](#prebuilt-databases)

  + [A). Databases for metagenomic profiling](#a-databases-for-metagenomic-profiling)
  + [B). Databases for genome similarity estimation](#b-databases-for-genome-similarity-estimation)
* [Building databases](#building-databases)

  + [GTDB](#gtdb)
  + [RefSeq viral or fungi](#refseq-viral-or-fungi)
  + [Genbank viral](#genbank-viral)
  + [Human genome](#human-genome)
  + [Refseq plasmid](#refseq-plasmid)
* [Building databases (prokaryotic genome collections)](#building-databases-prokaryotic-genome-collections)

  + [HumGut (30,691 clusters)](#humgut-30691-clusters)
  + [proGenomes](#progenomes)
* [Building databases (viral genome collections)](#building-databases-viral-genome-collections)

  + [MGV](#mgv)
* [Building custom databases](#building-custom-databases)

  + [Step 1. Computing k-mers](#step-1-computing-k-mers)
  + [Step 2. Building databases](#step-2-building-databases)
* [Merging GTDB and NCBI taxonomy](#merging-gtdb-and-ncbi-taxonomy)

# Database

## Prebuilt databases

All prebuilt databases and the used reference genomes are available at:

* [OneDrive](https://1drv.ms/u/s%21Ag89cZ8NYcqtjHwpe0ND3SUEhyrp?e=QDRbEC) for *global users*.
* [CowTransfer](https://shenwei356.cowtransfer.com/s/c7220dd5901c42) for *Chinese users and global users*.
  **Please click the "kmcp" icon on the left to browse directories of the current version, and choose each individual file to download.**.

Please check file integrity with `md5sum` after downloading the files:

```
md5sum -c *.kmcp.tar.gz.md5.txt
```

### A). Databases for metagenomic profiling

These databases are created following [steps below](#building-databases).
Users can also [build custom databases](#building-custom-databases), it's simple and fast.

**Current version**: v2023.05 ([OneDrive](https://1drv.ms/f/s%21Ag89cZ8NYcqtlgAtJo--uKPNVT4t?e=KEDFrc), [CowTransfer](https://shenwei356.cowtransfer.com/s/1c5dfb28218748))

| kingdoms | source | #NCBI-species | #assemblies | db-parameters | size |
| --- | --- | --- | --- | --- | --- |
| Bacteria and Archaea | GTDB r214 | 34395+ | 85205 | k=21, chunks=10; fpr=0.3, hashes=1 | 50+49 GB\* |
| Fungi | Refseq r217 | 491 | 496 | k=21, chunks=10; fpr=0.3, hashes=1 | 5.5 GB |
| Viruses | GenBank r255 | 26680 | 33479 | k=21, chunks=5; fpr=0.05, hashes=1 | 5.9 GB |

**Notes**: \*GTDB representative genomes were split into 2 parts to build relatively small databases
which can be filled into workstations with small RAM (around 64GB).
Users need to search reads on all these small databases and merge the results before running `kmcp profile`.

**Taxonomy information**: Either NCBI taxonomy or a combination of GTDB and NCBI are available:

* NCBI: taxdmp\_2023-05-01
* GTDB+NCBI: GTDB r214 + NCBI taxdmp\_2023-05-01

**Hardware requirements**

* Prebuilt databases were built for computers with >= 32 CPU cores
  in consideration of better parallelization,
  and computers should have at least 64 GB.
* By default, `kmcp search` loads the whole database into main memory
  (via [mmap](https://en.wikipedia.org/wiki/Mmap) by default) for fast searching.
  Optionally, the flag `--low-mem` can be set to avoid loading the whole database,
  while it's much slower, >10X slower on SSD and should be much slower on HDD disks.
* **To reduce memory requirements on computers without enough memory,
  users can split the reference genomes into partitions
  and build a smaller database for each partition, so that the biggest
  database can be loaded into RAM**.
  This can also **accelerate searching on a computer cluster, where every node searches against a small database.
  After performing database searching,
  search results from all small databases can be merged with `kmcp merge`
  for downstream analysis**.

### B). Databases for genome similarity estimation

Check the [tutorial](/kmcp/tutorial/searching).

FracMinHash (Scaled MinHash), links: [OneDrive](https://1drv.ms/f/s%21Ag89cZ8NYcqtlgEtskAjVVosItE7?e=CdkwhG), [CowTransfer](https://shenwei356.cowtransfer.com/s/21f68041334440)

| kingdoms | source | #NCBI-species | #assemblies | parameters | size |
| --- | --- | --- | --- | --- | --- |
| Bacteria and Archaea | GTDB r214 | 34395+ | 85205 | k=31, scale=1000 | 2.7 GB |
| Fungi | Refseq r217 | 491 | 496 | k=31, scale=1000 | 131 MB |
| **Viruses** | GenBank r255 | 26680 | 33479 | k=31, scale=10 | 2.0 GB |

## Building databases

### GTDB

Tools:

* [brename](https://github.com/shenwei356/brename/releases) for batching renaming files.
* [rush](https://github.com/shenwei356/rush/releases) for executing jobs in parallel.
* [seqkit](https://github.com/shenwei356/seqkit/releases) for FASTA file processing.
* [csvtk](https://github.com/shenwei356/csvtk/releases) for tsv/csv data manipulations.
* [taxonkit](https://github.com/shenwei356/taxonkit/releases) for NCBI taxonomy data manipulations.
* [kmcp](/kmcp/download) for metagenomic profiling.

Files (https://data.ace.uq.edu.au/public/gtdb/data/releases/latest/)

* representative genomes: gtdb\_genomes\_reps.tar.gz
* metagdata: ar53\_metadata.tar.gz
* metagdata: bac120\_metadata.tar.gz
* taxdump file: https://ftp.ncbi.nih.gov/pub/taxonomy/taxdump\_archive/

Uncompressing and renaming:

```
# uncompress
mkdir -p gtdb
tar -zxvf gtdb_genomes_reps.tar.gz -C gtdb

# rename
brename -R -p '^(\w{3}_\d{9}\.\d+).+' -r '$1.fna.gz' gtdb
```

Mapping file:

```
# assembly accession -> full head
find gtdb/ -name "*.fna.gz" \
    | rush -k 'echo -ne "{%@(.+).fna}\t$(seqkit sort --quiet -lr {} | head -n 1 | seqkit seq -n)\n" ' \
    > name.map

tar -zxvf ar53_metadata.tar.gz
tar -zxvf bac120_metadata.tar.gz

# assembly accession -> taxid
cat *_metadata*.tsv \
    | csvtk cut -t -f accession,ncbi_taxid \
    | csvtk replace -t -p '^.._' \
    | csvtk grep -t -P <(cut -f 1 name.map) \
    | csvtk del-header \
    > taxid.map

# stats (optional)
# taxdump is a directory containing NCBI taxdump files, including names.dmp, nodes.dmp, delnodes.dmp and merged.dmp
cat taxid.map  \
    | csvtk freq -Ht -f 2 -nr \
    | taxonkit lineage -r -n -L --data-dir taxdump/ \
    | taxonkit reformat -I 1 -f '{k}\t{p}\t{c}\t{o}\t{f}\t{g}\t{s}' --data-dir taxdump/ \
    | csvtk add-header -t -n 'taxid,count,name,rank,superkindom,phylum,class,order,family,genus,species' \
    > gtdb.taxid.map.stats.tsv

# number of unique species/strains
cat taxid.map \
    | csvtk uniq -Ht -f 2 \
    | taxonkit lineage --data-dir taxdump/ -i 2 -r -n -L \
    | csvtk freq -Ht -f 4 -nr \
    | csvtk pretty -H -t \
    | tee taxid.map.uniq.stats
species           31165
strain            4073
subspecies        104
forma specialis   59
no rank           31
isolate           26
```

Masking prophage regions and removing plasmid sequences with [genomad](https://github.com/apcamargo/genomad) (optional):

```
conda activate genomad

# https://github.com/shenwei356/cluster_files
cluster_files -p '^(.+).fna.gz$' gtdb -o gtdb.genomad

# indentify prophages and plasmids sequences
# > 10 days
db=~/ws/db/genomad/genomad_db
find gtdb.genomad/ -name "*.fna.gz" \
    | rush -j 6 -v db=$db \
        'genomad end-to-end --relaxed --cleanup --threads 25 {} {/}/genomad {db}' \
        -c -C genomad.rush --eta

# mask proviruses and remove plasmid sequences
find gtdb.genomad/ -name "*.fna.gz" \
    | grep -v masked \
    | rush -j 10 -v 'p={/}/genomad/{/%}_summary/{/%}' \
        'csvtk grep -t -f coordinates -p NA {p}_virus_summary.tsv \
            | sed 1d | cut -f 1 \
            > {p}.v.id; \
         csvtk grep -t -f coordinates -p NA {p}_virus_summary.tsv -v \
            | sed 1d | cut -f 1 \
            | perl -ne "/^(.+)\|.+_(\d+)_(\d+)$/; \$s=\$2-1; print qq/\$1\t\$s\t\$3\n/;" \
            > {p}.v.bed; \
        cut -f 1 {p}_plasmid_summary.tsv | sed 1d > {p}.p.id; \
        bedtools maskfasta -fi <(seqkit grep --quiet -v -f <(cat {p}.p.id {p}.v.id) {}) \
                            -bed {p}.v.bed -fo {}.masked.fna; \
        gzip -f {}.masked.fna' \
        -c -C genomad.b.rush --eta

# replace masked sequence with k-Ns, for more accurate genome size.
find gtdb.genomad/ -name "*.fna.gz.masked.fna.gz" \
    | rush -j 20 'seqkit replace -s -i -p N+ -r NNNNNNNNNNNNNNNNNNNNN {} -o {...}.masked2.fna.gz' \
        -c -C genomad.c.rush --eta

# stats
time find gtdb.genomad/ -name "*.fna.gz" \
    | seqkit stats -j 20 --infile-list - -T -b -o gtdb.genomad.stats.tsv

# create symbol links in another directory, and rename
mkdir -p gtdb_masked
cluster_files  -p '^(.+).fna.gz.masked2.fna.gz$' gtdb.genomad -o gtdb_masked
brename -R -p .masked.fna.gz$ gtdb_masked -d
```

Building database (all k-mers, for profiling on short-reads):

```
input=gtdb

# compute k-mers
#   sequence containing "plasmid" in name are ignored,
#   reference genomes are split into 10 chunks with 100bp overlap
#   k = 21
kmcp compute -I $input -O gtdb-k21-n10 -k 21 -n 10 -l 150 -B plasmid \
    --log gtdb-k21-n10.log -j 32 --force

# build database
#   number of index files: 32, for server with >= 32 CPU cores
#   bloom filter parameter:
#     number of hash function: 1
#     false positive rate: 0.3
kmcp index -j 32 -I gtdb-k21-n10 -O gtdb.kmcp -n 1 -f 0.3 \
    --log gtdb.kmcp.log --force

# cp taxid and name mapping file to database directory
cp taxid.map name.map gtdb.kmcp/

# clean up
rm -rf gtdb-k21-n10
```

Building small databases (all k-mers, for profiling with a computer cluster or computer with limited RAM):

```
input=gtdb

find $input -name "*.fna.gz" > $input.files.txt

# sort files by genome size, so we can split them into chunks with similar genome sizes
cp $input.files.txt $input.files0.txt
cat $input.files0.txt \
    | rush --eta -k 'echo -e {}"\t"$(seqkit stats -T {} | sed 1d | cut -f 5)' \
    > $input.files0.size.txt
cat $input.files0.size.txt \
    | csvtk sort -Ht -k 2:nr \
    | csvtk cut -t -f 1 \
    > $input.files.txt

# number of databases
n=2

# split into $n chunks using round robin distribution
split -n r/$n -d  $input.files.txt $input.n$n-

# create database for every chunks
for f in $input.n$n-*; do
    echo $f

    # compute k-mers
    #   sequence containing "plasmid" in name are ignored,
    #   reference genomes are split into 10 chunks with 100bp overlap
    #   k = 21
    kmcp compute -i $f -O $f-k21-n10 -k 21 -n 10 -l 150 -B plasmid \
        --log $f-k21-n10.log --force

    # build database
    #   number of index files: 32, for server with >= 32 CPU cores
    #   bloom filter parameter:
    #     number of hash function: 1
    #     false positive rate: 0.3
    kmcp index -j 32 -I $f-k21-n10 -O $f.kmcp -n 1 -f 0.3 \
        --log $f.kmcp.log --force

    # cp taxid and name mapping file to database directory
    cp taxid.map name.map $f.kmcp/
done

# rename small databases
# for example:
#   [INFO] checking: [ ok ] 'gtdb.n2-00.kmcp' -> 'gtdb.part_1.kmcp'
#   [INFO] checking: [ ok ] 'gtdb.n2-01.kmcp' -> 'gtdb.part_2.kmcp'
#   [INFO] 2 path(s) to be renamed

brename -D --only-dir -p "n$n-\d+" -r "part_{nr}" -d

# clean up
for f in $input.n$n-*; do
    rm -rf $f-k21-n10
done
```

### RefSeq viral or fungi

Tools

* [genome\_updater](https://github.com/pirovc/genome_updater) (0.5.1) for downloading genomes from NCBI.

Downloading viral and fungi sequences:

```
name=fungi
# name=viral

# -k for dry-run
# -i for fix
time genome_updater.sh \
    -d "refseq"\
    -g $name \
    -c "" \
    -l "" \
    -f "genomic.fna.gz" \
    -o "refseq-$name" \
    -t 12 \
    -m -a -p

# cd to 2021-09-30_19-35-19

# taxdump
mkdir -p taxdump
tar -zxvf taxdump.tar.gz -C taxdump

# assembly accession -> taxid
cut -f 1,6 assembly_summary.txt > taxid.map
# assembly accession -> name
cut -f 1,8 assembly_summary.txt > name.map

# stats (optional)
cat taxid.map  \
    | csvtk freq -Ht -f 2 -nr \
    | taxonkit lineage -r -n -L --data-dir taxdump/ \
    | taxonkit reformat -I 1 -f '{k}\t{p}\t{c}\t{o}\t{f}\t{g}\t{s}' --data-dir taxdump/ \
    | csvtk add-header -t -n 'taxid,count,name,rank,superkindom,phylum,class,order,family,genus,species' \
    > refseq-$name.taxid.map.stats.tsv

seqkit stats -T -j 12 --infile-list <(find files -name "*.fna.gz") > files.stats.tsv

# ------------------------------------------------------
# create another directory linking to genome files

input=files.renamed

mkdir -p $input
# create soft links
cd $input
find ../files -name "*.fna.gz" \
    | rush 'ln -s {}'
cd ..
# rename
brename -R -p '^(\w{3}_\d{9}\.\d+).+' -r '$1.fna.gz' $input
```

Building database (all k-mers, for profiling on short-reads):

```
# -----------------------------------------------------------------
# for viral, only splitting into 10 chunks
name=viral

input=files.renamed

# -------------
# all