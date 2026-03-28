1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Clean](/captus.docs/assembly/clean/) >
4. Options

* [*Input*](#input)
  + [**`-r, --reads`**](#-r---reads)
* [*Output*](#output)
  + [**`-o, --out`**](#-o---out)
  + [**`--keep_all`**](#--keep_all)
  + [**`--overwrite`**](#--overwrite)
* [*Adaptor trimming*](#adaptor-trimming)
  + [**`--adaptor_set`**](#--adaptor_set)
  + [**`--rna`**](#--rna)
* [*Quality trimming and filtering*](#quality-trimming-and-filtering)
  + [**`--trimq`**](#--trimq)
  + [**`--maq`**](#--maq)
  + [**`--ftl`**](#--ftl)
  + [**`--ftr`**](#--ftr)
* [*QC Statistics*](#qc-statistics)
  + [**`--qc_program`**](#--qc_program)
  + [**`--skip_qc_stats`**](#--skip_qc_stats)
* [*Other*](#other)
  + [**`--bbduk_path`**, **`--falco_path`**, **`--fastqc_path`**](#--bbduk_path---falco_path---fastqc_path)
  + [**`--ram`**, **`--threads`**, **`--concurrent`**, **`--debug`**, **`--show_less`**](#--ram---threads---concurrent---debug---show_less)

# Options

# clean

---

To show all available options and their default values you can type in your terminal:

```
captus clean --help
```

---

## *Input*

---

### **`-r, --reads`**

With this option you provide the location of your raw FASTQ files, there are several ways to list them:

* ***Directory:*** the path to the directory containing your FASTQ files is usually the easiest way to tell `Captus` which files to analyze. When you provide a directory, `Captus` searches within all its subdirectories for files with [valid FASTQ extensions](https://edgardomortiz.github.io/captus.docs/assembly/clean/preparation/).
* ***List of files:*** you can also provide the individual path to each of your FASTQ files separated by spaces. This is useful if you only want to analyze only a couple of samples within a directory with many other samples for example. Another use for lists is when your FASTQ files are located in different directories.
* ***UNIX pattern:*** another easy way to provide lists of files is using the wildcards `*` and `?` to match many or just one character respectively.

This argument is **required** .

Examples

Imagine that your directory `raw_reads` has the following structure:

```
raw_reads
├── batch_1
│   ├── C_R1.fastq
│   ├── C_R2.fastq
│   ├── D_R1.fastq
│   └── D_R2.fastq
├── A_R1.fq.gz
├── A_R2.fq.gz
├── B_R1.fq.gz
└── B_R2.fq.gz
```

* If you want to analyze all the FASTQ files in `raw_reads` (including the subdirectory `batch_1`) you can simply use `-r raw_reads`
* To analyze only samples `A` and `D`: `-r raw_reads/A_R1.fq.gz raw_reads/A_R2.fq.gz raw_reads/batch_1/D_R1.fastq raw_reads/batch_1/D_R2.fastq` or more easily `-r raw_reads/A_R?.fq.gz raw_reads/batch_1/D_R?.fastq`
* To analyze only the samples inside `raw_reads` but not in `batch_1`: `-r raw_reads/*.*`

---

## *Output*

---

### **`-o, --out`**

With this option you can redirect the output directory to a path of your choice, that path will be created if it doesn’t already exist.

This argument is optional, the default is **./01\_clean\_reads/**

---

### **`--keep_all`**

Many intermediate files are created during the read cleanup, some are large (like FASTQ files) while others small (like temporary logs). `Captus` deletes all the unnecesary intermediate files unless you enable this flag.

---

### **`--overwrite`**

Use this flag with caution, this will replace any previous result within the output directory (for the sample names that match).

---

## *Adaptor trimming*

---

### **`--adaptor_set`**

We have bundled with `Captus` adaptor sequences, these options are available:

* `Illumina` = Adaptor set copied from `BBTools`.
* `BGI` = Including BGISEQ, DNBSEQ, and MGISEQ.
* `ALL` = If you are unsure of the technology used for your sequences this combines both sets of adaptors.

This argument is optional, the default is **ALL**.

---

### **`--rna`**

Enable this flag to trim poly-A tails from RNA-Seq reads.

---

## *Quality trimming and filtering*

Here you can control [PHRED](https://drive5.com/usearch/manual/quality_score.html) quality score thresholds. `BBTools` uses the [PHRED algorithm](http://seqanswers.com/forums/showpost.php?p=144154&postcount=17) to trim low-quality bases or to discard low-quality reads.

---

### **`--trimq`**

Leading and trailing read regions with average PHRED quality score below this value will be trimmed.

Many people raise this value to 20 or even higher but that usually [discards lots of useful data for *de novo* assembly](https://www.biostars.org/p/124207/). In general, unless you have really high sequencing depth, don’t increase this threshold beyond ~16.

This argument is optional, the default is **13**.

---

### **`--maq`**

Once the trimming of low-quality bases from both ends of the reads has been completed, the average PHRED score of the entire read is recalculated and reads that do not have at least this **m**inimum **a**verage **q**uality are discarded.

Again, very high thresholds will throw away useful data. In general, set it to at least `trimq` or just a couple numbers higher.

This argument is optional, the default is **16**.

---

### **`--ftl`**

Trim any base to the left of this position. For example, if you want to remove 4 bases from the left of the reads set this number to 5.

This argument is optional, the default is **0** (no `ftl` applied).

---

### **`--ftr`**

Trim any base to the right of this position. For example, if you want to truncate your reads length to 100 bp set this number to 100

This argument is optional, the default is **0** (no `ftr` applied).

---

## *QC Statistics*

---

### **`--qc_program`**

Select the program for obtaining the statistics from your FASTQ files. Both programs should return identical results, but `Falco` is much faster. Valid options are:

* `Falco`
* `FastQC`

This argument is optional, the default is **FastQC**.

---

### **`--skip_qc_stats`**

This flag disables the `Falco` or `FastQC` analysis, keep in mind that the final HTML report can’t be created without the results from this analysis.

---

## *Other*

---

### **`--bbduk_path`**, **`--falco_path`**, **`--fastqc_path`**

If you have installed your own copies of `bbduk.sh`, `Falco`, or `FastQC` you can provide the full path to those copies.

These arguments are optional, the defaults are **bbduk.sh**, **falco**, and **fastqc** respectively.

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