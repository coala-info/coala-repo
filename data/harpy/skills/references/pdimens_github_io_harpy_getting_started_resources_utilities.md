[![](../../../static/logo_trans.png)
![](../../../static/logo_trans.png)](../../../)v3.2

* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](../../../static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/harpy)
* [Submit Issue](https://github.com/pdimens/harpy/issues/new/choose)

[Powered by](https://retype.com/)

* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](../../../static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/harpy)
* [Submit Issue](https://github.com/pdimens/harpy/issues/new/choose)

[Powered by](https://retype.com/)

1. [Home](../../../)
2. Getting Started
3. Resources
4. [Utilities](../../../getting_started/resources/utilities/)

# # Utilities

Harpy is the sum of its parts and some of those parts are [stand-alone scripts](https://github.com/pdimens/harpy/tree/main/harpy/bin)
used by the workflows that are accessible from within the Harpy conda environment.
This page serves to document those scripts, since using them outside of a workflow
might be useful too. You can call up the docstring for any one of these utilities
by calling the program without any arguments.

### # assign\_mi

```
assign_mi -c cutoff input.bam > output.bam
```

Assign an `MI:i` (Molecular Identifier) tag to each barcoded
record based on a molecular distance cutoff. Input file **must be coordinate sorted**.
This is similar to deconvolve\_alignments, except it does not record the deconvolution in the `BX` tag.

* unmapped records are discarded
* records without a `BX:Z` tag or with an invalid barcode (`00` as one of its segments) are presevered but are not assigned an `MI:i` tag

### # bx\_stats

```
bx_stats input.bam > output.gz
```

Calculates various linked-read molecule metrics from the (coordinate-sorted) input alignment file.
Metrics include (per molecule):

* number of reads
* position start
* position end
* length of molecule inferred from alignments
* total aligned basepairs
* total length of inferred inserts
* molecule coverage (%) based on aligned bases
* molecule coverage (%) based on total inferred insert length

### # bx\_to\_end

```
bx_to_end input.[fq|bam] > output.[fq.gz|bam]
```

Parses the records of a FASTQ or BAM file and moves the `BX:Z` tag, if present, to
the end of the record, which makes the data play nice with LRez/LEVIATHAN. During
alignment, Harpy will automatically move the `BX:Z` tag to the end of the alignment
record, so that will **not** require manual intervention.

### # check\_bam

```
check_bam platform input.bam > output.txt
```

Parses an aligment file to check:

* if the sample name matches the `RG` tag
* whether `BX:Z` is the last tag in the record
* the counts of:
  + total alignments
  + alignments with an `MI:i` tag
  + alignments without `BX:Z` tag
  + incorrect `BX:Z` tag (specific to `platform`)

### # check\_fastq

```
check_fastq platform input.fq > output.txt
```

Parses a FASTQ file to check if any sequences don't conform to the SAM spec,
whether BX:Z: is the last tag in the record, and the counts of:

* total reads
* reads without `BX:Z` tag
* reads with incorrect `BX:Z` tag (specific to `platform`)

### # concatenate\_bam

```
concatenate_bam [--bx] file_1.bam file_2.bam...file_N.bam > output.bam
# or #
concatenate_bam [--bx] -b bam_files.txt > output.bam
```

Concatenate records from haplotagged SAM/BAM files while making sure `MI` tags remain unique for every sample.
This is a means of accomplishing the same as `samtools cat`, except all `MI` tags are updated
so individuals don't have overlapping `MI` tags (which would mess up all the linked-read data). You can either provide
all the files you want to concatenate, or a single file featuring filenames with the `-b` option. Use the `--bx` option
to also rewrite `BX` tags such that they are unique for every individual too, although take note that there can only be
96^4 (84,934,656) unique haplotag barcodes and it will raise an error if that number is exceeded.

### # count\_bx

```
count_bx input.fastq > output.txt
```

Parses a FASTQ file to count:

* total sequences
* total number of `BX` tags
* number of valid haplotagging `BX` tags
* number of invalid `BX` tags
* number of invalid `BX` tag segments (i.e. `A00`, `C00`, `B00`, `D00`).

### # deconvolve\_alignments

```
deconvolve_alignments -c cutoff input.bam > output.bam
```

Deconvolve BX-tagged barcodes and assign an `MI` (Molecular Identifier) tag to each barcoded record based on a molecular distance cutoff.
Input file **must be coordinate sorted**. This is similar to assign\_mi, except it will also deconvolve the `BX` tag by
hyphenating it with an integer (e.g. `A01C25B31D92-2`).

* unmapped records are discarded
* records without a `BX` tag or with an invalid barcode (`00` as one of its segments) are presevered but are not assigned an `MI` tag

### # depth\_windows

```
samtools depth -a file.bam | depth_windows windowsize > output.txt
```

Reads the output of `samtools depth -a` from stdin and calculates means within windows of a given `windowsize`.

### # haplotag\_acbd

```
haplotag_acbd output_directory
```

Generates the `BC_{ABCD}.txt` files necessary to demultiplex Gen I haplotag barcodes into the specified `output_directory`.

### # infer\_sv

```
infer_sv file.bedpe [-f fail.bedpe] > outfile.bedpe
```

Create column in NAIBR bedpe output inferring the SV type from the orientation. Removes variants with FAIL flags
and you can use the optional `-f` (`--fail`) argument to output FAIL variants to a separate file.

### # make\_windows

```
make_windows -w <window.size> -m <0,1> input.fasta[.fai] > output.bed
```

Create a BED file of fixed intervals (`-w`, --`window`) from a FASTA or fai file (the kind generated with `samtools faidx`).
Nearly identical to `bedtools makewindows`, except the intervals are nonoverlapping. The `-m` (`--mode`) option specified
whether indexing starts at `0` or `1`.

### # molecule\_coverage

```
molecule_coverage -f genome.fasta.fai statsfile > output.cov
```

Using the statsfile generated by `bx_stats` from Harpy, will calculate "molecular coverage" across the genome.
Molecular coverage is the "effective" alignment coverage if you treat a molecule inferred from linked-read data as
one contiguous alignment, even though the reads that make up that molecule don't cover its entire length. Requires a
FASTA fai index (the kind created with `samtools faidx`) to know the actual sizes of the contigs.

### # parse\_phaseblocks

```
parse_phaseblocks input > output.txt
```

Parse a phase block file from HapCut2 to pull out summary information

### # rename\_bam

```
rename_bam [-d] new_name input.bam
```

Rename a sam/bam file and modify the `@RG` tag of the alignment file to reflect the change for both `ID` and `SM`.
This process creates a new file `new_name.bam` and you may use `-d` to delete the original file. Requires `samtools`.

### # standardize\_barcodes\_sam

```
standardize_barcodes_sam input.bam > output.sam
```

Parse a SAM/BAM file to identify the linked-read barcode (haplotagging, stlfr, tellseq, 10x) and
move it to the `BX:Z` tag if it's not already there. After, add a `VX:i:0` if the barcode is
invalid for the given technology or `VX:i:1` if it is valid for the given technology.

* input file can be SAM or BAM, doesn't require index
  + can read from `stdin`
* `stdout`: alignments in SAM format (not BAM)
* used in `align` workflows

## See also

[Common Issues

If you use bamutils clipOverlap on alignments that are used for the or modules, they will cause both programs to error. We don't know why, but they](/harpy/getting_started/troubleshooting/common_issues/)
[Home

Using Harpy to process your linked-read data](/harpy/)
[Pooling samples for SV calling

Why pool samples for SV calling and when to do it](/harpy/getting_started/guides/sv_pooling/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Getting_Started/Resources/utilities.md)

[Previous
Software](../../../getting_started/resources/software/)

[Next
Start Here](../../../getting_started/troubleshooting/basics/)

© Copyright 2026. All rights reserved.