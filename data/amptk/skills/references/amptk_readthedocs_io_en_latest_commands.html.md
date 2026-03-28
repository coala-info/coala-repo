[AMPtk](index.html)

latest

* [AMPtk Overview](overview.html)
* [AMPtk Quick Start](quick-start.html)
* [AMPtk file formats](file-formats.html)
* [AMPtk Pre-Processing](pre-processing.html)
* [AMPtk Clustering](clustering.html)
* [AMPtk OTU Table Filtering](filtering.html)
* [AMPtk Taxonomy](taxonomy.html)
* AMPtk Commands
  + [AMPtk wrapper script](#amptk-wrapper-script)
  + [AMPtk Pre-Processing](#amptk-pre-processing)
    - [amptk ion](#amptk-ion)
    - [amptk illumina](#amptk-illumina)
    - [amptk illumina2](#amptk-illumina2)
    - [amptk illumina3](#amptk-illumina3)
    - [amptk 454](#amptk-454)
    - [amptk SRA](#amptk-sra)
  + [AMPtk Clustering](#amptk-clustering)
    - [amptk cluster](#amptk-cluster)
    - [amptk dada2](#amptk-dada2)
    - [amptk unoise2](#amptk-unoise2)
    - [amptk unoise3](#amptk-unoise3)
    - [amptk cluster\_ref](#amptk-cluster-ref)
  + [AMPtk Utilities](#amptk-utilities)
    - [amptk filter](#amptk-filter)
    - [amptk lulu](#amptk-lulu)
    - [amptk taxonomy](#amptk-taxonomy)
    - [amptk show](#amptk-show)
    - [amptk select](#amptk-select)
    - [amptk remove](#amptk-remove)
    - [amptk sample](#amptk-sample)
    - [amptk drop](#amptk-drop)
    - [amptk stats](#amptk-stats)
    - [amptk summarize](#amptk-summarize)
    - [amptk funguild](#amptk-funguild)
    - [amptk meta](#amptk-meta)
    - [amptk heatmap](#amptk-heatmap)
    - [amptk SRA-submit](#amptk-sra-submit)
  + [AMPtk Setup](#amptk-setup)
    - [amptk install](#amptk-install)
    - [amptk database](#amptk-database)
    - [amptk primers](#amptk-primers)
* [AMPtk Downstream Tools](downstream.html)

[AMPtk](index.html)

* AMPtk Commands
* [Edit on GitHub](https://github.com/nextgenusfs/amptk/blob/master/docs/commands.rst)

---

# AMPtk Commands[¶](#amptk-commands "Link to this heading")

A description for all AMPtk commands.

## AMPtk wrapper script[¶](#amptk-wrapper-script "Link to this heading")

AMPtk is a series of Python scripts that are launched from a Python wrapper script. Each command has a help menu which you can print to the terminal by issuing the command without any arguments, i.e. `amptk` yields the following.

```
$ amptk

Usage:       amptk <command> <arguments>
version:     1.3.0

Description: AMPtk is a package of scripts to process NGS amplicon data.
             Dependencies:  USEARCH v9.1.13 and VSEARCH v2.2.0

Process:     ion         pre-process Ion Torrent data
             illumina    pre-process folder of de-multiplexed Illumina data
             illumina2   pre-process PE Illumina data from a single file
             illumina3   pre-process PE Illumina + index reads (i.e. EMP protocol)
             454         pre-process Roche 454 (pyrosequencing) data
             SRA         pre-process single FASTQ per sample data (i.e. SRA data)

Clustering:  cluster     cluster OTUs (using UPARSE algorithm)
             dada2       dada2 denoising algorithm (requires R, dada2, ShortRead)
             unoise2     UNOISE2 denoising algorithm
             unoise3     UNOISE3 denoising algorithm
             cluster_ref closed/open reference based clustering (EXPERIMENTAL)

Utilities:   filter      OTU table filtering
             lulu        LULU amplicon curation of OTU table
             taxonomy    Assign taxonomy to OTUs
             show        show number or reads per barcode from de-multiplexed data
             select      select reads (samples) from de-multiplexed data
             remove      remove reads (samples) from de-multiplexed data
             sample      sub-sample (rarify) de-multiplexed reads per sample
             drop        Drop OTUs from dataset
             stats       Hypothesis test and NMDS graphs (EXPERIMENTAL)
             summarize   Summarize Taxonomy (create OTU-like tables and/or stacked bar graphs)
             funguild    Run FUNGuild (annotate OTUs with ecological information)
             meta        pivot OTU table and append to meta data
             heatmap     Create heatmap from OTU table
             SRA-submit  De-multiplex data and create meta data for NCBI SRA submission

Setup:       install     Download/install pre-formatted taxonomy DB. Only need to run once.
             database    Format Reference Databases for Taxonomy
             info        List software version and installed databases
             primers     List primers hard-coded in AMPtk. Can use in pre-processing steps.
             version     List version
             citation    List citation
```

## AMPtk Pre-Processing[¶](#amptk-pre-processing "Link to this heading")

### amptk ion[¶](#amptk-ion "Link to this heading")

Script that demulitplexes Ion Torrent data. Input can be either an unaligned BAM file or FASTQ file. The IonXpress 1-96 barcodes are hard-coded into AMPtk and is the default setting for providing barcode sequences to the script. Alternatively, you can provide a `--barcode_fasta` file containing barcodes used or a QIIME like mapping file. For file formats see [here](file-formats.html#file-formats), and for more information see [here](pre-processing.html#pre-processing).

```
Usage:       amptk ion <arguments>
version:     1.3.0

Description: Script processes Ion Torrent PGM data for AMPtk clustering.  The input to this script
             should be a FASTQ file obtained from the Torrent Server analyzed with the
             `--disable-all-filters` flag to the BaseCaller.  This script does the following:
             1) finds Ion barcode sequences, 2) relabels headers with appropriate barcode name,
             3) removes primer sequences, 4) trim/pad reads to a set length.

Arguments:   -i, --fastq,--bam   Input BAM or FASTQ file (Required)
             -o, --out           Output base name. Default: out
             -m, --mapping_file  QIIME-like mapping file
             -f, --fwd_primer    Forward primer sequence. Default: fITS7
             -r, --rev_primer    Reverse primer sequence Default: ITS4
             -b, --barcodes      Barcodes used (list, e.g: 1,3,4,5,20). Default: all
             -n, --name_prefix   Prefix for re-naming reads. Default: R_
             -l, --trim_len      Length to trim/pad reads. Default: 300
             -p, --pad           Pad reads with Ns if shorter than --trim_len. Default: off [on,off]
             --min_len           Minimum length read to keep. Default: 100
             --full_length       Keep only full length sequences.
             --barcode_fasta     FASTA file containing barcodes. Default: pgm_barcodes.fa
             --barcode_mismatch   Number of mismatches in barcode to allow. Default: 0
             --primer_mismatch   Number of mismatches in primers to allow. Default: 2
             --cpus              Number of CPUs to use. Default: all
             --mult_samples      Combine multiple chip runs, name prefix for chip
```

### amptk illumina[¶](#amptk-illumina "Link to this heading")

Script for demultiplexing Illumina PE data that has been delivered from sequencing center in a folder of PE FASTQ files, one set for each sample. More information is [here](pre-processing.html#pre-processing).

```
Usage:       amptk illumina <arguments>
version:     1.3.0

Description: Script takes a folder of Illumina MiSeq data that is already de-multiplexed
             and processes it for clustering using AMPtk.  The default behavior is to:
             1) merge the PE reads using USEARCH, 2) find and trim primers, 3) rename reads
             according to sample name, 4) trim/pad reads to a set length.

Arguments:   -i, --fastq         Input folder of FASTQ files (Required)
             -o, --out           Output folder name. Default: amptk-data
             -m, --mapping_file  QIIME-like mapping file
             -f, --fwd_primer    Forward primer sequence. Default: fITS7
             -r, --rev_primer    Reverse primer sequence Default: ITS4
             -l, --trim_len      Length to trim/pad reads. Default: 300
             -p, --pad           Pad reads with Ns if shorter than --trim_len. Default: off [on,off]
             --min_len           Minimum length read to keep. Default: 100
             --full_length       Keep only full length sequences.
             --reads             Paired-end or forward reads. Default: paired [paired, forward]
             --read_length       Illumina Read length (250 if 2 x 250 bp run). Default: auto detect
             --rescue_forward    Rescue Forward Reads if PE do not merge, e.g. long amplicons. Default: on [on,off]
             --require_primer    Require the Forward primer to be present. Default: on [on,off]
             --primer_mismatch   Number of mismatches in primers to allow. Default: 2
             --barcode_mismatch   Number of mismatches in barcode to allow. Default: 1
             --cpus              Number of CPUs to use. Default: all
             --cleanup           Remove intermediate files.
             --merge_method      Software to use for PE merging. Default: usearch [usearch,vsearch]
             -u, --usearch       USEARCH executable. Default: usearch9
```

### amptk illumina2[¶](#amptk-illumina2 "Link to this heading")

This script is for demultiplexing Illumina data that is delivered as either a single FASTQ file or PE FASTQ files where the read layout contains unique barcode sequences at the 5’ or the 3’ end of the amplicons. More information is [here](pre-processing.html#pre-processing).

```
Usage:       amptk illumina2 <arguments>
version:     1.3.0

Description: Script takes Illumina data that is not de-multiplexed and has read structure
             similar to Ion/454 such that the reads are <barcode><fwd_primer>Read<rev_primer> for
             clustering using AMPtk.  The default behavior is to: 1) find barcodes/primers,
             2) relabel headers and trim barcodes/primers, 3) merge the PE reads,
             4) trim/pad reads to a set length.  This script can handle dual barcodes
             (3' barcodes using the --reverse_barcode option or mapping file).

Arguments:   -i, --fastq            Illumina R1 (PE forward) reads (Required)
             --reverse              Illumina R2 (PE reverse) reads.
             -o, --out              Output base name. Default: illumina2
             -m, --mapping_file     QIIME-like mapping file
             -f, --fwd_primer       Forward primer sequence. Default: fITS7
             -r, --rev_primer       Reverse primer sequence Default: ITS4
             -n, --name_prefix      Prefix for re-naming reads. Default: R_
             -l, --trim_len         Length to trim/pad reads. Default: 300
             -p, --pad              Pad reads with Ns if shorter than --trim_len. Default: off [on,off]
             --min_len              Minimum length read to keep. Default: 100
             --barcode_fasta        FASTA file containing barcodes.
             --reverse_barcode      FASTA file containing R2 barcodes.
             --barcode_mismatch     Number of mismatches in barcode to allow. Default: 0
             --barcode_not_anchored Barcodes are not anchored to start of read.
             --full_length          Keep only full length sequences.
             --primer_mismatch      Number of mismatches in primers to allow. Default: 2
             --merge_method         Software to use for PE merging. Default: usearch [usearch,vsearch]
             --cpus                 Number of CPUs to use. Default: all
             -u, --usearch          USEARCH executable. Default: usearch9
```

### amptk illumina3[¶](#amptk-illumina3 "Link to this heading")

This script demultiplexes Illumina PE data that is delivered as 3 files: forward reads (R1), reverse reads (R2), and then index reads (I3). More information is [here](pre-processing.html#pre-processing).

```
Usage:       amptk illumina3/emp <arguments>
version:     1.3.0

Description: Script takes PE Illumina reads, Index reads, mapping file and processes
             data for clustering/denoising in AMPtk.  The default behavior is to:
             1) find and trim primers, 2) merge the PE reads, 3) filter for Phix,
             4) rename reads according to sample name, 4) trim/pad reads.

Arguments:   -f, --forward       FASTQ R1 (forward) file (Required)
             -r, --reverse       FASTQ R2 (reverse) file (Required)
             -i, --index         FASTQ I3 (index) file (Required)
             -m, --mapping_file  QIIME-like mapping file.
             -l, --trim_len      Length to trim/pad reads. Default: 300
             -p, --pad           Pad reads with Ns if shorter than --trim_len. Default: off [on,off]
             -o, --out           Output folder name. Default: amptk-data
             --fwd_primer        Forward primer sequence
             --rev_primer        Reverse primer sequence
             --min_len           Minimum length read to keep. Default: 100
             --read_length       Illumina Read length (250 if 2 x 250 bp run). Default: auto detect
             --rescue_forward    Rescue Forward Reads if PE do not merge, e.g. long amplicons. Default: on [on,off]
             --barcode_fasta     Multi-fasta file of barocdes.
             --primer_mismatch   Number of mismatches in primers to allow. Default: 2
             --barcode_mismatch  Number of mismatches in index (barcodes) to allow. Default: 2
             --barcode_rev_comp  Reverse complement barcode sequences in mapping file.
             --merge_method      Software to use for PE merging. Default: usearch [usearch,vsearch]
             --cpus              Number of CPUs to use. Default: all
             --cleanup           Remove intermediate files.
             -u, --usearch       USEARCH executable. Default: usearch9
```

### amptk 454[¶](#amptk-454 "Link to this heading")

Script for demultiplexing Roche 454 data. Input requirements are a 454 run in SFF, FASTQ, or FASTA+QUAL format as well as a multi-FASTA file containing barcodes used. More information is [here](pre-processing.html#pre-processing).

```
Usage:       amptk 454 <arguments>
version:     1.3.0

Description: Script processes Roche 454 data for AMPtk clustering.  The input to this script
             should be either a SFF file, FASTA+QUAL files, or FASTQ file.  This script does
             the following: 1) finds barcode sequences, 2) relabels headers with appropriate
             barcode name, 3) removes primer sequences, 4) trim/pad reads to a set length.

Arguments:   -i, --sff, --fasta  Input file (SFF, FASTA, or FASTQ) (Required)
             -q, --qual          QUAL file (Required if -i is FASTA).
             -o, --out           Output base name. Default: out
             -m, --mapping_file  QIIME-like mapping file
             -f, --fwd_primer    Forward primer sequence. Default: fITS7
             -r, --rev_primer    Reverse primer sequence Default: ITS4
             -n, --name_prefix   Prefix for re-naming reads. Default: R_
             -l, --trim_len      Length to trim/pad reads. Default: 250
             -p, --pad       