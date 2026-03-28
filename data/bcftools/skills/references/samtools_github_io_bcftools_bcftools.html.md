# bcftools(1) Manual Page

## NAME

bcftools - utilities for variant calling and manipulating VCFs and BCFs.

## SYNOPSIS

**bcftools** [--version|--version-only] [--help] [*COMMAND*] [*OPTIONS*]

## DESCRIPTION

BCFtools is a set of utilities that manipulate variant calls in the Variant
Call Format (VCF) and its binary counterpart BCF. All commands work
transparently with both VCFs and BCFs, both uncompressed and BGZF-compressed.

Most commands accept VCF, bgzipped VCF and BCF with filetype detected
automatically even when streaming from a pipe. Indexed VCF and BCF
will work in all situations. Un-indexed VCF and BCF and streams will
work in most, but not all situations. In general, whenever multiple VCFs are
read simultaneously, they must be indexed and therefore also compressed.
(Note that files with non-standard index names can be accessed as e.g.
"`bcftools view -r X:2928329 file.vcf.gz##idx##non-standard-index-name`".)

BCFtools is designed to work on a stream. It regards an input file "-" as the
standard input (stdin) and outputs to the standard output (stdout). Several
commands can thus be combined with Unix pipes.

### VERSION

This manual page was last updated **2025-06-17 12:11 BST** and refers to bcftools git version **1.22-8-g2d811c52+**.

### BCF1

The obsolete BCF1 format output by versions of samtools <= 0.1.19 is **not**
compatible with this version of bcftools. To read BCF1 files one can use
the view command from old versions of bcftools packaged with samtools
versions <= 0.1.19 to convert to VCF, which can then be read by
this version of bcftools.

```
    samtools-0.1.19/bcftools/bcftools view file.bcf1 | bcftools view
```

### VARIANT CALLING

See *bcftools call* for variant calling from the output of the
*samtools mpileup* command. In versions of samtools <= 0.1.19 calling was
done with *bcftools view*. Users are now required to choose between the old
samtools calling model (*-c/--consensus-caller*) and the new multiallelic
calling model (*-m/--multiallelic-caller*). The multiallelic calling model
is recommended for most tasks.

### FILTERING EXPRESSIONS

See **[EXPRESSIONS](#expressions)**

## LIST OF COMMANDS

For a full list of available commands, run **bcftools** without arguments. For a full
list of available options, run **bcftools** *COMMAND* without arguments.

* **[annotate](#annotate)** .. edit VCF files, add or remove annotations
* **[call](#call)** .. SNP/indel calling (former "view")
* **[cnv](#cnv)** .. Copy Number Variation caller
* **[concat](#concat)** .. concatenate VCF/BCF files from the same set of samples
* **[consensus](#consensus)** .. create consensus sequence by applying VCF variants
* **[convert](#convert)** .. convert VCF/BCF to other formats and back
* **[csq](#csq)** .. haplotype aware consequence caller
* **[filter](#filter)** .. filter VCF/BCF files using fixed thresholds
* **[gtcheck](#gtcheck)** .. check sample concordance, detect sample swaps and contamination
* **[head](#head)** .. view VCF/BCF file headers
* **[index](#index)** .. index VCF/BCF
* **[isec](#isec)** .. intersections of VCF/BCF files
* **[merge](#merge)** .. merge VCF/BCF files files from non-overlapping sample sets
* **[mpileup](#mpileup)** .. multi-way pileup producing genotype likelihoods
* **[norm](#norm)** .. normalize indels
* **[plugin](#plugin)** .. run user-defined plugin
* **[polysomy](#polysomy)** .. detect contaminations and whole-chromosome aberrations
* **[query](#query)** .. transform VCF/BCF into user-defined formats
* **[reheader](#reheader)** .. modify VCF/BCF header, change sample names
* **[roh](#roh)** .. identify runs of homo/auto-zygosity
* **[sort](#sort)** .. sort VCF/BCF files
* **[stats](#stats)** .. produce VCF/BCF stats (former vcfcheck)
* **[view](#view)** .. subset, filter and convert VCF and BCF files

## LIST OF SCRIPTS

Some helper scripts are bundled with the bcftools code.

* **[gff2gff](#gff2gff)** .. converts a GFF file to the format required by **[bcftools csq](#csq)**
* **[plot-vcfstats](#plot-vcfstats)** .. plots the output of **[bcftools stats](#stats)**
* **[roh-viz](#roh-viz)** .. creates HTML/JavaScript visualization of **[bcftools roh](#roh)**

## COMMANDS AND OPTIONS

### Common Options

The following options are common to many bcftools commands. See usage for
specific commands to see if they apply.

*FILE*
:   Files can be both VCF or BCF, uncompressed or BGZF-compressed. The file "-"
    is interpreted as standard input. Some tools may require tabix- or
    CSI-indexed files.

**-c, --collapse** *snps*|*indels*|*both*|*all*|*some*|*none*|*id*
:   Controls how to treat records with duplicate positions and defines compatible
    records across multiple input files. Here by "compatible" we mean records which
    should be considered as identical by the tools. For example, when performing
    line intersections, the desire may be to consider as identical all sites with
    matching positions (**bcftools isec -c** *all*), or only sites with matching variant
    type (**bcftools isec -c** *snps*  **-c** *indels*), or only sites with all alleles
    identical (**bcftools isec -c** *none*).

    *none*
    :   only records with identical REF and ALT alleles are compatible

    *some*
    :   only records where some subset of ALT alleles match are compatible

    *all*
    :   all records are compatible, regardless of whether the ALT alleles
        match or not. In the case of records with the same position, only
        the first will be considered and appear on output.

    *snps*
    :   any SNP records are compatible, regardless of whether the ALT
        alleles match or not. For duplicate positions, only the first SNP
        record will be considered and appear on output.

    *indels*
    :   all indel records are compatible, regardless of whether the REF
        and ALT alleles match or not. For duplicate positions, only the
        first indel record will be considered and appear on output.

    *both*
    :   abbreviation of "**-c** *indels*  **-c** *snps*"

    *id*
    :   only records with identical ID column are compatible.

**-f, --apply-filters** *LIST*
:   Skip sites where FILTER column does not contain any of the strings listed
    in *LIST*. For example, to include only sites which have no filters set,
    use **-f** *.,PASS*.

**--no-version**
:   Do not append version and command line information to the output VCF header.

**-o, --output** *FILE*
:   When output consists of a single stream, write it to *FILE* rather than
    to standard output, where it is written by default.
    The file type is determined automatically from the file name suffix and in
    case a conflicting **-O** option is given, the file name suffix takes precedence.

**-O, --output-type** *b*|*u*|*z*|*v*[0-9]
:   Output compressed BCF (*b*), uncompressed BCF (*u*), compressed VCF (*z*), uncompressed VCF (*v*).
    Use the -Ou option when piping between bcftools subcommands to speed up
    performance by removing unnecessary compression/decompression and
    VCF←→BCF conversion.

    The compression level of the compressed formats (*b* and *z*) can be set by
    by appending a number between 0-9.

**-r, --regions** *chr*|*chr:pos*|*chr:beg-end*|*chr:beg-*[,…​]
:   Comma-separated list of regions, see also **-R, --regions-file**. Overlapping
    records are matched even when the starting coordinate is outside of the
    region, unlike the **-t/-T** options where only the POS coordinate is checked.
    Note that **-r** cannot be used in combination with **-R**.

**-R, --regions-file** *FILE*
:   Regions can be specified either on command line or in a VCF, BED, or
    tab-delimited file (the default). The columns of the tab-delimited file
    can contain either positions (two-column format: CHROM, POS) or intervals
    (three-column format: CHROM, BEG, END), but not both. Positions are 1-based
    and inclusive. The columns of the tab-delimited BED file are also
    CHROM, POS and END (trailing columns are ignored), but coordinates
    are 0-based, half-open. To indicate that a file be treated as BED rather
    than the 1-based tab-delimited file, the file must have the ".bed" or
    ".bed.gz" suffix (case-insensitive). Uncompressed files are stored in
    memory, while bgzip-compressed and tabix-indexed region files are streamed.
    Note that sequence names must match exactly, "chr20" is not the same as
    "20". Also note that chromosome ordering in *FILE* will be respected,
    the VCF will be processed in the order in which chromosomes first appear
    in *FILE*. However, within chromosomes, the VCF will always be
    processed in ascending genomic coordinate order no matter what order they
    appear in *FILE*. Note that overlapping regions in *FILE* can result in
    duplicated out of order positions in the output.
    This option requires indexed VCF/BCF files. Note that **-R** cannot be used
    in combination with **-r**.

**--regions-overlap** *pos*|*record*|*variant*|*0*|*1*|*2*
:   This option controls how overlapping records are determined:
    set to **pos** or **0** if the VCF record has to have POS inside a region
    (this corresponds to the default behavior of **-t/-T**);
    set to **record** or **1** if also overlapping records with POS outside a region
    should be included (this is the default behavior of **-r/-R**, and includes indels
    with POS at the end of a region, which are technically outside the region); or set
    to **variant** or **2** to include only true overlapping variation (compare
    the full VCF representation "`TA>T-`" vs the true sequence variation "`A>-`").

**-s, --samples** [^]*LIST*
:   Comma-separated list of samples to include or exclude if prefixed
    with "^." (Note that when multiple samples are to be excluded,
    the "^" prefix is still present only once, e.g. "^SAMPLE1,SAMPLE2".)
    The sample order is updated to reflect that given on the command line.
    Note that in general tags such as INFO/AC, INFO/AN, etc are not updated
    to correspond to the subset samples. **[bcftools view](#view)** is the
    exception where some tags will be updated (unless the **-I, --no-update**
    option is used; see **[bcftools view](#view)** documentation). To use updated
    tags for the subset in another command one can pipe from **view** into
    that command. For example:

```
    bcftools view -Ou -s sample1,sample2 file.vcf | bcftools query -f %INFO/AC\t%INFO/AN\n
```

**-S, --samples-file** [^]*FILE*
:   File of sample names to include or exclude if prefixed with "^".
    One sample per line. See also the note above for the **-s, --samples**
    option.
    The sample order is updated to reflect that given in the input file.
    The command **[bcftools call](#call)** accepts an optional second
    column indicating ploidy (0, 1 or 2) or sex (as defined by
    **[--ploidy](#ploidy)**, for example "F" or "M"), for example:

```
    sample1    1
    sample2    2
    sample3    2
```

or

```
    sample1    M
    sample2    F
    sample3    F
```

If the second column is not present, the sex "F" is assumed.
With **[bcftools call](#call) -C** *trio*, PED file is expected.
The program ignores the first column and the last indicates sex (1=male, 2=female), for example:

```
    ignored_column  daughterA fatherA  motherA  2
    ignored_column  sonB      fatherB  motherB  1
```

**-t, --targets** [^]*chr*|*chr:pos*|*chr:from-to*|*chr:from-*[,…​]
:   Similar as **-r, --regions**, but the next position is accessed by streaming the
    whole VCF/BCF rather than using the tbi/csi index. Both **-r** and **-t** options
    can be applied simultaneously: **-r** uses the index to jump to a region
    and **-t** discards positions which are not in the targets. Unlike **-r**, targets
    can be prefixed with "^" to request logical complement. For example, "^X,Y,MT"
    indicates that sequences X, Y and MT should be skipped.
    Yet another difference between the **-t/-T** and **-r/-R** is that **-r/-R** checks for
    proper overlaps and considers both POS and the end position of an indel, while **-t/-T**
    considers the POS coordinate only (by default; see also **--regions-overlap** and **--targets-overlap**).
    Note that **-t** cannot be used in combination with **-T**.

**-T, --targets-file** [^]*FILE*
:   Same **-t, --targets**, but reads regions from a file. Note that **-T**
    cannot be used in combination with **-t**.

    With the **call -C** *alleles* command, third column of the targets file must
    be comma-separated list of alleles, starting with the reference allele.
    Note that the file must be compressed and indexed.
    Such a file can be easily created from a VCF using:

```
    bcftools query -f'%CHROM\t%POS\t%REF,%ALT\n' file.vcf | bgzip -c > als.tsv.gz && tabix -s1 -b2 -e2 als.tsv.gz
```

**--targets-overlap** *pos*|*record*|*variant*|*0*|*1*|*2*
:   Same as **--regions-overlap** but for **-t/-T**.

**--threads** *INT*
:   Use multithreading with *INT* worker threads. The option is currently used only for the compression of the
    output stream, only when *--output-type* is *b* or *z*. Default: 0.

**-v, --verbosity** *INT*
:   Verbosity level. Values bigger than 3 are passed to the underlying HTSlib library so that network issues
    and other problems occurring at the library level can be investigated.

**-W**[*FMT*]**, -W**[=*FMT*]**, --write-index**[=*FMT*]
:   Automatically index the output files. *FMT* is optional and can be
    one of "tbi" or "csi" depending on output file format. Defaults to
    CSI unless specified otherwise. Can be used only for compressed
    BCF and VCF output.

### bcftools annotate *[OPTIONS]* *FILE*

Add or remove annotations.

**-a, --annotations** *file*
:   Bgzip-compressed and tabix-indexed file with annotations. The file
    can be VCF, BED, or a tab-delimited file with mandatory columns CHROM, POS
    (or, alternatively, FROM and TO), optional columns REF and ALT, and arbitrary
    number of annotation columns. BED files are expected to have
    the ".bed" or ".bed.gz" suffix (case-insensitive), otherwise a tab-delimited file is assumed.
    Note that in case of tab-delimited file, the coordinates POS, FROM and TO are
    one-based and inclusive. When REF and ALT are present, only matching VCF
    records will be annotated. If the END coordinate is present in the annotation file
    and given on command line as "`-c ~INFO/END`", then VCF records will be matched also by the INFO/END coordinate.
    If ID is present in the annotation file and given as "`-c ~ID`", then VCF records will be matched
    also by the ID column.

    When multiple ALT alleles are present in the annotation file (given as
    comma-separated list of alleles), at least one must match one of the
    alleles in the corresponding VCF record. Similarly, at least one
    alternate allele from a multi-allelic VCF record must be present in the
    annotation file.

    Missing values can be added 