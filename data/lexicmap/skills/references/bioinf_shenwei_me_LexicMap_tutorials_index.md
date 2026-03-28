[Skip to main content](#main-content)

[ ]
[ ]

Open Navigation

Close Navigation

[![](/LexicMap/logo.svg)
LexicMap: efficient sequence alignment against millions of prokaryotic genomes​](https://bioinf.shenwei.me/LexicMap/)

[GitHub](https://github.com/shenwei356/LexicMap)

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

[Back to homepage](https://bioinf.shenwei.me/LexicMap/)

Close Menu Bar

Open Menu Bar

## Navigation

* [ ]

  [Introduction](/LexicMap/introduction/)
* [ ]

  [Installation](/LexicMap/installation/)
* [ ]

  [Releases](/LexicMap/releases/)
* [ ]

  Tutorials
  + [ ]

    [Step 1. Building a database](/LexicMap/tutorials/index/)
  + [ ]

    [Step 2. Searching](/LexicMap/tutorials/search/)
  + [ ]

    More

    - [ ]

      [Indexing GTDB](/LexicMap/tutorials/misc/index-gtdb/)
    - [ ]

      [Indexing GenBank+RefSeq](/LexicMap/tutorials/misc/index-genbank/)
    - [ ]

      [Indexing AllTheBacteria](/LexicMap/tutorials/misc/index-allthebacteria/)
    - [ ]

      [Indexing GlobDB](/LexicMap/tutorials/misc/index-globdb/)
    - [ ]

      [Indexing UHGG](/LexicMap/tutorials/misc/index-uhgg/)
* [ ]

  Usage
  + [ ]

    [lexicmap](/LexicMap/usage/lexicmap/)
  + [ ]

    [index](/LexicMap/usage/index/)
  + [ ]

    [search](/LexicMap/usage/search/)
  + [ ]

    [utils](/LexicMap/usage/utils/)

    - [ ]

      [2blast](/LexicMap/usage/utils/2blast/)
    - [ ]

      [2sam](/LexicMap/usage/utils/2sam/)
    - [ ]

      [merge-search-results](/LexicMap/usage/utils/merge-search-results/)
    - [ ]

      [masks](/LexicMap/usage/utils/masks/)
    - [ ]

      [kmers](/LexicMap/usage/utils/kmers/)
    - [ ]

      [genomes](/LexicMap/usage/utils/genomes/)
    - [ ]

      [subseq](/LexicMap/usage/utils/subseq/)
    - [ ]

      [seed-pos](/LexicMap/usage/utils/seed-pos/)
    - [ ]

      [reindex-seeds](/LexicMap/usage/utils/reindex-seeds/)
    - [ ]

      [remerge](/LexicMap/usage/utils/remerge/)
    - [ ]

      [edit-genome-ids](/LexicMap/usage/utils/edit-genome-ids/)
* [ ]

  [FAQs](/LexicMap/faqs/)
* [ ]

  Notes
  + [ ]

    [Motivation](/LexicMap/notes/motivation/)

## More

* [ ]

  [More tools](https://github.com/shenwei356)

2. /
3. [Tutorials](/LexicMap/tutorials/)
4. /
5. Step 1. Building a database

# Step 1. Building a database

> Note
>
> Terminology differences:
>
> * On this page and in the LexicMap command line options, the term **“mask”** is used, following the terminology in the LexicHash paper.
> * In the LexicMap manuscript, however, we use **“probe”** as it is easier to understand.
>   Because these masks, which consist of thousands of k-mers and capture k-mers from sequences through prefix matching, function similarly to DNA probes in molecular biology.

## Table of contents

* [Table of contents](#table-of-contents)
* [TL;DR](#tldr)
* [Input](#input)
* [Hardware requirements](#hardware-requirements)
* [Algorithm](#algorithm)
* [Parameters](#parameters)
  + [Notes for indexing with large datasets](#notes-for-indexing-with-large-datasets)
* [Steps](#steps)
* [Output](#output)
  + [File structure](#file-structure)
  + [Index size](#index-size)
* [Explore the index](#explore-the-index)
* [Index format changelog](#index-format-changelog)

---

## TL;DR

1. Prepare input files:
   * **Sequences of each reference genome should be saved in separate FASTA files, with identifiers (no tab symbols) in the file names**.
     E.g., GCF\_000006945.2.fna.gz
     + A regular expression is also available to extract reference id from the file name.
       E.g., `--ref-name-regexp '^(\w{3}_\d{9}\.\d+)'` extracts `GCF_000006945.2` from GenBank assembly file `GCF_000006945.2_ASM694v2_genomic.fna.gz`.
     + Even if you forgot to use `-N/--ref-name-regexp`,
       [lexicmap utils edit-genome-ids](https://bioinf.shenwei.me/LexicMap/usage/utils/edit-genome-ids/) (available since v0.8.0) can fix this without re-building the index.
   * While if you save *a few* **small** (viral) **complete** genomes (one sequence per genome) in each file, it’s feasible as sequence IDs in search result can help to distinguish target genomes.
2. Run:
   * From a directory with multiple genome files:

     ```
     lexicmap index -I genomes/ -O db.lmi
     ```
   * From a file list with one file per line:

     ```
     lexicmap index --skip-file-check -X files.txt -O db.lmi
     ```

## Input

> Note
>
> **Genome size**
> LexicMap is mainly suitable for small genomes like Archaea, Bacteria, Viruses, fungi, and plasmids.
>
> Maximum genome size: 268 Mb (268,435,456).
> More precisely:
>
> ```
> $total_bases + ($num_contigs - 1) * 1000 <= 268,435,456
> ```
>
> as we concatenate contigs with 1000-bp intervals of N’s to reduce the sequence scale to index.

**Sequences of each reference genome should be saved in separate FASTA files, with identifiers in the file names**.
While if you save *a few* **small** (viral) **complete** genomes (one sequence per genome) in each file, it’s feasible as sequence IDs in search result can help to distinguish target genomes.

* **File type**: FASTA/Q files, in **plain text or gzip/xz/zstd/bzip2/lz4 compressed** formats.
* **File name**: “Genome ID” + “File extention”. E.g., `GCF_000006945.2.fna.gz`.
  + **Genome ID**: **they must not contain tab ("\t") symbols, and should be distinct for accurate result interpretation**, which will be shown in the search result.
    - A regular expression is also available to extract reference id from the file name.
      E.g., `--ref-name-regexp '^(\w{3}_\d{9}\.\d+)'` extracts `GCF_000006945.2` from GenBank assembly file `GCF_000006945.2_ASM694v2_genomic.fna.gz`.
    - **If you forgot to use `-N/--ref-name-regexp`,
      [lexicmap utils edit-genome-ids](https://bioinf.shenwei.me/LexicMap/usage/utils/edit-genome-ids/) (available since v0.8.0) can fix this without re-building the index**.
* **File extention**: a regular expression set by the flag `-r/--file-regexp` is used to match input files.
  The default value supports common sequence file extentions, e.g., `.fa`, `.fasta`, `.fna`, `.fa.gz`, `.fasta.gz`, `.fna.gz`, `fasta.xz`, `fasta.zst`, and `fasta.bz2`.
* **Sequences**:
  + **Only DNA or RNA sequences are supported**.
    - **Soft-masked sequences** are supported since v0.9.0 with the flag `--soft-masking`.
      Lowercase bases in soft-masked low-complexity regions will be treated as A’s and won’t be seeded,
      while they will be saved for base-level alignment.
  + **Sequence IDs** should be distinct for accurate result interpretation, which will be shown in the search result.
  + Sequence description (text behind sequence ID) is not saved. If you do need it, you can create a mapping file
    (`cat files.txt | seqkit seq -n -X - | sed -E 's/\s+/\t/' > id2desc.tsv`) and use it to [add description in search result](https://bioinf.shenwei.me/LexicMap/tutorials/search/#summarizing-results).
  + **One or more sequences (contigs) in each file are allowed**.
    - **Unwanted sequences** (such as plasmids) can be filtered out by regular expressions from the flag `-B/--seq-name-filter`.
  + **Genome size limit**. Some none-isolate assemblies might have extremely large genomes, e.g., [GCA\_000765055.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_000765055.1/) has >150 Mb.
    The flag `-g/--max-genome` (default 15 Mb) is used to skip these input files, and the file list would be written to a file
    via the flag `-G/--big-genomes`.
    - **Changes since v0.5.0**:
      * Genomes with any single contig larger than the threshold will be skipped as before.
      * However, **fragmented (with many contigs) genomes with the total bases larger than the threshold will
        be split into chunks** and alignments from these chunks will be merged in `lexicmap search`.
    - **For fungi genomes, please increase the value of `-g/--max-genome`**.
  + **Minimum sequence length**. A flag `-l/--min-seq-len` can filter out sequences shorter than the threshold (default is the `k` value).
* **At most 17,179,869,184 (234) genomes are supported**. For more genomes, please create a file list and split it into multiple parts, and build an index for each part.

**Input files can be given via one of the following ways:**

* **Positional arguments**. For a few input files.
* A **file list** via the flag `-X/--infile-list` with one file per line.
  **It can be STDIN (`-`)**, e.g., you can filter a file list and pass it to `lexicmap index`.
  + **The flag `-S/--skip-file-check` is optional for skiping input file checking if you believe these files do exist**.
    Because, by default, LexicMap checks the existence of all input files, which would take tens of minutes for >1M files.
* A **directory** containing input files via the flag `-I/--in-dir`.
  + **Multiple-level directories are supported**. So you don’t need to saved hundreds of thousand files into one directoy.
  + **Directory and file symlinks are followed**.

## Hardware requirements

See [benchmark of index building](https://bioinf.shenwei.me/LexicMap/introduction/#indexing).

LexicMap is designed to provide fast and low-memory sequence alignment against millions of prokaryotic genomes.

* **CPU:**
  + No specific requirements on CPU type and instruction sets. Both x86 and ARM chips are supported.
  + More is better as LexicMap is a CPU-intensive software. **It uses all CPUs by default (`-j/--threads`)**.
* **RAM**
  + More RAM (> 200 GB for >2 million genomes) is preferred. The memory usage in index building is mainly related to:
    - **The number of masks** (`-m/--masks`, default 20,000). Bigger values improve the search sensitivity slightly, increase the index size, and slow down the search speed. For smaller genomes like phages/viruses, m=5,000 is high enough.
    - **The number of genomes**. Generally, more genomes consume more memory, but we can reduce it by using smaller genome batch sizes (see below).
    - **The genome batch size** (`-b/--batch-size`, default 5,000). This is the main parameter to adjust **memory usage**. Bigger values increase indexing memory occupation.
    - **The divergence between genome sequences in each batch**. Diverse genomes consume more memory.
    - **The maximum seed distance** or **the maximum sketching desert size** (`-D/--seed-max-desert`, default 100),
      and the distance of k-mers to fill deserts (`-d/--seed-in-desert-dist`, default 50).
      These are the main parameters to adjust **search sensitivity**.
      Bigger `-D/--seed-max-desert` values decrease the search sensitivity, speed up the indexing speed,
      decrease the indexing memory occupation and decrease the index size. While the alignment speed is almost not affected.
  + **If the RAM is not sufficient**. Please:
    - **Use a smaller genome batch size**. It decreases indexing memory occupation and has little affection on searching performance.
* **Disk**
  + More is better. LexicMap index size is related to the number of input genomes, the divergence between genome sequences, the number of masks, and the maximum seed distance. See [some examples](#index-size).
    - **Note that the index size is not linear with the number of genomes, it’s sublinear**. Because the seed data are compressed with VARINT-GB algorithm, more genomes bring smaller compression rates.
  + SSD disks are preferred, while HDD disks are also fast enough.

## Algorithm

![](/LexicMap/indexing.svg)

See the [paper](https://bioinf.shenwei.me/LexicMap/introduction/#citation) for details.

Click to show details.
...
[ ]

1. **Generating *m* [LexicHash masks](https://doi.org/10.1093/bioinformatics/btad652)**.

   1. Generate *m* prefixes.
      1. Generating all permutations of *p*-bp prefixes that can cover all possible k-mers, *p* is the biggest value for 4*p* <= *m* (desired number of masks), e.g., *p*=7 for 20,000 masks. (4*7* = 16384)
      2. Duplicating these prefixes to *m* prefixes.
   2. For each prefix,
      1. Randomly generating left *k*-*p* bases.
      2. If the mask is duplicated, re-generating.
2. **Building an index for each genome batch** (`-b/--batch-size`, default 5,000, max 131,072).

   1. For each genome file in a genome batch.
      1. Optionally discarding sequences via regular expression (`-B/--seq-name-filter`).
      2. Skipping genomes bigger than the value of `-g/--max-genome`.
      3. Concatenating all sequences, with intervals of 1000-bp N’s.
      4. Capturing the most similar k-mer (in non-gap and non-interval regions) for each mask and recording the k-mer and its location(s) and strand information. Base N is treated as A.
      5. Filling sketching deserts (genome regions longer than `--seed-max-desert` [default 100] without any captured k-mers/seeds).
         In a sketching desert, not a single k-mer is captured because there’s another k-mer in another place which shares a longer prefix with the mask.
         As a result, for a query similar to seqs in this region, all captured k-mers can’t match the correct seeds.
         1. For a desert region (`start`, `end`), masking the extended region (`start-1000`, `end+1000`) with the masks.
         2. Starting from `start`, every around `--seed-in-desert-dist` (default 50) bp, finding a k-mer which is captured by some mask, and adding the k-mer and its position information into the index of that mask.
      6. Saving the concatenated genome sequence (bit-packed, 2 bits for one base, N is treated as A) and genome information (genome ID, size, and lengths of all sequences) into the genome data file, and creating an index file for the genome data file for fast random subsequence extraction.
   2. Duplicate and reverse all k-mers, and save each reversed k-mer along with the duplicated position information in the seed data of the closest (sharing the longgest prefix) mask. This is for suffix matching of seeds.
   3. Compressing k-mers and the corresponding data (k-mer-data, or seeds data, including genome batch, genome number, location, and strand) into chunks of files, and creating an index file for each k-mer-data file for fast seeding.
   4. Writing summary information into `info.toml` file.
3. **Merging indexes of multiple batches**.

   1. For each k-mer-data chunk file (belonging to a list of masks), serially reading data of each mask from all batches,
      merging them and writting to a new file.
   2. For genome data files, just moving them.
   3. Concatenating `genomes.map.bin`, which maps each genome ID to its batch ID and index in the batch.
   4. Update the index summary file.

## Parameters

> Note
>
> **Query length**
>
> **LexicMap is mainly designed for sequence alignment with a small number of queries (gene/plasmid/virus/phage sequences) longer than 150 bp by default**.
>
> **If you want to search some short reads, you need to build the index with small `-D/--seed-max-desert` (default 100) and `-d/--seed-in-desert-dist` (default 50), e.g., `-D 60 -d 30` for 125bp reads, or `-D 50 -D 25` for 100bp reads*