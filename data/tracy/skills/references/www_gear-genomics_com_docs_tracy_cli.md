[Tracy documentation](/docs/tracy/)

[Home](/docs/tracy/)

[Installation](/docs/tracy/installation/)

[Usage](/docs/tracy/cli/)

[Web Apps](/docs/tracy/webapp/)

[FAQ](/docs/tracy/faq/)

[GitHub](https://github.com/gear-genomics/tracy)

[Home](/docs/tracy/)

[Installation](/docs/tracy/installation/)

[Usage](/docs/tracy/cli/)

[Web Apps](/docs/tracy/webapp/)

[FAQ](/docs/tracy/faq/)

[GitHub](https://github.com/gear-genomics/tracy)

# [Usage](#usage)

Tracy uses subcommands for [basecalling](#basecalling-a-chromatogram-trace-file), [alignment](#trace-alignment), [deconvolution](#deconvolution-of-heterozygous-mutations), [variant calling](#variant-calling) and [trace assembly](#trace-assembly). These subcommands are explained below.

## [Basecalling a Chromatogram Trace File](#basecalling-a-chromatogram-trace-file)

[Tracy](https://github.com/gear-genomics/tracy) can basecall a trace file and output the primary sequence (highest peak) in FASTA or FASTQ format.

```
tracy basecall -f fasta -o out.fasta input.ab1
tracy basecall -f fastq -o out.fastq input.ab1
```

You can also get the full trace information, including primary and secondary basecalls for heterozygous variants in JSON format or as a tab-delimited text file.

```
tracy basecall -f tsv -o out.tsv input.ab1
tracy basecall -f json -o out.json input.ab1
```

## [Trace alignment](#trace-alignment)

Tracy supports a profile-to-sequence dynamic programming alignment of a trace file to a small reference nucleotide sequence in FASTA format.

```
tracy align -o outprefix -r reference.fa input.ab1
```

Similarly, tracy can align a trace file to a wildtype chromatogram using profile-to-profile dynamic programming.

```
tracy align -o outprefix -r wildtype.ab1 input.ab1
```

Alignment of a trace file to a large reference genome requires a pre-built index on a bgzip compressed genome. For instance, to align a trace file to the human reference genome version hg38 you first need to index the reference FASTA file.

```
tracy index -o hg38.fa.fm9 hg38.fa.gz
samtools faidx hg38.fa.gz
```

Once that index has been created you can then align a Chromatogram trace file to the indexed genome.

```
tracy align -r hg38.fa.gz input.ab1
```

Obviously, the index needs to be built only once.

## [Genome index](#genome-index)

Pre-built genome indices for commonly used reference genomes are available for download [here](https://gear-genomics.embl.de/data/tracy/).

## [Deconvolution of heterozygous mutations](#deconvolution-of-heterozygous-mutations)

Double-peaks in the chromatogram trace can cause alignment issues. Tracy supports deconvolution of heterozygous variants into two separate alleles. Each allele is then aligned separately to the reference sequence.

```
tracy decompose -r hg38.fa.gz -o outprefix input.ab1
cat outprefix.align1 outprefix.align2
```

Tracy also supports the use of a wildtype chromatogram for decomposition or a small FASTA sequence.

```
tracy decompose -r wildtype.ab1 -o outprefix mutated.ab1
tracy decompose -r sequence.fa -o outprefix mutated.ab1
```

## [Variant Calling](#variant-calling)

Tracy can call and annotate single-nucleotide variants (SNV) and insertions & deletions (InDels) with respect to a reference genome. For instance, to call variants on a Chromatogram trace file using the hg38 human reference genome.

```
tracy decompose -v -a homo_sapiens -r hg38.fa.gz -o outprefix input.ab1
```

This command also annotates rs identifiers of known polymorphisms and produces a variant call file in binary BCF format. This output file in BCF format can be converted to VCF using [bcftools](https://github.com/samtools/bcftools).

```
bcftools view outprefix.bcf
```

## [Using forward and reverse ab1 file](#using-forward-and-reverse-ab1-file)

If you do have forward and reverse trace files for the same genomic locus you can also generate a consensus.

```
tracy consensus forward.ab1 reverse.ab1
```

## [Trace assembly](#trace-assembly)

For a short genomic region that you tiled with multiple, overlapping Sanger Chromatogram trace files you can use tracy to assemble these.

```
tracy assemble -r reference.fa file1.ab1 file2.ab1 fileN.ab1
```

Instead of a reference-guided assembly using the '-r' option, tracy also supports de novo assembly of chromatogram trace files if these sufficiently overlap each other.

```
tracy assemble file1.ab1 file2.ab1 fileN.ab1
```

[Edit this page](https://github.com/gear-genomics/tracy/edit/main/cli/README.md)

Last Updated: 9/25/25, 12:17 PM

Contributors: Markus Hsi-Yang Fritz, tobiasrausch, Tobias Rausch