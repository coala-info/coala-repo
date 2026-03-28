1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Assemble](/captus.docs/assembly/assemble/) >
4. Options

* [*Input*](#input)
  + [**`-r, --reads`**](#-r---reads)
  + [**`--sample_reads_target`**](#--sample_reads_target)
* [*Output*](#output)
  + [**`-o, --out`**](#-o---out)
  + [**`--keep_all`**](#--keep_all)
  + [**`--overwrite`**](#--overwrite)
* [*de novo Assembly (MEGAHIT)*](#de-novo-assembly-megahit)
  + [**`--k_list`**](#--k_list)
  + [**`--min_count`**](#--min_count)
  + [**`--prune_level`**](#--prune_level)
  + [**`--merge_level`**](#--merge_level)
  + [**`--preset`**](#--preset)
  + [**`--min_contig_len`**](#--min_contig_len)
  + [**`--tmp_dir`**](#--tmp_dir)
  + [**`--max_contig_gc`**](#--max_contig_gc)
  + [**`--disable_mapping`**](#--disable_mapping)
  + [**`--min_contig_depth`**](#--min_contig_depth)
  + [**`--redo_filtering`**](#--redo_filtering)
* [*Other*](#other)
  + [**`--reformat_path`**, **`--megahit_path`**, **`--megahit_toolkit_path`**, **`--salmon_path`**](#--reformat_path---megahit_path---megahit_toolkit_path---salmon_path)
  + [**`--ram`**, **`--threads`**, **`--concurrent`**, **`--debug`**, **`--show_less`**](#--ram---threads---concurrent---debug---show_less)

# Options

# assemble

---

To show all available options and their default values you can type in your terminal:

```
captus assemble --help
```

---

## *Input*

---

### **`-r, --reads`**

With this option you provide the location of your clean FASTQ files, there are several ways to list them:

* ***Directory:*** providing the path to the directory containing your cleaned FASTQ files is the typical way to tell `Captus` which files to analyze. Subdirectories will not be searched in this case. If you cleaned your reads with `Captus` just use `-r 01_clean_reads` or the name you gave to the output directory.
* ***List of files:*** you can also provide the individual path to each of your FASTQ files separated by a single space. This is useful if you only want to analyze only a couple of samples within a directory with many other samples. Another use for lists is when your FASTQ files are located in different directories.
* ***UNIX pattern:*** another easy way to provide lists of files is using the wildcards `*` and `?` to match many or just one character respectively.

This argument is **required** , the default is **./01\_clean\_reads/**

Read this if you want to assemble FASTQ files cleaned elsewhere

Imagine that you have a directory `clean_reads` with the following structure:

```
clean_reads
├── A_R1.fastq.gz
├── A_R2.fastq.gz
├── B_R1.fastq.gz
├── B_R2.fastq.gz
├── C_R1.fq
├── C_R2.fq
├── D_R1.fq
└── D_R2.fq
```

* If you want to analyze all the FASTQ files in `clean_reads` you can simply use `-r clean_reads`
* To analyze only samples `A` and `D`: `-r cleaned_reads/A_R1.fastq.gz cleaned_reads/A_R2.fastq.gz cleaned_reads/D_R1.fq cleaned_reads/D_R2.fq` or more easily `-r cleaned_reads/A_R?.fastq.gz cleaned_reads/D_R?.fq`

---

### **`--sample_reads_target`**

In case that you want to subsample a fixed amount of reads (e.g. if your FASTQ files have hundreds of millions of reads) you can indicate the number with this option. For example, `--sample_reads_target 10_000_000` will randomly sample 10 million reads (if single-end) or 10 million pairs (if paired-end).

This argument is optional, the default is **0** (no subsampling).

---

## *Output*

---

### **`-o, --out`**

With this option you can redirect the output directory to a path of your choice, that path will be created if it doesn’t already exist.
Inside this directory, the assembly of each sample will be stored in a subdirectory with the ending `__captus-asm`.

This argument is optional, the default is **./02\_assemblies/**

---

### **`--keep_all`**

Many intermediate files are created by `MEGAHIT` during assembly, some are large (like the individual FASTA files from each kmer size), `Captus` deletes all the unnecesary intermediate files unless you enable this flag.

---

### **`--overwrite`**

Use this flag with caution, this will replace any previous result within the output directory (for the sample names that match).

---

## *de novo Assembly (MEGAHIT)*

---

### **`--k_list`**

Comma-separated list (no spaces) of kmer sizes, all must be odd values in the range 15-255, in increments of at most 28. The final kmer size will be adjusted automatically so it never exceeds the mean read length of the sample by more than 31 (so don’t worry if the largest kmer size in the default list seems too big for your read length).

This argument is optional, default is `--k_list` in the default `--preset`.

---

### **`--min_count`**

Minimum contig depth (called multiplicity in MEGAHIT). Acceptable values are integers >= 1. If your FASTQ files have many tens of million reads, it is recommended to use `--min_count 3` or higher to avoid low-coverage contigs resulting from erroneous reads (the higher the sequencing depth, the higher the number of reads with errors that will get assembled into spurious contigs).

This argument is optional, defaults is `--min_count` in the default `--preset`.

---

### **`--prune_level`**

Prunning strength for low-coverage edges during graph cleaning. Increasing the value beyond 2 can speed up the assembly at the cost of losing low-depth contigs. Acceptable values are integers between 0 and 3.

This argument is optional, defaults is `--prune_level` in the default `--preset`.

---

### **`--merge_level`**

Thresholds for merging complex bubbles, the first number multiplied by the kmer size represents the maximum bubble length to merge, the second number represents the minimum similarity required to merge bubbles. For example, `--merge_level 20,0.97` at kmer 175 will merge any two paths of at least 175 bp x 20 (3500 bp) with a similarity >= 97%.

This argument is optional, the default is **20,0.95**.

---

### **`--preset`**

The default preset ‘CAPSKIM’ has optimized settings that work well with either hybridization capture or genome skimming data (or a combination of both). We have also optimized other MEGAHIT parameter combinations specific to high-coverage (>= 30x depth) `WGS` data or `RNA`-Seq data. These modes will only work well with at least 8 GB of RAM. If, in addition to a `preset`, you provide your own `k_list`, `min_count`, or `prune_level`, your settings take priority over the preset’s.

* `CAPSKIM` = `--k-list 31,39,47,63,79,95,111,127,143,159,175 --min-count 2 --prune-level 2`
* `RNA` = `--k-list 27,47,67,87,107,127,147,167 --min-count 2 --prune-level 2`
* `WGS` = `--k-list 31,39,49,69,89,109,129,149,169 --min-count 3 --prune-level 2 --no-mercy`

This argument is optional, the default is **CAPSKIM**.

---

### **`--min_contig_len`**

Minimum contig length in bp in output assembly.

This argument is optional, the default is **auto** (= mean read length + smallest kmer in `k_list`).

---

### **`--tmp_dir`**

MEGAHIT needs a temporary directory in an internal hard drive, otherwise it refuses to run.

This argument is optional, the default is **$HOME**.

---

### **`--max_contig_gc`**

Maximum GC percentage allowed per contig. Useful to filter contamination. For example, bacteria usually exceed 60% GC content while eukaryotes rarely exceed that limit. 100.0 disables the GC filter.

This argument is optional, the default is **100.0** (filter disabled).

---

### **`--disable_mapping`**

Disable mapping the reads back to the contigs using Salmon for accurate depth estimation. If disabled, the approximate depth estimation given by MEGAHIT will be used instead.

---

### **`--min_contig_depth`**

Minimum contig depth of coverage in output assembly; ‘auto’ will retain contigs with depth of coverage greater than 1.0x when ‘–disable\_mapping’ is chosen, otherwise it will retain only contigs of at least 1.5x. Accepted values are decimals greater or equal to 0. Use 0 to disable the filter.

This argument is optional, the default is **auto** (>=1.5x, or >1.0x when using `--disable_mapping`).

---

### **`--redo_filtering`**

Enable if you want to try different values for `--max_contig_gc` or `--min_contig_depth`. Only the filtering step will be repeated.

---

## *Other*

---

### **`--reformat_path`**, **`--megahit_path`**, **`--megahit_toolkit_path`**, **`--salmon_path`**

If you have installed your own copies of `reformat.sh` (from `BBTools`) or `MEGAHIT` (and its `megahit_toolkit`) or `Salmon` you can provide the full path to those copies.

These arguments are optional, the defaults are **reformat.sh**, **megahit**, **megahit\_toolkit**, and **salmon** respectively.

---

### **`--ram`**, **`--threads`**, **`--concurrent`**, **`--debug`**, **`--show_less`**

See [Parallelization (and other common options)](https://edgardomortiz.github.io/captus.docs/basics/parallelization/)

---

Created by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (06.08.2021)
Last modified by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (18.12.2024)

[![](/captus.docs/images/logo.svg)](/)

Search

* [Home](/captus.docs/)

* [ ] Submenu Basics[Basics](/captus.docs/basics/)
  + [Overview](/captus.docs/basics/overview/)
  + [Installation](/captus.docs/basics/installation/)
  + [Parallelization](/captus.docs/basics/parallelization/)
* [x] Submenu Assembly[Assembly](/captus.docs/assembly/)
  + [x] Submenu Clean[**1.** Clean](/captus.docs/assembly/clean/)
    - [Input Preparation](/captus.docs/assembly/clean/preparation/)
    - [Options](/captus.docs/assembly/clean/options/)
    - [Output Files](/captus.docs/assembly/clean/output/)
    - [HTML Report](/captus.docs/assembly/clean/report/)
  + [x] Submenu Assemble[**2.** Assemble](/captus.docs/assembly/assemble/)
    - [Input Preparation](/captus.docs/assembly/assemble/preparation/)
    - [Options](/captus.docs/assembly/assemble/options/)
    - [Output Files](/captus.docs/assembly/assemble/output/)
    - [HTML Report](/captus.docs/assembly/assemble/report/)
  + [x] Submenu Extract[**3.** Extract](/captus.docs/assembly/extract/)
    - [Input Preparation](/captus.docs/assembly/extract/preparation/)
    - [Options](/captus.docs/assembly/extract/options/)
    - [Output Files](/captus.docs/assembly/extract/output/)
    - [HTML Report](/captus.docs/assembly/extract/report/)
  + [x] Submenu Align[**4.** Align](/captus.docs/assembly/align/)
    - [Options](/captus.docs/assembly/align/options/)
    - [Output Files](/captus.docs/assembly/align/output/)
    - [HTML Report](/captus.docs/assembly/align/report/)
* [Design](/captus.docs/design/)
* [ ] Submenu Tutorials[Tutorials](/captus.docs/tutorials/)
  + [Basic](/captus.docs/tutorials/basic/)
  + [Advanced](/captus.docs/tutorials/advanced/)

More

* [GitHub repo](https://github.com/edgardomortiz/Captus)
* [Credits](/captus.docs/more/credits)

---

* Language
* Theme

  Green
* Clear History

[Download](https://github.com/edgardomortiz/Captus/archive/master.zip)
[Star](https://github.com/edgardomortiz/Captus)
[Fork](https://github.com/edgardomortiz/Captus/fork)

Built with  by [Hugo](https://gohugo.io/)