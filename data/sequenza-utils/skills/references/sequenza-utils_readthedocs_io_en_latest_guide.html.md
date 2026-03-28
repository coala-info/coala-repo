[sequenza-utils](index.html)

latest

* [Installation](install.html)
* [Command line interface](commands.html)
* User cookbook
  + [Generate GC reference file](#generate-gc-reference-file)
  + [From BAM files](#from-bam-files)
    - [Normal and tumor BAM files](#normal-and-tumor-bam-files)
    - [Normal and tumor pileup files](#normal-and-tumor-pileup-files)
    - [Without normal, workaround](#without-normal-workaround)
  + [Binning seqz, reduce memory](#binning-seqz-reduce-memory)
  + [Seqz from VCF files](#seqz-from-vcf-files)
    - [VCF files with **DP** and **AD** tags](#vcf-files-with-dp-and-ad-tags)
    - [Mutect/Caveman/Strelka2 preset](#mutect-caveman-strelka2-preset)
  + [Merge seqz files](#merge-seqz-files)
    - [Non overlapping calls (eg different chromosomes)](#non-overlapping-calls-eg-different-chromosomes)
    - [Overlapping sample\_calls](#overlapping-sample-calls)

* [API library interface](api.html)

[sequenza-utils](index.html)

* [Docs](index.html) »
* User cookbook
* [Edit on Bitbucket](https://bitbucket.org/sequenzatools/sequenza-utils/src/master/docs/guide.rst?mode=view)

---

# User cookbook[¶](#user-cookbook "Permalink to this headline")

In order to process BAM files and generate file index, the software [samtools](http://samtools.sourceforge.net) and [tabix](http://www.htslib.org/doc/tabix.html)
need to be installed in the system.

The package *sequenza-utils* includes several programs and it should support the generation
of *seqz* files using commonly available input files, such as fasta, BAM and vcf files.

To write your own program using the *sequenza-utils* library, lease refer to the
[API library interface](api.html)

## Generate GC reference file[¶](#generate-gc-reference-file "Permalink to this headline")

The GC content source required to generate *seqz* files must to be in the [wiggle track](https://genome.ucsc.edu/goldenpath/help/wiggle.html)
format (WIG). In order to generate the wig file from any fasta file use the `gc_wiggle`
program.

```
sequenza-utils gc_wiggle --fasta genome.fa.gz -w 50 -o genome_gc50.wig.gz
```

## From BAM files[¶](#from-bam-files "Permalink to this headline")

### Normal and tumor BAM files[¶](#normal-and-tumor-bam-files "Permalink to this headline")

```
sequenza-utils bam2seqz --normal normal_sample.bam --tumor tumor_sample.bam \
    --fasta genome.fa.gz -gc genome_gc50.wig.gz --output sample.seqz.gz
```

### Normal and tumor pileup files[¶](#normal-and-tumor-pileup-files "Permalink to this headline")

```
sequenza-utils bam2seqz --normal normal_sample.pielup.gz \
    --tumor tumor_sample.pielup.gz --fasta genome.fa.gz \
    -gc genome_gc50.wig.gz --output sample.seqz.gz --pileup
```

### Without normal, workaround[¶](#without-normal-workaround "Permalink to this headline")

```
sequenza-utils bam2seqz --normal tumor_sample.bam --tumor tumor_sample.bam \
    --normal2 non_matching_normal_sample.bam --fasta genome.fa.gz \
    -gc genome_gc50.wig.gz --output sample.seqz.gz
```

## Binning seqz, reduce memory[¶](#binning-seqz-reduce-memory "Permalink to this headline")

```
sequenza-utils seqz_binning --seqz sample.seqz.gz --window 50 \
    -o sample_bin50.seqz.gz
```

## Seqz from VCF files[¶](#seqz-from-vcf-files "Permalink to this headline")

### VCF files with **DP** and **AD** tags[¶](#vcf-files-with-dp-and-ad-tags "Permalink to this headline")

```
sequenza-utils snp2seqz --vcf sample_calls.vcf.gz -gc genome_gc50.wig.gz \
    --output samples.seqz.gz
```

### Mutect/Caveman/Strelka2 preset[¶](#mutect-caveman-strelka2-preset "Permalink to this headline")

```
sequenza-utils snp2seqz --vcf sample_calls.vcf.gz -gc genome_gc50.wig.gz \
    --preset mutect --output samples.seqz.gz
```

```
sequenza-utils snp2seqz --vcf sample_calls.vcf.gz -gc genome_gc50.wig.gz \
    --preset caveman --output samples.seqz.gz
```

```
sequenza-utils snp2seqz --vcf sample_calls.vcf.gz -gc genome_gc50.wig.gz \
    --preset strelka2_som --output samples.seqz.gz
```

## Merge seqz files[¶](#merge-seqz-files "Permalink to this headline")

### Non overlapping calls (eg different chromosomes)[¶](#non-overlapping-calls-eg-different-chromosomes "Permalink to this headline")

```
gzcat sample_chr1.seqz.gz sample_chr1.seqz.gz | \
    gawk '{if (NR!=1 && $1 != "chromosome") {print $0}}' | bgzip > \
    sample.seqz.gz
tabix -f -s 1 -b 2 -e 2 -S 1 sample.seqz.gz
```

### Overlapping sample\_calls[¶](#overlapping-sample-calls "Permalink to this headline")

```
sequenza-utils seqz_merge --seqz1 sample_somatic.seqz.gz \
    --seqz2 sample_snps.seqz.gz --output samples.seqz.gz
```

[Next](api.html "API library interface")
 [Previous](commands.html "Command line interface")

---

© Copyright 2016, Francesco Favero
Revision `628964e0`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).