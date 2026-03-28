[ ]
[ ]

[Skip to content](#metagenomic-profiling)

[![logo](../../favicon.svg)](../.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")

KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

Taxonomic profiling

Initializing search

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

[![logo](../../favicon.svg)](../.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")
KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

* [Home](../..)
* [Download](../../download/)
* [Databases](../../database/)
* [Usage](../../usage/)
* [x]

  Tutorials

  Tutorials
  + [ ]

    Taxonomic profiling
    [Taxonomic profiling](./)

    Table of contents
    - [Requirements](#requirements)
    - [Datasets](#datasets)
    - [Steps](#steps)

      * [Step 1. Preprocessing reads](#step-1-preprocessing-reads)
      * [Step 2. Removing host reads](#step-2-removing-host-reads)
      * [Step 3. Searching](#step-3-searching)

        + [Attentions](#attentions)
        + [Index files loading modes](#index-files-loading-modes)
        + [Commands](#commands)
        + [Search result format](#search-result-format)
        + [Searching on a computer cluster](#searching-on-a-computer-cluster)
      * [Step 4. Profiling](#step-4-profiling)

        + [Input](#input)
        + [Methods](#methods)
        + [Profiling modes](#profiling-modes)
        + [Commands](#commands_1)
        + [Profiling result formats](#profiling-result-formats)
  + [Detecting specific pathogens](../detecting-pathogens/)
  + [Detecting contaminated sequences](../detecting-contaminated-seqs/)
  + [Sequence and genome searching](../searching/)
* [ ]

  Benchmarks

  Benchmarks
  + [Taxonomic profiling](../../benchmark/profiling/)
  + [Sequence and genome searching](../../benchmark/searching/)
* [FAQs](../../faq/)
* [More tools](https://github.com/shenwei356)

Table of contents

* [Requirements](#requirements)
* [Datasets](#datasets)
* [Steps](#steps)

  + [Step 1. Preprocessing reads](#step-1-preprocessing-reads)
  + [Step 2. Removing host reads](#step-2-removing-host-reads)
  + [Step 3. Searching](#step-3-searching)

    - [Attentions](#attentions)
    - [Index files loading modes](#index-files-loading-modes)
    - [Commands](#commands)
    - [Search result format](#search-result-format)
    - [Searching on a computer cluster](#searching-on-a-computer-cluster)
  + [Step 4. Profiling](#step-4-profiling)

    - [Input](#input)
    - [Methods](#methods)
    - [Profiling modes](#profiling-modes)
    - [Commands](#commands_1)
    - [Profiling result formats](#profiling-result-formats)

# Metagenomic profiling

## Requirements

* Database
  + [Prebuilt databases](/kmcp/database/#prebuilt-databases) are available.
  + Or [build custom databases](/kmcp/database/#custom-database).
* Hardware.
  + CPU: ≥ 32 cores preferred.
  + RAM: ≥ 64 GB, depends on file size of the biggest database.

## Datasets

* Short reads, single or paired end.

## Steps

### Step 1. Preprocessing reads

For example, removing adapters and trimming using [fastp](https://github.com/OpenGene/fastp):

```
fastp -i in_1.fq.gz -I in_2.fq.gz  \
    -o out_1.fq.gz -O out_2.fq.gz \
    -l 75 -q 20 -W 4 -M 20 -3 20 --thread 32 \
    --trim_poly_g --poly_g_min_len 10 --low_complexity_filter \
    --html out.fastp.html
```

### Step 2. Removing host reads

Tools:

* [bowtie2](https://github.com/BenLangmead/bowtie2) is [recommended](https://doi.org/10.1099/mgen.0.000393) for removing host reads.
* [samtools](https://github.com/samtools/samtools) is also used for processing reads mapping file.

Host reference genomes:

* Human: [CHM13](https://github.com/marbl/CHM13). We also provide a database of CHM13 for fast removing human reads.

Building the index (~60min):

```
bowtie2-build --threads 32 GCA_009914755.4_T2T-CHM13v2.0_genomic.fna.gz chm13v2.0
```

Mapping and removing mapped reads:

```
index=~/ws/db/bowtie2/chm13v2.0

# paired-end reads
bowtie2 --threads 32 -x $index -1 in_1.fq.gz -2 in_2.fq.gz \
    | samtools fastq -f 4 -o sample.fq.gz -

# unpaired reads
bowtie2 --threads 32 -x $index -U in.fq.gz \
    | samtools fastq -f 4 | pigz -c > sample.fq.gz
```

### Step 3. Searching

**Reads can be searched against multiple databases which can be built with different parameters**,
and the results can be fastly merged for downstream analysis.

#### **Attentions**

1. Input format should be (gzipped) FASTA or FASTQ from files or stdin.
   Paired-End reads should be given via `-1/--read1` and `-2/--read2`.

   ```
   kmcp search -d db -1 read_1.fq.gz -2 read_2.fq.gz -o read.tsv.gz
   ```

   Single-end can be given as positional arguments or `-1`/`-2`.

   ```
   kmcp search -d db file1.fq.gz file2.fq.gz -o result.tsv.gz
   ```

   **Single-end mode is recommended for paired-end reads, for higher sensitivity**.
2. A long query sequence may contain duplicated k-mers, which are
   not removed for short sequences by default. You may modify the
   value of `-u/--kmer-dedup-threshold` (default `256`) to remove duplicates.
3. For long reads or contigs, you should split them into short reads
   using `seqkit sliding`, e.g.,

   ```
   seqkit sliding -s 100 -W 300
   ```
4. The values of `tCov` and `jacc` in results only apply to databases built with a single size of k-mer.

**`kmcp search` and `kmcp profile` share some flags**, therefore users
can use stricter criteria in `kmcp profile`.

1. `-t/--min-query-cov`, minimum query coverage, i.e.,
   proportion of matched k-mers and unique k-mers of a query (default `0.55`, close to `~96.5%` sequence similarity)
2. `-f/--max-fpr`, maximum false positive rate of a query. (default `0.05`)

#### **Index files loading modes**

1. Using memory-mapped index files with `mmap` (default):
   * Faster startup speed when index files are buffered in memory.
   * Multiple KMCP processes can share the memory.
2. Loading the whole index files into memory (`-w/--load-whole-db`):
   * This mode occupies a little more memory.
     And multiple KMCP processes can not share the database in memory.
   * **It's slightly faster due to the use of physically contiguous memory.
     The speedup is more significant for smaller databases**.
   * **Please switch on this flag (`-w`) when searching on computer clusters,
     where the default mmap mode would be very slow for network-attached
     storage (NAS).**
3. Low memory mode (`--low-mem`):
   * Do not load all index files into memory nor use mmap, using file seeking.
   * It's much slower, >4X slower on SSD and would be much slower on HDD disks.
   * **Only use this mode for small number of queries or a huge database that
     can't be loaded into memory**.

**Performance tips**:

1. Increase the value of `-j/--threads` for acceleratation, but values larger
   than the the number of CPU cores won't bring extra speedup.

#### **Commands**

**Single-end mode is recommended for paired-end reads, for higher sensitivity**:

```
# ---------------------------------------------------
# single-end (recommended)

read1=sample_1.fq.gz
read2=sample_2.fq.gz
sample=sample

# 1. searching results against multiple databases
for db in refseq-fungi.kmcp genbank-viral.kmcp gtdb.kmcp ; do
    dbname=$(basename $db)

    kmcp search \
        --threads            32 \
        --db-dir            $db \
        --min-kmers          10 \
        --min-query-len      30 \
        --min-query-cov    0.55 \
        $read1                  \
        $read2                  \
        --out-file         $sample.kmcp@$dbname.tsv.gz \
        --log              $sample.kmcp@$dbname.tsv.gz.log
done

# 2. Merging search results against multiple databases
kmcp merge $sample.kmcp@*.tsv.gz --out-file $sample.kmcp.tsv.gz
```

Paired-end reads:

```
# ---------------------------------------------------
# paired-end

read1=sample_1.fq.gz
read2=sample_2.fq.gz
sample=sample

# 1. searching results against multiple databases
for db in refseq-fungi.kmcp genbank-viral.kmcp gtdb.kmcp ; do
    dbname=$(basename $db)

    kmcp search \
        --threads            32 \
        --db-dir            $db \
        --min-kmers          10 \
        --min-query-len      30 \
        --min-query-cov    0.55 \
        --read1          $read1 \
        --read2          $read2 \
        --out-file       $sample.kmcp@$dbname.tsv.gz \
        --log            $sample.kmcp@$dbname.tsv.gz.log
done

# 2. Merging search results against multiple databases
kmcp merge $sample.kmcp@*.tsv.gz --out-file $sample.kmcp.tsv.gz
```

#### Search result format

Tab-delimited format with 15 columns:

```
 1. query,    Identifier of the query sequence
 2. qLen,     Query length
 3. qKmers,   K-mer number of the query sequence
 4. FPR,      False positive rate of the match
 5. hits,     Number of matches
 6. target,   Identifier of the target sequence
 7. chunkIdx, Index of reference chunk
 8. chunks,   Number of reference chunks
 9. tLen,     Reference length
10. kSize,    K-mer size
11. mKmers,   Number of matched k-mers
12. qCov,     Query coverage,  equals to: mKmers / qKmers
13. tCov,     Target coverage, equals to: mKmers / K-mer number of reference chunk
14. jacc,     Jaccard index
15. queryIdx, Index of query sequence, only for merging
```

Note: The header line starts with `#`, you need to assign another comment charactor
if using `csvtk` for analysis. e.g.,

```
csvtk filter2 -C '$' -t -f '$qCov > 0.55' mock.kmcp.gz
```

Demo result:

| #query | qLen | qKmers | FPR | hits | target | chunkIdx | chunks | tLen | kSize | mKmers | qCov | tCov | jacc | queryIdx |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NC\_003197.2-64416/1 | 150 | 130 | 7.4626e-15 | 1 | GCF\_000006945.2 | 9 | 10 | 4857450 | 21 | 90 | 0.6923 | 0.0002 | 0.0002 | 1 |
| NC\_003197.2-64414/1 | 150 | 130 | 7.4626e-15 | 1 | GCF\_000006945.2 | 6 | 10 | 4857450 | 21 | 130 | 1.0000 | 0.0003 | 0.0003 | 2 |
| NC\_003197.2-64412/1 | 150 | 130 | 7.4626e-15 | 1 | GCF\_000006945.2 | 6 | 10 | 4857450 | 21 | 121 | 0.9308 | 0.0002 | 0.0002 | 3 |
| NC\_003197.2-64410/1 | 150 | 130 | 7.4626e-15 | 1 | GCF\_000006945.2 | 1 | 10 | 4857450 | 21 | 101 | 0.7769 | 0.0002 | 0.0002 | 4 |
| NC\_003197.2-64408/1 | 150 | 130 | 7.8754e-15 | 1 | GCF\_000006945.2 | 9 | 10 | 4857450 | 21 | 83 | 0.6385 | 0.0002 | 0.0002 | 5 |
| NC\_003197.2-64406/1 | 150 | 130 | 7.4626e-15 | 1 | GCF\_000006945.2 | 2 | 10 | 4857450 | 21 | 103 | 0.7923 | 0.0002 | 0.0002 | 6 |
| NC\_003197.2-64404/1 | 150 | 130 | 7.4671e-15 | 1 | GCF\_000006945.2 | 5 | 10 | 4857450 | 21 | 86 | 0.6615 | 0.0002 | 0.0002 | 7 |
| NC\_003197.2-64402/1 | 150 | 130 | 7.5574e-15 | 1 | GCF\_000006945.2 | 3 | 10 | 4857450 | 21 | 84 | 0.6462 | 0.0002 | 0.0002 | 8 |
| NC\_003197.2-64400/1 | 150 | 130 | 7.4626e-15 | 1 | GCF\_000006945.2 | 1 | 10 | 4857450 | 21 | 89 | 0.6846 | 0.0002 | 0.0002 | 9 |

#### Searching on a computer cluster

Update: We recommend analyzing one sample using one computer node, which is easier to setup up.

Here, we split genomes of GTDB into 16 partitions and build a database for
every partition, so we can use computer cluster to accelerate the searching.
The genbank-viral genomes are also diveded into 4 partition.

A helper script [easy\_sbatch](https://github.com/shenwei356/easy_sbatch)
is used for batch submitting Slurm jobs via script templates.

```
# ---------------------------------------------------
# searching

j=32
reads=reads

# -----------------
# gtdb

dbprefix=~/ws/db/kmcp/gtdb.n16-

for file in $reads/*.left.fq.gz; do
    prefix=$(echo $file | sed 's/.left.fq.gz//')
    read1=$file
    read2=$(echo $file | sed 's/left.fq.gz/right.fq.gz/')

    ls -d $dbprefix*.kmcp \
        | easy_sbatch \
            -c $j -J $(basename $prefix) \
            "kmcp search         \
                --load-whole-db  \
                --threads   $j   \
                --db-dir    {}   \
                $read1 $read2    \
                --out-file  $prefix.kmcp@\$(basename {}).tsv.gz \
                --log       $prefix.kmcp@\$(basename {}).tsv.gz.log \
                --quiet "
done

# -----------------
# viral

dbprefix=~/ws/db/kmcp/genbank-viral.n4-

for file in $reads/*.left.fq.gz; do
    prefix=$(echo $file | sed 's/.left.fq.gz//')
    read1=$file
    read2=$(echo $file | sed 's/left.fq.gz/right.fq.gz/')

    ls -d $dbprefix*.kmcp \
        | easy_sbatch \
            -c $j -J $(basename $prefix) \
            "kmcp search         \
                --load-whole-db  \
                --threads   $j   \
                --db-dir    {}   \
                $read1 $read2    \
                --out-file  $prefix.kmcp@\$(basename {}).tsv.gz \
                --log       $prefix.kmcp@\$(basename {}).tsv.gz.log \
                --quiet "
done

# -----------------
# fungi

dbprefix=~/ws/db/kmcp/refseq-fungi

for file in $reads/*.left.fq.gz; do
    prefix=$(echo $file | sed 's/.left.fq.gz//')
    read1=$file
    read2=$(echo $file | sed 's/left.fq.gz/right.fq.gz/')

    ls -d $dbprefix*.kmcp \
        | easy_sbatch \
            -c $j -J $(basename $prefix) \
            "kmcp search         \
                --load-whole-db  \
                --threads   $j   \
                --db-dir    {}   \
                $read1 $read2    \
                --out-file  $prefix.kmcp@\$(basename {}).tsv.gz \
                --log       $prefix.kmcp@\$(basename {}).tsv.gz.log \
                --quiet "
done

# ---------------------------------------------------
# wait all job being done

# ---------------------------------------------------
# merge result and profiling

# merge results
# there's no need to submit to slurm, which could make it slower, cause the bottleneck is file IO
for file in $reads/*.left.fq.gz; do
    prefix=$(echo $file | sed 's/.left.fq.gz//')

    echo $prefix; date
    kmcp merge $prefix.kmcp@*.tsv.gz --out-file $prefix.kmcp.tsv.gz \
        --quiet --log $prefix.kmcp.tsv.gz.merge.log
done

# profiling
X=taxdump/
T=taxid.map

fd kmcp.tsv.gz$ $reads/ \
    | rush -v X=$X -v T=$T \
        'kmcp profile -X {X} -T {T} {} -o {}.k.profile -C {}.c.profile -s {%:} \
            --log {}.k.profile.log'
```

### Step 4. Profiling

#### **Input**

* TaxId mapping file(s).
* Taxdump files.
* KMCP search results.

#### **Methods**

1. Reference genomes can be split into chunks when computing
   k-mers (sketches), which could help to increase the specificity
   via a threshold, i.e., the minimum proportion of matched chunks
   (`-p/--min-chunks-fraction`) (***highly recommended***).
   Another flag `-d/--max-chunks-cov-stdev` further reduces false positives.
2. We require a part of the uniquely matched reads of a reference
   having high similarity, i.e., with high confidence for decreasing
   the false positive rate.
3. We also use the two-stage taxonomy assignm