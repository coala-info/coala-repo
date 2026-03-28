[whatshap](index.html)

* [Installation](installation.html)
* User guide
  + [Features and limitations](#features-and-limitations)
  + [Subcommands](#subcommands)
  + [Recommended workflow](#recommended-workflow)
  + [Input data requirements](#input-data-requirements)
    - [What to do when the metadata is not correct](#what-to-do-when-the-metadata-is-not-correct)
    - [Using multiple input BAM/CRAM files](#multiple-bam-files)
    - [Using a phased VCF instead of a BAM/CRAM file](#vcfs-as-reads)
    - [Read selection and merging](#selection-and-merging)
  + [Representation of phasing information in VCFs](#phasing-in-vcfs)
    - [Phasing represented by pipe (`|`) notation](#phasing-represented-by-pipe-notation)
    - [Phasing represented by PS (“phase set”) tag](#phase-sets)
    - [Phasing represented by HP tag](#phasing-represented-by-hp-tag)
  + [Trusting the variant caller](#trusting-the-variant-caller)
  + [Phasing pedigrees](#phasing-pedigrees)
    - [PED file format](#ped-file-format)
    - [Pedigree phasing parameters](#pedigree-phasing-parameters)
  + [Creating phased references in FASTA format](#creating-phased-references-in-fasta-format)
  + [whatshap stats: Computing phasing statistics](#whatshap-stats)
    - [The TSV statistics format](#the-tsv-statistics-format)
    - [Writing haplotype blocks in TSV format](#writing-haplotype-blocks-in-tsv-format)
    - [Writing haplotype blocks in GTF format](#writing-haplotype-blocks-in-gtf-format)
  + [Visualizing phasing results](#visualizing-phasing-results)
    - [GTF with haplotype blocks](#gtf-with-haplotype-blocks)
  + [whatshap haplotag: Tagging reads by haplotype](#whatshap-haplotag)
    - [How haplotagging works](#whatshap-haplotag-algorithm)
    - [Haplotagging reads with supplementary alignments](#haplotagging-reads-with-supplementary-alignments)
  + [whatshap split: Splitting reads according to haplotype](#whatshap-split)
  + [whatshap genotype: Genotyping Variants](#whatshap-genotype)
  + [whatshap polyphase: Polyploid Phasing](#whatshap-polyphase)
  + [whatshap polyphaseg: Polyploid Phasing with progeny information](#whatshap-polyphaseg)
  + [whatshap compare: Comparing variant files](#whatshap-compare)
  + [whatshap learn: Generate sequencing technology specific error profiles](#whatshap-learn)
  + [*k*-merald](#k-merald)
  + [whatshap haplotagphase: Phase VCF file using haplotagged BAM file](#whatshap-haplotagphase)
* [Questions and Answers](faq.html)
* [Contributing](develop.html)
* [Various notes](notes.html)
* [How to cite](howtocite.html)
* [Changes](changes.html)

[whatshap](index.html)

* User guide
* [View page source](_sources/guide.rst.txt)

---

# User guide[](#user-guide "Link to this heading")

Note

If you are just starting to use WhatsHap, we recommend that you read
our book chapter [Read-Based Phasing and Analysis of Phased Variants
with WhatsHap](https://doi.org/10.1007/978-1-0716-2819-5_8), which
is a more recent and concise introduction than this guide.

WhatsHap is a read-based phasing tool. In the typical case, it expects
1) a VCF file with variants of an individual and 2) a BAM or CRAM file with
sequencing reads from that same individual. WhatsHap uses the sequencing reads
to reconstruct the haplotypes and then writes out the input VCF augmented with
phasing information.

The basic command-line for running WhatsHap is this:

```
whatshap phase -o phased.vcf --reference=reference.fasta input.vcf input.bam
```

The reads used for variant calling (to create the input VCF) do not
need to be the same as the ones that are used for phasing. We
recommend that high-quality short reads are used for variant calling and
that the phasing is then done with long reads, see [the recommended
workflow](#recommended-workflow).

If the input VCF is a multi-sample VCF, WhatsHap will haplotype all
samples individually. For this, the input must contain reads from all
samples.

[Multiple BAM/CRAM files can be provided](#multiple-bam-files),
even from different technologies.

If you want to phase samples of individuals that are related, you can use
[pedigree phasing](#phasing-pedigrees) mode to improve results.
In this mode, WhatsHap is no longer purely a read-based phasing tool.

You can also phase indels by adding the option `--indels`.

Providing a FASTA reference with `--reference` is highly recommended, in
particular for error-prone reads (PacBio, Nanopore), as it is enables the
re-alignment variant detection algorithm. If a reference is not available,
`--no-reference` can instead be provided, but at the expense of phasing
quality.

WhatsHap adds the phasing information to the input VCF file and writes it to
the output VCF file. [See below to understand how phasing information
is represented](#phasing-in-vcfs).

The VCF file can also be gzip-compressed.

## Features and limitations[](#features-and-limitations "Link to this heading")

WhatsHap can phase SNVs (single-nucleotide variants), insertions,
deletions, MNPs (multiple adjacent SNVs) and “complex” variants. Complex
variants are those that do not fall in any of the other categories, but
are not structural variants. An example is the variant TGCA → AAC.
Structural variants are not phased.

If no reference sequence is provided (using `--reference`), only
SNVs, insertions and deletions can be phased.

All variants in the input VCF that are marked as being heterozygous
(genotype 0/1) and that have appropriate coverage are used as input for the core
phasing algorithm. If the algorithm could determine how the variant should be
phased, that information will be added to the variant in the output VCF.

Variants can be left unphased for two reasons: Either the variant type is
not supported or the phasing algorithm could not make a phasing decision.
In both cases, the information from the input VCF is simply copied to the output
VCF unchanged.

## Subcommands[](#subcommands "Link to this heading")

WhatsHap comes with the following subcommands.

| Subcommand | Description |
| --- | --- |
| phase | Phase diploid variants |
| [polyphase](#whatshap-polyphase) | Phase polyploid variants |
| [polyphasegenetic](#whatshap-polyphaseg) | Phase polyploid variants |
| [stats](#whatshap-stats) | Print phasing statistics |
| [compare](#whatshap-compare) | Compare two or more phasings |
| hapcut2vcf | Convert hapCUT output format to VCF |
| unphase | Remove phasing information from a VCF file |
| [haplotag](#whatshap-haplotag) | Tag reads by haplotype |
| [genotype](#whatshap-genotype) | Genotype variants |
| [split](#whatshap-split) | Split reads by haplotype |
| [learn](#whatshap-learn) | Generate sequencing technology specific error profiles |
| [haplotagphase](#whatshap-haplotagphase) | Phase VCF file using haplotagged BAM file |

Not all are fully documented in this manual, yet. To get help for a
subcommand named `SUBCOMMAND`, run

```
whatshap SUBCOMMAND --help
```

## Recommended workflow[](#recommended-workflow "Link to this heading")

Best phasing results are obtained if you sequence your sample(s) on both PacBio
and Illumina: Illumina for high-quality variant calls and PacBio for its long
reads.

1. Map your reads to the reference, making sure that you assign each read to a
read group (the `@RG` header line in the BAM/CRAM file). WhatsHap supports VCF
files with multiple samples and in order to determine which reads belong to which
sample, it uses the ‘sample name’ (SM) of the read group. If you have a single
sample only and no or incorrect read group headers, you can run WhatsHap with
`--ignore-read-groups` instead.

2. Call variants in your sample(s) using the most accurate reads you have. These
will typically be Illumina reads, resulting in a a set of variant calls you can
be reasonably confident in. If you do not know which variant caller to use, yet,
we recommend FreeBayes, which is fast, Open Source and easy to use. In any case,
you will need a standard VCF file as input for WhatsHap in the next step.

3. Run WhatsHap with the VCF file of high-confidence variant calls (obtained in
the previous step) and with the *longest* reads you have. These will typically
be PacBio reads. Phasing works best with long reads, but WhatsHap can use any
read that covers at least two heterozygous variant calls, so even paired-end or
mate-pair reads are somewhat helpful. If you have multiple sets of reads, you
can combine them by providing multiple BAM/CRAM files on the command line.

## Input data requirements[](#input-data-requirements "Link to this heading")

WhatsHap needs correct metadata in the VCF and the BAM/CRAM input files so that
it can figure out which read belongs to which sample. As an example, assume you
give WhatsHap a VCF file that starts like this:

```
##fileformat=VCFv4.1
#CHROM  POS  ID  REF  ALT  QUAL   FILTER  INFO FORMAT  SampleA  SampleB
chr1    100  .   A    T    50.0   .       .    GT      0/1      0/1
...
```

WhatsHap sees that there are two samples in it named “SampleA” and “SampleB”
and expects to find the reads for these samples somewhere in the BAM/CRAM file
(or files) that you provide. For that to happen, all reads belonging to a sample
must have the `RG` tag, and at the same time, the read group must occur in the
header of the BAM/CRAM file and have the correct sample name. In this example, a
header might look like this:

```
@HD     VN:1.4  SO:coordinate
@SQ     SN:...  LN:...
...
@RG   ID:1  SM:SampleA
@RG   ID:2  SM:SampleB
```

The `@RG` header line will often contain more fields, such as `PL` for
the platform and `LB` for the library name. WhatsHap only uses the `SM`
attribute.

With the above header, the individual alignments in the file will be tagged with
a read group of `1` or `2`. For example, an alignment in the BAM/CRAM file
that comes from SampleA would be tagged with `RG:Z:1`. This is also described
in the [SAM/BAM specification](https://samtools.github.io/hts-specs/).

It is perfectly fine to have multiple read groups for a single sample:

```
@RG   ID:1a  SM:SampleA
@RG   ID:1b  SM:SampleA
@RG   ID:2   SM:SampleB
```

### What to do when the metadata is not correct[](#what-to-do-when-the-metadata-is-not-correct "Link to this heading")

If WhatsHap complains that it cannot find the reads for a sample, then chances
are that the metadata in the BAM/CRAM and/or VCF file are incorrect. You have the
following options:

* Edit the sample names in the VCF header.
* Set the correct read group info in the BAM/CRAM file, for example with the Picard
  tool AddOrReplaceReadGroups.
* Re-map the reads and pass the correct metadata-setting options to your mapping
  tool.
* Use the `--ignore-read-groups` option of WhatsHap. In this case, WhatsHap
  ignores all read group metadata in the BAM/CRAM input file(s) and assumes that all
  reads come from the sample that you want to phase. In this mode, you can
  only phase a single sample at a time. If the input VCF file contains more than
  one sample, you need to specify which one to phase by using
  `--sample=The_Sample_Name`.

### Using multiple input BAM/CRAM files[](#multiple-bam-files "Link to this heading")

WhatsHap supports reading from multiple BAM or CRAM files. Just provide all BAM
and CRAM files you want to use on the command-line. All the reads across all
those files that to a specific sample are used to phase that sample. This can be
used to combine reads from multiple technologies. For example, if you have
Nanopore reads in one BAM file and PacBio reads in another CRAM file, you can
run the phasing like this:

```
whatshap phase -o phased.vcf --reference=reference.fasta input.vcf nanopore.bam pacbio.cram
```

You need to make sure that read group information
[is accurate in all files](#input-data-requirements).

### Using a phased VCF instead of a BAM/CRAM file[](#vcfs-as-reads "Link to this heading")

It is possible to provide a phased VCF file instead of a BAM/CRAM file. WhatsHap
will then treat the haplotype blocks ([phase sets](#phase-sets)) it
describes as “reads”. For example, if the phased VCF contains only
chromosome-sized haplotypes, then each chromosome would give rise to two such
“reads”. These reads are then used as any other read in the phasing algorithm,
that is, they are combined with the normal sequencing reads and the best
solution taking all reads into account is computed.

### Read selection and merging[](#selection-and-merging "Link to this heading")

Whatshap has multiple ways to reduce the coverage of the input —
allowing faster runtimes — in a way that attempts to minimize the
amount of information lost in this process. The default behaviour is
to ensure a maximum coverage via read selection: a heuristic that
extracts a subset of the reads that is most informative for phasing.
An optional step which can be done before selection is to merge
subsets of reads together to form superreads according to a
probabilistic model of how likely subsets of reads are to appear
together on the same haplotype (p\_s) or different haplotypes (p\_d).
By default, this feature is not activated, however it can be activated
by specifying the `--merge-reads` flag when running `whatshap
phase`. This model is parameterized by the following four parameters

| Parameter | Description |
| --- | --- |
| error-rate | Probability that a nucleotide is wrong |
| maximum-error-rate | Maximum error any edge of the merging graph can have |
| threshold | Threshold ratio of p\_s/p\_d to merge two sets |
| negative-threshold | Threshold ratio of p\_d/p\_s to not merge two sets |

which can be specified by the respective flags `--error-rate=0.15`,
`--maximum-error-rate=0.25`, `--threshold=100000` and
`--negative-threshold=1000` (note that defaults are shown here for
example) when running `whatshap phase`.

## Representation of phasing information in VCFs[](#phasing-in-vcfs "Link to this heading")

WhatsHap supports two ways in which it can store phasing information in a VCF
file: The standards-compliant `PS` tag and the `HP` tag used by GATK’s
ReadBackedPhasing tool. When you run `whatshap phase`, you can select which
format is used by setting `--tag=PS` or `--tag=HP`.

We will use a small VCF file as an example in the following. Unphased, it
looks like this:

```
##fileformat=VCFv4.1
#CHROM  POS  ID  REF  ALT  QUAL   FILTER  INFO FORMAT  sample1  sample2
chr1    100  .   A    T    50.0   .       .    GT      0/1      0/1
chr1    150  .   C    G    50.0   .       .    GT      0/1      1/1
chr1    300  .   G    T    50.0   .       .    GT      0/1      0/1
chr1    350  .   T    A    50.0   .       .    GT      0/1      0/1
chr1    500  .   A    G    50.0   .       .    GT      0/1      1/1
```

Note that sample 1 is heterozygous at all shown loci (expressed with
`0/1` in the `GT` field).

### Phasing represented by pipe (`|`) notation[](#phasing-represented-by-pipe-notation "Link to this heading")

The `GT` fields can be phased by ordering the alleles by haplotype and
separating them with a pipe symbol (`|`) instead of a slash (`/`):

