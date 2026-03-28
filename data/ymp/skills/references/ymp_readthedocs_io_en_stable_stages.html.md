### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index")
* [next](modules.html "API")
* [previous](commandline.html "Command Line")
* [YMP Extensible Omics Pipeline 0.2.1 documentation](index.html) »
* Stages

# Stages[¶](#stages "Permalink to this headline")

Listing of stages implemented in YMP

System Message: ERROR/3 (/home/docs/checkouts/readthedocs.org/user\_builds/ymp/checkouts/stable/doc/stages.rst, line 1)

Error in “sm:stage” directive:
1 argument(s) required, 0 supplied.

```
.. sm:stage::
   :source: ymp/rules/00_import.rules:64

   Imports raw read files into YMP.

   >>> ymp make toy
   >>> ymp make mpic
```

*stage* `annotate_blast`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-127)[¶](#stage-annotate_blast "Permalink to this definition")
:   Annotate sequences with BLAST

    Searches a reference database for hits with `blastn`. Use `E`
    flag to specify exponent to required E-value. Use `N` or
    `Mega` to specify default. Use `Best` to add
    `-subject_besthit` flag.

*stage* `annotate_diamond`[[source]](_snakefiles/ymp/rules/diamond.rules.html#line-39)[¶](#stage-annotate_diamond "Permalink to this definition")
:   FIXME

*stage* `annotate_prodigal`[[source]](_snakefiles/ymp/rules/prodigal.rules.html#line-3)[¶](#stage-annotate_prodigal "Permalink to this definition")
:   Call genes using prodigal

    ```
    >>> ymp make toy.ref_genome.annotate_prodigal
    ```

*stage* `annotate_tblastn`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-58)[¶](#stage-annotate_tblastn "Permalink to this definition")
:   Runs `tblastn`

*stage* `assemble_megahit`[[source]](_snakefiles/ymp/rules/megahit.rules.html#line-8)[¶](#stage-assemble_megahit "Permalink to this definition")
:   Assemble metagenome using MegaHit.

    ```
    >>> ymp make toy.assemble_megahit.map_bbmap
    >>> ymp make toy.group_ALL.assemble_megahit.map_bbmap
    >>> ymp make toy.group_Subject.assemble_megahit.map_bbmap
    ```

*stage* `assemble_metaspades`[[source]](_snakefiles/ymp/rules/spades.rules.html#line-3)[¶](#stage-assemble_metaspades "Permalink to this definition")
:   Assemble reads using metaspades

    ```
    >>> ymp make toy.assemble_metaspades
    >>> ymp make toy.group_ALL.assemble_metaspades
    >>> ymp make toy.group_Subject.assemble_metaspades
    ```

*stage* `assemble_trinity`[[source]](_snakefiles/ymp/rules/trinity.rules.html#line-3)[¶](#stage-assemble_trinity "Permalink to this definition")

*stage* `bin_metabat2`[[source]](_snakefiles/ymp/rules/metabat2.rules.html#line-6)[¶](#stage-bin_metabat2 "Permalink to this definition")
:   Bin metagenome assembly into MAGs

*stage* `check`[[source]](_snakefiles/ymp/rules/test.rules.html#line-5)[¶](#stage-check "Permalink to this definition")
:   Verify file availability

    This stage provides rules for checking the file availability at a given point
    in the stage stack.

    Mainly useful for testing and debugging.

*stage* `cluster_cdhit`[[source]](_snakefiles/ymp/rules/cdhit.rules.html#line-3)[¶](#stage-cluster_cdhit "Permalink to this definition")
:   Clusters protein sequences using CD-HIT

    ```
    >>> ymp make toy.ref_query.cluster_cdhit
    ```

*stage* `correct_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-65)[¶](#stage-correct_bbmap "Permalink to this definition")
:   Correct read errors by overlapping inside tails

    Applies `BBMap's` “bbmerge.sh ecco” mode. This will overlap the inside of
    read pairs and choose the base with the higher quality where the alignment
    contains mismatches and increase the quality score as indicated by the double
    observation where the alignment contains matches.

    ```
    >>> ymp make toy.correct_bbmap
    >>> ymp make mpic.correct_bbmap
    ```

*stage* `count_diamond`[[source]](_snakefiles/ymp/rules/diamond.rules.html#line-145)[¶](#stage-count_diamond "Permalink to this definition")

*stage* `count_stringtie`[[source]](_snakefiles/ymp/rules/stringtie.rules.html#line-4)[¶](#stage-count_stringtie "Permalink to this definition")

*stage* `coverage_samtools`[[source]](_snakefiles/ymp/rules/samtools.rules.html#line-126)[¶](#stage-coverage_samtools "Permalink to this definition")
:   Computes coverage from a sorted bam file using `samtools coverage`

*stage* `dedup_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-209)[¶](#stage-dedup_bbmap "Permalink to this definition")
:   Remove duplicate reads

    Applies BBMap’s “dedupe.sh”

    ```
    >>> ymp make toy.dedup_bbmap
    >>> ymp make mpic.dedup_bbmap
    ```

*stage* `dust_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-517)[¶](#stage-dust_bbmap "Permalink to this definition")
:   Perform entropy filtering on reads using BBMap’s bbduk.sh

    The parameter `Enn` gives the entropy cutoff. Higher values
    filter more sequences.

    ```
    >>> ymp make toy.dust_bbmap
    >>> ymp make toy.dust_bbmapE60
    ```

*stage* `extract_reads`[[source]](_snakefiles/ymp/rules/samtools.rules.html#line-3)[¶](#stage-extract_reads "Permalink to this definition")
:   Extract reads from BAM file using `samtools fastq`.

    Parameters `fn`, `Fn` and `Gn` are passed through.
    Some options include:

    * f2: fully mapped (only proper pairs)
    * F2: not fully mapped (unmapped at least one read)
    * f12: not mapped (neither read mapped)

*stage* `extract_seqs`[[source]](_snakefiles/ymp/rules/samtools.rules.html#line-54)[¶](#stage-extract_seqs "Permalink to this definition")
:   Extract sequences from `.fasta.gz` file using `samtools faidx`

    Currently requires a `.blast7` file as input.

    Use parameter `Nomatch` to instead keep unmatched sequences.

*stage* `filter_bmtagger`[[source]](_snakefiles/ymp/rules/bmtagger.rules.html#line-74)[¶](#stage-filter_bmtagger "Permalink to this definition")
:   Filter(-out) contaminant reads using BMTagger

    ```
    >>> ymp make toy.ref_phiX.index_bmtagger.remove_bmtagger
    >>> ymp make toy.ref_phiX.index_bmtagger.remove_bmtagger.assemble_megahit
    >>> ymp make toy.ref_phiX.index_bmtagger.filter_bmtagger
    >>> ymp make mpic.ref_phiX.index_bmtagger.remove_bmtagger
    ```

*stage* `format_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-567)[¶](#stage-format_bbmap "Permalink to this definition")
:   Process sequences with BBMap’s format.sh

    Parameter `Ln` filters sequences at a minimum length.

    ```
    >>> ymp make toy.assemble_metaspades.format_bbmapL200
    ```

*stage* `humann2`[[source]](_snakefiles/ymp/rules/humann2.rules.html#line-30)[¶](#stage-humann2 "Permalink to this definition")
:   Compute functional profiles using HUMAnN2

*stage* `index_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-23)[¶](#stage-index_bbmap "Permalink to this definition")
:   ```
    >>> ymp make toy.ref_genome.index_bbmap
    ```

*stage* `index_blast`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-21)[¶](#stage-index_blast "Permalink to this definition")

*stage* `index_bmtagger`[[source]](_snakefiles/ymp/rules/bmtagger.rules.html#line-11)[¶](#stage-index_bmtagger "Permalink to this definition")

*stage* `index_bowtie2`[[source]](_snakefiles/ymp/rules/bowtie2.rules.html#line-5)[¶](#stage-index_bowtie2 "Permalink to this definition")
:   ```
    >>> ymp make toy.ref_genome.index_bowtie2
    ```

*stage* `index_diamond`[[source]](_snakefiles/ymp/rules/diamond.rules.html#line-3)[¶](#stage-index_diamond "Permalink to this definition")

*stage* `map_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-447)[¶](#stage-map_bbmap "Permalink to this definition")
:   Map reads using BBMap

    ```
    >>> ymp make toy.assemble_megahit.map_bbmap
    >>> ymp make toy.ref_genome.map_bbmap
    >>> ymp make mpic.ref_ssu.map_bbmap
    ```

*stage* `map_bowtie2`[[source]](_snakefiles/ymp/rules/bowtie2.rules.html#line-41)[¶](#stage-map_bowtie2 "Permalink to this definition")
:   Map reads using Bowtie2

    ```
    >>> ymp make toy.ref_genome.index_bowtie2.map_bowtie2
    >>> ymp make toy.assemble_megahit.index_bowtie2.map_bowtie2
    >>> ymp make toy.group_Subject.assemble_megahit.index_bowtie2.map_bowtie2
    >>> ymp make mpic.ref_ssu.index_bowtie2.map_bowtie2
    ```

*stage* `map_diamond`[[source]](_snakefiles/ymp/rules/diamond.rules.html#line-88)[¶](#stage-map_diamond "Permalink to this definition")

*stage* `map_hisat2`[[source]](_snakefiles/ymp/rules/hisat2.rules.html#line-5)[¶](#stage-map_hisat2 "Permalink to this definition")
:   Map reads using Hisat2

*stage* `map_star`[[source]](_snakefiles/ymp/rules/star.rules.html#line-41)[¶](#stage-map_star "Permalink to this definition")
:   Map RNA-Seq reads with STAR

*stage* `metaphlan2`[[source]](_snakefiles/ymp/rules/metaphlan2.rules.html#line-8)[¶](#stage-metaphlan2 "Permalink to this definition")
:   Assess metagenome community composition using Metaphlan 2

*stage* `primermatch_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-383)[¶](#stage-primermatch_bbmap "Permalink to this definition")
:   Filters reads by matching reference primer

    ```
    >>> ymp make mpic.ref_primers.primermatch_bbmap
    ```

*stage* `profile_centrifuge`[[source]](_snakefiles/ymp/rules/centrifuge.rules.html#line-3)[¶](#stage-profile_centrifuge "Permalink to this definition")
:   Classify reads using centrifuge

*stage* `qc_fastqc`[[source]](_snakefiles/ymp/rules/fastqc.rules.html#line-4)[¶](#stage-qc_fastqc "Permalink to this definition")
:   Quality screen reads using FastQC

    ```
    >>> ymp make toy.qc_fastqc
    ```

*stage* `qc_multiqc`[[source]](_snakefiles/ymp/rules/multiqc.rules.html#line-5)[¶](#stage-qc_multiqc "Permalink to this definition")
:   Aggregate QC reports using MultiQC

*stage* `qc_quast`[[source]](_snakefiles/ymp/rules/quast.rules.html#line-3)[¶](#stage-qc_quast "Permalink to this definition")
:   Estimate assemly quality using Quast

*stage* `quant_rsem`[[source]](_snakefiles/ymp/rules/rsem.rules.html#line-27)[¶](#stage-quant_rsem "Permalink to this definition")
:   Quantify transcripts using RSEM

*stage* `references`[[source]](_snakefiles/ymp/rules/00_download.rules.html#line-46)[¶](#stage-references "Permalink to this definition")
:   This is a “virtual” stage. It does not process read data, but comprises
    rules used for reference provisioning.

*stage* `remove_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-293)[¶](#stage-remove_bbmap "Permalink to this definition")
:   Filter reads by reference

    This stage aligns the reads with a given reference using BBMap in fast mode.
    Matching reads are collected in the stage *filter\_bbmap* and remaining reads
    are collectec in the stage *remove\_bbmap*.

    ```
    >>> ymp make toy.ref_phiX.index_bbmap.remove_bbmap
    >>> ymp make toy.ref_phiX.index_bbmap.filter_bbmap
    >>> ymp make mpic.ref_phiX.index_bbmap.remove_bbmap
    ```

*stage* `sort_bam`[[source]](_snakefiles/ymp/rules/sambamba.rules.html#line-3)[¶](#stage-sort_bam "Permalink to this definition")

*stage* `split_library`[[source]](_snakefiles/ymp/rules/fastq-multx.rules.html#line-3)[¶](#stage-split_library "Permalink to this definition")
:   Demultiplexes amplicon sequencing files

    This rule is treated specially. If a configured project specifies
    a `barcode_col`, reads from the file (or files) are used in combination
    with

*stage* `trim_bbmap`[[source]](_snakefiles/ymp/rules/bbmap.rules.html#line-122)[¶](#stage-trim_bbmap "Permalink to this definition")
:   Trim adapters and low quality bases from reads

    Applies BBMap’s “bbduk.sh”.

    Parameters:
    :   A: append to enable adapter trimming
        Q20: append to select phred score cutoff (default 20)
        L20: append to select minimum read length (default 20)

    ```
    >>> ymp make toy.trim_bbmap
    >>> ymp make toy.trim_bbmapA
    >>> ymp make toy.trim_bbmapAQ10L10
    >>> ymp make mpic.trim_bbmap
    ```

*stage* `trim_sickle`[[source]](_snakefiles/ymp/rules/sickle.rules.html#line-4)[¶](#stage-trim_sickle "Permalink to this definition")
:   Perform read trimming using Sickle

    ```
    >>> ymp make toy.trim_sickle
    >>> ymp make toy.trim_sickleQ10L10
    >>> ymp make mpic.trim_sickleL20
    ```

*stage* `trim_trimmomatic`[[source]](_snakefiles/ymp/rules/trimmomatic.rules.html#line-3)[¶](#stage-trim_trimmomatic "Permalink to this definition")
:   Adapter trim reads using trimmomatic

    ```
    >>> ymp make toy.trim_trimmomaticT32
    >>> ymp make mpic.trim_trimmomatic
    ```

*rule* `download_file_ftp`[[source]](_snakefiles/ymp/rules/00_download.rules.html#line-2)[¶](#rule-download_file_ftp "Permalink to this definition")
:   Downloads remote file using *wget*

*rule* `download_file_http`[[source]](_snakefiles/ymp/rules/00_download.rules.html#line-24)[¶](#rule-download_file_http "Permalink to this definition")
:   Downloads remote file using internal downloader

*rule* `prefetch`[[source]](_snakefiles/ymp/rules/00_import.rules.html#line-12)[¶](#rule-prefetch "Permalink to this definition")
:   Downloads SRA files into NCBI SRA folder (ncbi/public/sra).

*rule* `fastq_dump`[[source]](_snakefiles/ymp/rules/00_import.rules.html#line-30)[¶](#rule-fastq_dump "Permalink to this definition")
:   Extracts FQ from SRA files

*rule* `combine_with_ref`[[source]](_snakefiles/ymp/rules/align.rules.html#line-1)[¶](#rule-combine_with_ref "Permalink to this definition")

*rule* `align_mafft`[[source]](_snakefiles/ymp/rules/align.rules.html#line-12)[¶](#rule-align_mafft "Permalink to this definition")

*rule* `blast7_merge`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-269)[¶](#rule-blast7_merge "Permalink to this definition")
:   Merges blast results from all samples into single file

*rule* `blast7_extract`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-301)[¶](#rule-blast7_extract "Permalink to this definition")
:   Generates meta-data csv and sequence fasta pair from blast7 file for one gene.

*rule* `blast7_extract_merge`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-361)[¶](#rule-blast7_extract_merge "Permalink to this definition")
:   Merges extracted csv/fasta pairs over all samples.

*rule* `blast7_all`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-386)[¶](#rule-blast7_all "Permalink to this definition")

*rule* `blast7_reports`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-399)[¶](#rule-blast7_reports "Permalink to this definition")

*rule* `blast7_eval_hist`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-406)[¶](#rule-blast7_eval_hist "Permalink to this definition")

*rule* `blast7_eval_plot`[[source]](_snakefiles/ymp/rules/blast.rules.html#line-439)[¶](#rule-blast7_eval_plot "Permalink to this definition")

*rule* `cdhit_fna_single`[[source]](_snakefiles/ymp/rules/cdhit.rules.html#line-132)[¶](#rule-cdhit_fna_single "Permalink to this definition")
:   Clustering predicted genes (nuc) using cdhit-est

*rule* `87`[[source]](_snakefiles/ymp/rules/convert.rules.html#line-8)[¶](#rul