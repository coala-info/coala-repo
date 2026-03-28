[sequenza-utils](index.html)

latest

* [Installation](install.html)
* Command line interface
  + [CG wiggle](#cg-wiggle)
  + [BAM/mpileup to seqz](#bam-mpileup-to-seqz)
  + [Binning seqz](#binning-seqz)
  + [VCF to seqz](#vcf-to-seqz)
  + [Merge overlapping seqz](#merge-overlapping-seqz)
* [User cookbook](guide.html)

* [API library interface](api.html)

[sequenza-utils](index.html)

* [Docs](index.html) »
* Command line interface
* [Edit on Bitbucket](https://bitbucket.org/sequenzatools/sequenza-utils/src/master/docs/commands.rst?mode=view)

---

# Command line interface[¶](#command-line-interface "Permalink to this headline")

The sequenza-utils comprehends several programs.
All programs are accessible from the sequenza-utils
command line interface.

```
$ sequenza-utils --help
usage: sequenza-utils [-h] [-v]
                      {bam2seqz,gc_wiggle,pileup2acgt,seqz_binning,seqz_merge,snp2seqz}
                      ...

Sequenza Utils is a collection of tools primarily design to convert bam, pileup and vcf files to seqz files, the format used in the sequenza R package

positional arguments:
    bam2seqz        Process a paired set of BAM/pileup files (tumor and
                    matching normal), and GC-content genome-wide
                    information, to extract the common positions withA and
                    B alleles frequencies
    gc_wiggle       Given a fasta file and a window size it computes the GC
                    percentage across the sequences, and returns a file in
                    the UCSC wiggle format.
    pileup2acgt     Parse the format from the samtools mpileup command, and
                    report the occurrence of the 4 nucleotides in each
                    position.
    seqz_binning    Perform the binning of the seqz file to reduce file
                    size and memory requirement for the analysis.
    seqz_merge      Merge two seqz files
    snp2seqz        Parse VCFs and other variant and coverage formats to
                    produce seqz files

optional arguments:
  -h, --help        show this help message and exit
  -v, --verbose     Show all logging information

This is version 2.1.9999b1 - Favero Francesco - 22 February 2019
```

## CG wiggle[¶](#cg-wiggle "Permalink to this headline")

```
$ sequenza-utils gc_wiggle
error: argument -f/--fasta is required
usage: sequenza-utils gc_wiggle -f FASTA [-o OUT] [-w WINDOW]

optional arguments:
  -f FASTA, --fasta FASTA
                        the fasta file. It can be a file name or "-" to use
                        STDIN
  -o OUT                Output file "-" for STDOUT
  -w WINDOW             The window size to calculate the GC-content percentage
```

## BAM/mpileup to seqz[¶](#bam-mpileup-to-seqz "Permalink to this headline")

```
$ sequenza-utils bam2seqz
error: argument -n/--normal is required
usage: sequenza-utils bam2seqz [-p] -n NORMAL -t TUMOR -gc GC [-F FASTA]
                               [-o OUT] [-n2 NORMAL2] [-C CHR [CHR ...]]
                               [--parallel NPROC] [-S SAMTOOLS] [-T TABIX]
                               [-q QLIMIT] [-f QFORMAT] [-N N] [--hom HOM]
                               [--het HET] [--het_f HET_F]

Input/Output:
  Input and output files.

  -p, --pileup          Use pileups as input files instead of BAMs.
  -n NORMAL, --normal NORMAL
                        Name of the BAM/pileup file from the reference/normal
                        sample
  -t TUMOR, --tumor TUMOR
                        Name of the BAM/pileup file from the tumor sample
  -gc GC                The GC-content wiggle file
  -F FASTA, --fasta FASTA
                        The reference FASTA file used to generate the
                        intermediate pileup. Required when input are BAM
  -o OUT, --output OUT  Name of the output file. To use gzip compression name
                        the file ending in .gz. Default STDOUT.
  -n2 NORMAL2, --normal2 NORMAL2
                        Optional BAM/pileup file used to compute the
                        depth.normal and depth-ratio, instead of using the
                        normal BAM.

Genotype:
  Options regarding the genotype filtering.

  --hom HOM             Threshold to select homozygous positions. Default 0.9.
  --het HET             Threshold to select heterozygous positions. Default
                        0.25.
  --het_f HET_F         Threshold of frequency in the forward strand to trust
                        heterozygous calls. Default -0.2 (Disabled, effective
                        with values >= 0).

Subset indexed files:
  Option regarding samtools and bam indexes.

  -C CHR [CHR ...], --chromosome CHR [CHR ...]
                        Argument to restrict the input/output to a chromosome
                        or a chromosome region. Coordinate format is Name:pos
                        .start-pos.end, eg: chr17:7565097-7590856, for a
                        particular region; eg: chr17, for the entire
                        chromosome. Chromosome names can checked in the
                        BAM/pileup files and are depending on the FASTA
                        reference used for alignment. Default behavior is to
                        not selecting any chromosome.
  --parallel NPROC      Defines the number of chromosomes to run in parallel.
                        The output will be divided in multiple files, one for
                        each chromosome. The file name will be composed by the
                        output argument (used as prefix) and a chromosome name
                        given by the chromosome argument list. This imply that
                        both output and chromosome argument need to be set
                        correctly.
  -S SAMTOOLS, --samtools SAMTOOLS
                        Path of samtools exec file to access the indexes and
                        compute the pileups. Default "samtools"
  -T TABIX, --tabix TABIX
                        Path of the tabix binary. Default "tabix"

Quality and Format:
  Options that change the quality threshold and format.

  -q QLIMIT, --qlimit QLIMIT
                        Minimum nucleotide quality score for inclusion in the
                        counts. Default 20.
  -f QFORMAT, --qformat QFORMAT
                        Quality format, options are "sanger" or "illumina".
                        This will add an offset of 33 or 64 respectively to
                        the qlimit value. Default "sanger".
  -N N                  Threshold to filter positions by the sum of read depth
                        of the two samples. Default 20.
```

## Binning seqz[¶](#binning-seqz "Permalink to this headline")

```
$ sequenza-utils seqz_binning
error: argument -s/--seqz is required
usage: sequenza-utils seqz_binning -s SEQZ [-w WINDOW] [-o OUT] [-T TABIX]

optional arguments:
  -s SEQZ, --seqz SEQZ  A seqz file.
  -w WINDOW, --window WINDOW
                        Window size used for binning the original seqz file.
                        Default is 50.
  -o OUT                Output file "-" for STDOUT
  -T TABIX, --tabix TABIX
                        Path of the tabix binary. Default "tabix"
```

## VCF to seqz[¶](#vcf-to-seqz "Permalink to this headline")

```
$ sequenza-utils snp2seqz
error: argument -v/--vcf is required
usage: sequenza-utils snp2seqz [-o OUTPUT] -v VCF -gc GC
                               [--vcf-depth VCF_DEPTH_TAG]
                               [--vcf-samples {n/t,t/n}]
                               [--vcf-alleles VCF_ALLELES_TAG]
                               [--preset {caveman,mutect,mpileup,strelka2_som}]
                               [--hom HOM] [--het HET] [--het_f HET_F] [-N N]
                               [-T TABIX]

Output:
  Output arguments

  -o OUTPUT, --output OUTPUT
                        Output file. For gzip compressed output name the file
                        ending in .gz. Default STDOUT

Input:
  Input files

  -v VCF, --vcf VCF     VCF input file
  -gc GC                The GC-content wiggle file

VCF:
  Parsing option for the VCF file

  --vcf-depth VCF_DEPTH_TAG
                        Column separated VCF tags in the format column for the
                        read depth for the normal and for the tumor. Default
                        "DP:DP"
  --vcf-samples {n/t,t/n}
                        Order of the normal and tumor sample in the VCF
                        column, choices are "n/t" or "t/n". Default "n/t"
  --vcf-alleles VCF_ALLELES_TAG
                        Column separated VCF tags in the format column for the
                        alleles depth for the normal and for the tumor.
                        Default "AD:AD"
  --preset {caveman,mutect,mpileup,strelka2_som}
                        Preset set of options to parse VCF from popular
                        variant callers

Genotype:
  Genotype filtering options

  --hom HOM             Threshold to select homozygous positions. Default 0.9
  --het HET             Threshold to select heterozygous positions. Default
                        0.25.
  --het_f HET_F         Threshold of frequency in the forward strand to trust
                        heterozygous calls. Default -0.2 (Disabled, effective
                        with values >= 0).

Programs:
  Option to call and control externa programs

  -T TABIX, --tabix TABIX
                        Path of the tabix binary. Default "tabix"

Filters:
  Filter output file by various parameters

  -N N                  Threshold to filter positions by the sum of read depth
                        of the two samples. Default 20.
```

## Merge overlapping seqz[¶](#merge-overlapping-seqz "Permalink to this headline")

```
$ sequenza-utils seqz_merge
error: argument -1/--seqz1 is required
usage: sequenza-utils seqz_merge [-o OUTPUT] -1 S1 -2 S2 [-T TABIX]

Output:
  Output arguments

  -o OUTPUT, --output OUTPUT
                        Output file. For gzip compressed output name the file
                        ending in .gz. Default STDOUT

Input:
  Input files

  -1 S1, --seqz1 S1     First input file. If both input files contain the same
                        line, the information in the first file will be used
  -2 S2, --seqz2 S2     Second input file

Programs:
  Option to call and control externa programs

  -T TABIX, --tabix TABIX
                        Path of the tabix binary. Default "tabix"
```

[Next](guide.html "User cookbook")
 [Previous](install.html "Installation")

---

© Copyright 2016, Francesco Favero
Revision `628964e0`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).