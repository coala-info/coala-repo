[seq2science](../../index.html)

* [Getting started](../gettingstarted.html)
* [Workflows](../workflows.html)
  + [Downloading fastqs](download_fastq.html)
  + [Alignment](alignment.html)
  + ATAC-seq
    - [Workflow overview (simplified)](#workflow-overview-simplified)
      * [Downloading of sample(s)](#downloading-of-sample-s)
      * [Downloading and indexing of assembly(s)](#downloading-and-indexing-of-assembly-s)
      * [Read trimming](#read-trimming)
      * [Alignment](#alignment)
      * [Bam sieving](#bam-sieving)
      * [Peak calling](#peak-calling)
      * [Quality report](#quality-report)
      * [Count table](#count-table)
      * [Differential motif analysis](#differential-motif-analysis)
      * [Differential peak analysis](#differential-peak-analysis)
      * [Trackhub](#trackhub)
    - [Filling out the samples.tsv](#filling-out-the-samples-tsv)
      * [Sample column](#sample-column)
      * [Assembly column](#assembly-column)
      * [Control (input) column](#control-input-column)
      * [Descriptive\_name column](#descriptive-name-column)
      * [Technical\_replicates column](#technical-replicates-column)
      * [Biological replicates](#biological-replicates)
      * [A mix of biological and technical replicates](#a-mix-of-biological-and-technical-replicates)
      * [Colors column](#colors-column)
      * [Final notes](#final-notes)
    - [Filling out the config.yaml](#filling-out-the-config-yaml)
    - [Best practices](#best-practices)
      * [MACS2 and –shift with paired-end data](#macs2-and-shift-with-paired-end-data)
      * [Irreproducible Discovery Rate](#irreproducible-discovery-rate)
      * [subsampling](#subsampling)
  + [ChIP-seq](chip_seq.html)
  + [RNA-seq](rna_seq.html)
  + [scATAC-seq](scatac_seq.html)
  + [scRNA-seq](scrna_seq.html)
* [Using the results](../results.html)
* [Extensive docs](../extensive_docs.html)
* [Extra resources](../extracontent.html)
* [Frequently Asked Questions (FAQ)](../faq.html)
* [Contributing to seq2science](../../CONTRIBUTING.html)

[seq2science](../../index.html)

* [Workflows](../workflows.html)
* ATAC-seq
* [Edit on GitHub](https://github.com/vanheeringen-lab/seq2science/blob/master/docs/content/workflows/atac_seq.md)

---

# ATAC-seq[](#atac-seq "Link to this heading")

Preprocessing of ATAC-seq has never been easier!

## Workflow overview (simplified)[](#workflow-overview-simplified "Link to this heading")

![](../../_static/atac_seq.png)

An example quality control report can be [viewed here](https://vanheeringen-lab.github.io/seq2science/_static/atac_seq_multiqc.html).

### Downloading of sample(s)[](#downloading-of-sample-s "Link to this heading")

Depending on whether the samples you start seq2science with is your own data, public data, or a mix, the pipeline might start with downloading samples.
The downloading of samples is integrated into each workflow, so you don’t have to start a download workflow first.
You control which samples are used in the [samples.tsv](#filling-out-the-samples-tsv).
Background on public data can be found [here](./download_fastq.html#download-sra-file).

### Downloading and indexing of assembly(s)[](#downloading-and-indexing-of-assembly-s "Link to this heading")

Depending on whether the assembly and its index you align your samples against already exist seq2science will start with downloading of the assembly through [genomepy](https://github.com/vanheeringen-lab/genomepy).

### Read trimming[](#read-trimming "Link to this heading")

The pipeline starts by trimming the reads with Trim Galore! or Fastp (the default).
The trimmer will automatically trim the low quality 3’ ends of reads, and removes short reads.
During quality trimming it automatically detects which sequencing adapter was used (if it wasn’t trimmed off yet), and then trims this as well.
Trimming parameters for the pipeline can be set in the configuration, for example:

```
trimmer:
  fastp:
    trimoptions: --trim_front1 3 --trim_front2 14 --trim_poly_x
```

### Alignment[](#alignment "Link to this heading")

After trimming the reads are aligned against an assembly. Currently we support *bowtie2*, *bwa*, *bwa-mem2*, *hisat2*, *minimap2* and *STAR* as aligners. Choosing which aligner is as easy as setting the *aligner* variable in the `config.yaml`, for example: `aligner: bwa`. Sensible defaults have been set for every aligner, but can be overwritten for either (or both) the indexing and alignment by specifying them in the `config.yaml`:

```
aligner:
  bwa-mem:
    index: '-a bwtsw'
    align: '-M'
```

The pipeline will check if the assembly you specified is present in the *genome\_dir*, and otherwise will download it for you through [genomepy](https://github.com/vanheeringen-lab/genomepy). All these aligners require an index to be formed first for each assembly, but don’t worry, the pipeline does this for you.

### Bam sieving[](#bam-sieving "Link to this heading")

After aligning the bam you can choose to remove unmapped reads, low quality mappings, duplicates, and multimappers. It is also advisable to remove mitochondrially mapped reads for ATAC-seq analysis, plus to get slightly more accurate peaks you can set set the workflow to apply a tn5 shift. Finally you are probably interested in reads from the nucleosome-free region, so by selecting paired-end reads with a short insert-size (+/- 150 bp) you filter out reads from the mono-di-tri-etc nucleosomes.

### Peak calling[](#peak-calling "Link to this heading")

Currently we support two peak callers for the ATAC-seq workflow, MACS2 and genrich.

#### MACS2[](#macs2 "Link to this heading")

[MACS2](https://github.com/taoliu/MACS) is the successor of MACS, created by [taoliu](https://github.com/taoliu) (also one of the co-authors of hmmratac). MACS2 generates a ‘*pileup*‘ of all the reads. You can imagine this pileup as laying all reads on top of each other on the genome, and counting how high your pile gets for each basepair. MACS2 then models ‘*background*‘ values, based on the total length of all your reads and the genome length, to a [Poisson distribution](https://en.wikipedia.org/wiki/Poisson_distribution) and decides whether your experimental pileup is significant compared to the poisson distribution. MACS2 is one of the, if not the, most used peak caller.

For the calculation of peaks MACS2 requires that an “effective” genome size is being passed as one of its arguments. For the more common assemblies (e.g. mm10 and human) these numbers can be found online. However we found googling these numbers quite the hassle, and for lesser studied species these numbers can’t be found online. Therefore the pipeline automatically estimates the effective genome size, we calculate this as **the number of unique kmers of the average read length**.

#### Genrich[](#genrich "Link to this heading")

[Genrich](https://github.com/jsh58/Genrich) is a spiritual successor of MACS2, created by [John M. Gaspar](https://github.com/jsh58). Just like MACS2 is generates a ‘*pileup’*. However the author of genrich realized that the distribution of pileup never follows a poisson distribution. Genrich then uses a [log-normal distribution](https://en.wikipedia.org/wiki/Log-normal_distribution) to model the background.

#### HMMRATAC (stub, not fully supported!)[](#hmmratac-stub-not-fully-supported "Link to this heading")

[HMMRATAC](https://github.com/LiuLabUB/HMMRATAC) is a peak caller specifically made for ATAC-seq data. HMMRATAC does not generate a so-called pileup. It however looks at the length distribution of reads. Since the tn5 transposase prefers to cut at nucleosome free regions in the DNA, we see that our reads are either short (at open DNA), or the length of 1 (or 2, 3, 4, etc.) nucleosomes long. HMMRATAC then classifies regions in the genome based on the length distribution of the reads in open chromatin, flanking regions, non-flanking regions and background.

### Quality report[](#quality-report "Link to this heading")

It is always a good idea to check the quality of your samples. Along the way different quality control steps are taken, and are outputted in a single [multiqc report](https://multiqc.info/) in the `qc` folder. Make sure to always check the report, and take a look at [interpreting the multiqc report](../results.html#multiqc-quality-report)!

### Count table[](#count-table "Link to this heading")

A useful result the pipeline outputs is the count table, located at {counts\_dir}/{peak\_caller}/.
For each narrowpeak (across all samples) its summit is taken, and all other summits within range `peak_windowsize` (default 100) are taken together, and the summit with the highest q-value is taken as the “true” peak.
The remaining peaks are extended by `slop` on each side and for each sample the number of reads are counted under this peak.
This file is stored as {assembly}\_raw.tsv, and looks something like this:

```
                sample1     sample2
chr1:5649-5849  75.00000    0.00000
chr1:7399-7599  47.00000    1.00000
```

Seq2science currently supports four different normalisation methods: quantile normalisation, TMM, RLE, and upperquartile normalisation, and does count-per-million (counts under peaks) normalisation on each before normalisation.

* [\*\*Quantile normalization\*\*](https://en.wikipedia.org/wiki/Quantile_normalization) is a type of normalization that makes the distribution between samples identical. This means that the actual count distribution within a sample changes. This normalisation is especially powerful when comparing results from different labs/experiments/experimental methods.
* **TMM** is the weighted trimmed mean of M-values proposed by Robinson and Oshlack (2010).
* **RLE** is the scaling factor method proposed by Anders and Huber (2010). DEseq2’s standard normalisation is based on this.
* **Upper quartile** is the upper-quartile normalization method of Bullard et al (2010).

After these normalisations the counts are log normalised, and the base can be set with `logbase` and defaults to 2.
As a final step the count tables are mean-centered.
Note that this table contains **all** peaks, and no selection on differential peaks has been made.

### Differential motif analysis[](#differential-motif-analysis "Link to this heading")

Seq2science supports differential motif analysis!
This analysis is based on the tool [gimme maelstrom](https://gimmemotifs.readthedocs.io/en/master/reference.html#command-gimme-maelstrom).
As input to gimme maelstrom is the log 2 transformed quantile normalized count table of the biological reps (average between reps) in the consensus peakset.
It then tries to solve a system of linear equations, where the output is the read counts in a peak, and the input is the motif score in the peak times the “motif activity”.
This motif activity can then be compared across biological replicates for differential motifs.

By default seq2science makes use of the gimme.vertebrate.v5.0 motif database.
This can be changed with the `gimme_maelstrom_database` config option.
The gimme.vertebrate.v5.0 motif database is based on human and mouse gene names.
When making use of a non-human/mouse genome assembly, seq2science makes use of the gimme motif2factors command to update the gene names for the used assembly.
This option can be turned on/off with the `infer_motif2factors` option.
Updating the motif database is done by downloading a set of other genome assemblies (including mouse and human), and inferring the orthologous between the used assembly and the human/mouse motif database.
The config option `motif2factors_reference` controls which assemblies are used for ortholog inference, and comes with a default set of vertebrate assemblies.
The config option `motif2factors_database_references` controls on which assemblies the reference is based on, and is by default the human and mouse genome assembly.

If you change the `gimme_maelstrom_database` to, for instance, an invertebrate database, and you want the motif database to use the gene names in your assembly.
You will also have to update the `motif2factors_reference` and the `motif2factors_database_references`.

See the [gimme motif2factors docs](https://gimmemotifs.readthedocs.io/en/master/reference.html#command-gimme-motif2factors) for a more extensive explanation of how the motif database is updated.

### Differential peak analysis[](#differential-peak-analysis "Link to this heading")

On top of that, Seq2science can also use the raw peak counts table to perform differential peak analysis with DESeq2.
See [Differential gene/peak analysis page](../DESeq2.html) for more information!

### Trackhub[](#trackhub "Link to this heading")

A UCSC compatible trackhub can be generated for this workflow. See the [trackhub page](../results.html#trackhub) for more information!

## Filling out the samples.tsv[](#filling-out-the-samples-tsv "Link to this heading")

Before running a workflow you will have to specify which samples you want to run the workflow on. Each workflow starts with a `samples.tsv` as an example, and you should adapt it to your specific needs. As an example, the `samples.tsv` could look something like this:

```
sample    assembly    technical_replicates    descriptive_name    control
GSM123    GRCh38      heart_1      heart_merged        GSM234
GSM321    GRCh38      heart_1      heart_merged        GSM234
GSMabc    GRCh38      heart_2      heart_not_merged    GSM234
GSMxzy    danRer11    stage_8      stage_8             GSM234
GSM890    danRer11    stage_9      stage_9             GSM234
```

### Sample column[](#sample-column "Link to this heading")

If you use the pipeline on **public data** this should be the name of the accession (e.g. GSM2837484).
Accepted formats start with “GSM”, “SRR”, “SRX”, “DRR”, “DRX”, “ERR” or “ERX”.

If you use the pipeline on **local data** this should be the *basename* of the file without the *extension(s)*.
For example:

* `/home/user/myfastqs/sample1.fastq.gz` ——-> `sample1` for single-ended data
* `/home/user/myfastqs/sample2_R1.fastq.gz` ┬> `sample2` for paired-ended data
   `/home/user/myfastqs/sample2_R2.fastq.gz` ┘

For **local data**, some fastq files may have slightly different naming formats.
For instance, Illumina may produce a sample named `sample3_S1_L001_R1_001.fastq.gz` (and the `R2` fastq).
Seq2science will attempt to recognize these files based on the sample name `sample3`.

For **both local and public data**, identifiers used to recognize fastq files are the fastq read extensions (`R1` and `R2` by default) and the fastq suffix (`fastq` by default).
The directory where seq2science will store (or look for) fastqs is determined by the `fastq_dir` config option.
In the example above, the `fastq_dir` should be set to `/home/user/myfastqs`.
These setting can be changed in the `config.yaml`.

### Assembly column[](#assembly-column "Link to this heading")

Here you simply add the name of the assembly you want your samples aligned against and the wo