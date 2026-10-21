# rtg-tools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rtg-tools_rtg_bgzip | PASS | compress then decompress of a real VCF gives the identical file |
| rtg-tools_rtg_format | PASS | real chr21 FASTA (nf-core) became an SDF with 46,709,983 residues, as in the FASTA |
| rtg-tools_rtg_index | PASS | tabix index of the block-gzipped VCF was written and used by vcfeval --region |
| rtg-tools_rtg_mendelian | PASS | real trio VCF with PED: 96 violations in 3250 checked records (own check of fully called records: 86); template is N-only contigs with the VCF contig names, since no GRCh37 SDF is small |
| rtg-tools_rtg_sdfstats | PASS | reports 1 sequence, 46,709,983 residues and 39 N blocks for the formatted chr21 |
| rtg-tools_rtg_vcfeval | PASS | real GATK calls vs their GQ>=50 SNP subset: 403 TP, 0 FP, 330 FN as expected; --region chr21:6M-20M gives 10 TP |
| rtg-tools_rtg_vcffilter | PASS | snps-only plus GQ>=50 kept 403 of 733 real calls; independent count matches (397 single-ALT SNPs plus 6 multi-allelic SNP sites) |
| rtg-tools_rtg_vcfmerge | PASS | merged two real single-sample GATK VCFs (74 + 733) into a 2-sample VCF with 807 records |
| rtg-tools_rtg_vcfstats | PASS | real GATK calls: 733 records, 729 SNPs, 3 insertions, 1 deletion, as counted from the VCF |
| rtg-tools_rtg_vcfsubset | PASS | removed INFO and QUAL and kept only GT for all 733 real records |

## rtg-tools_rtg_format

### Tool Description
Converts the contents of sequence data files (FASTA/FASTQ/SAM/BAM) into the RTG Sequence Data File (SDF) format.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg format [OPTION]... -o SDF FILE+
                  [OPTION]... -o SDF -I FILE
                  [OPTION]... -o SDF -l FILE -r FILE

Converts the contents of sequence data files (FASTA/FASTQ/SAM/BAM) into the RTG
Sequence Data File (SDF) format.

File Input/Output
  -f, --format=FORMAT            format of input. Allowed values are [fasta,
                                 fastq, fastq-interleaved, sam-se, sam-pe]
                                 (Default is fasta)
  -I, --input-list-file=FILE     file containing a list of input read files (1
                                 per line)
  -l, --left=FILE                left input file for FASTA/FASTQ paired end
                                 data
  -o, --output=SDF               name of output SDF
  -p, --protein                  input is protein. If this option is not
                                 specified, then the input is assumed to
                                 consist of nucleotides
  -q, --quality-format=FORMAT    quality data encoding method used in FASTQ
                                 input files (Illumina 1.8+ uses sanger).
                                 Allowed values are [sanger, solexa, illumina]
                                 (Default is sanger)
  -r, --right=FILE               right input file for FASTA/FASTQ paired end
                                 data
      FILE+                      input sequence files. May be specified 0 or
                                 more times

Filtering
      --duster                   treat lower case residues as unknowns
      --exclude=STRING           exclude input sequences based on their name.
                                 If the input sequence contains the specified
                                 string then that sequence is excluded from the
                                 SDF. May be specified 0 or more times
      --select-read-group=STRING when formatting from SAM/BAM input, only
                                 include reads with this read group ID
      --trim-threshold=INT       trim read ends to maximise base quality above
                                 the given threshold

Utility
      --allow-duplicate-names    disable checking for duplicate sequence names
  -h, --help                     print help on command-line flag usage
      --no-names                 do not include name data in the SDF output
      --no-quality               do not include quality data in the SDF output
      --sam-rg=STRING|FILE       file containing a single valid read group SAM
                                 header line or a string in the form
                                 "@RG\tID:READGROUP1\tSM:BACT_SAMPLE\tPL:ILLUMINA"
```

## rtg-tools_rtg_sdfstats

### Tool Description
Print statistics that describe a directory of SDF formatted data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg sdfstats [OPTION]... SDF+

Print statistics that describe a directory of SDF formatted data.

File Input/Output
      SDF+       SDF directories. Must be specified 1 or more times

Reporting
      --lengths  print out the name and length of each sequence. (Not
                 recommended for read sets)
  -p, --position only display info about unknown bases (Ns) by read position
  -q, --quality  display mean of quality
      --sex=SEX  display reference sequence list for the given sex, if defined.
                 Allowed values are [male, female, either]. May be specified 0
                 or more times, or as a comma separated list
      --taxonomy display information about taxonomy
  -n, --unknowns display info about unknown bases (Ns)

Utility
  -h, --help     print help on command-line flag usage
```

## rtg-tools_rtg_vcfeval

### Tool Description
Evaluates called variants for genotype agreement with a baseline variant set irrespective of representational differences.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcfeval [OPTION]... -b FILE -c FILE -o DIR -t SDF

Evaluates called variants for genotype agreement with a baseline variant set
irrespective of representational differences. Outputs a weighted ROC file which
can be viewed with rtg rocplot and VCF files containing false positives (called
variants not matched in the baseline), false negatives (baseline variants not
matched in the call set), and true positives (variants that match between the
baseline and calls).

File Input/Output
  -b, --baseline=FILE           VCF file containing baseline variants
      --bed-regions=FILE        if set, only read VCF records that overlap the
                                ranges contained in the specified BED file
  -c, --calls=FILE              VCF file containing called variants
  -e, --evaluation-regions=FILE if set, evaluate within regions contained in
                                the supplied BED file, allowing transborder
                                matches. To be used for truth-set
                                high-confidence regions or other regions of
                                interest where region boundary effects should
                                be minimized
  -o, --output=DIR              directory for output
      --region=REGION           if set, only read VCF records within the
                                specified range. The format is one of
                                <sequence_name>, <sequence_name>:<start>-<end>,
                                <sequence_name>:<pos>+<length> or
                                <sequence_name>:<pos>~<padding>
  -t, --template=SDF            SDF of the reference genome the variants are
                                called against

Filtering
      --all-records             use all records regardless of filter status
                                (Default is to only process variants passing
                                filters)
      --decompose               decompose complex variants into smaller
                                constituents to allow partial credit
      --ref-overlap             allow alleles to overlap where bases of either
                                allele are same-as-ref (Default is to only
                                allow VCF anchor base overlap)
      --sample=STRING           the name of the sample to select. Use
                                <baseline_sample>,<calls_sample> to select
                                different sample names for baseline and calls.
                                (Required when using multi-sample VCF files)
      --sample-ploidy=INT       expected ploidy of samples (Default is 2)
      --squash-ploidy           treat heterozygous genotypes as homozygous ALT
                                in both baseline and calls, to allow matches
                                that ignore zygosity differences

Reporting
      --at-precision=FLOAT      output summary statistics where precision >=
                                supplied value (Default is to summarize at
                                maximum F-measure)
      --at-score=FLOAT          output summary statistics where score meets
                                supplied value (Default is to summarize at
                                maximum F-measure)
      --at-sensitivity=FLOAT    output summary statistics where sensitivity >=
                                supplied value (Default is to summarize at
                                maximum F-measure)
      --no-roc                  do not produce ROCs
  -m, --output-mode=STRING      output reporting mode. Allowed values are
                                [split, annotate, combine, ga4gh, roc-only]
                                (Default is split)
      --roc-cross-join          output ROC files for each intersection of
                                --roc-subset, --roc-expr, and --roc-regions
                                values provided
      --roc-expr=STRING         output ROC file for variants matching custom
                                JavaScript expression. Use the form
                                <LABEL>=<EXPRESSION>. May be specified 0 or
                                more times
      --roc-regions=STRING      output ROC file for variants overlapping custom
                                regions supplied in BED file. Use the form
                                <LABEL>=<FILENAME>. May be specified 0 or more
                                times
      --roc-subset=STRING       output ROC file for preset variant subset.
                                Allowed values are [hom, het, snp, non-snp,
                                mnp, indel]. May be specified 0 or more times,
                                or as a comma separated list
  -O, --sort-order=STRING       the order in which to sort the ROC scores so
                                that "good" scores come before "bad" scores.
                                Allowed values are [ascending, descending]
                                (Default is descending)
  -f, --vcf-score-field=STRING  the name of the VCF FORMAT field to use as the
                                ROC score. Also valid are "QUAL", "INFO.<name>"
                                or "FORMAT.<name>" to select the named VCF
                                FORMAT or INFO field, or use
                                "EXPR.<LABEL>=<EXPRESSION>" to define a
                                JavaScript expression that dynamically computes
                                a score (Default is GQ)

Utility
  -h, --help                    print help on command-line flag usage
  -Z, --no-gzip                 do not gzip the output
  -T, --threads=INT             number of threads (Default is the number of
                                available cores)
```

## rtg-tools_rtg_vcfstats

### Tool Description
Display statistics from a set of VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcfstats [OPTION]... FILE+

Display statistics from a set of VCF files.

File Input/Output
      --known          only calculate statistics for known variants (Default is
                       to ignore known/novel status)
      --novel          only calculate statistics for novel variants (Default is
                       to ignore known/novel status)
      --sample=STRING  only calculate statistics for the specified sample
                       (Default is to include all samples). May be specified 0
                       or more times
      FILE+            input VCF files from which to derive statistics or '-'
                       to read from standard input. Must be specified 1 or more
                       times

Reporting
      --allele-lengths output variant length histogram

Utility
  -h, --help           print help on command-line flag usage
```

## rtg-tools_rtg_vcffilter

### Tool Description
Filters VCF records based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcffilter [OPTION]... -i FILE -o FILE
                     [OPTION]... -i FILE -j STRING

Filters VCF records based on various criteria. When filtering on multiple
samples, if any of the specified samples fail the criteria, the record will be
filtered. By default filtered records are removed, but see the --fail,
--clear-failed-samples, and --fail-samples options for alternatives.

File Input/Output
      --all-samples                 apply sample-specific criteria to all
                                    samples contained in the input VCF
      --bed-regions=FILE            if set, only read VCF records that overlap
                                    the ranges contained in the specified BED
                                    file
  -i, --input=FILE                  VCF file containing variants to be
                                    filtered. Use '-' to read from standard
                                    input
  -o, --output=FILE                 output VCF file. Use '-' to write to
                                    standard output. This option is required,
                                    unless "--javascript" is being used
      --region=REGION               if set, only read VCF records within the
                                    specified range. The format is one of
                                    <sequence_name>,
                                    <sequence_name>:<start>-<end>,
                                    <sequence_name>:<pos>+<length> or
                                    <sequence_name>:<pos>~<padding>
      --sample=STRING               apply sample-specific criteria to the named
                                    sample contained in the input VCF. May be
                                    specified 0 or more times

Filtering (Record based)
  -w, --density-window=INT          window within which multiple variants are
                                    discarded
      --exclude-bed=FILE            discard all variants within the regions in
                                    this BED file
      --exclude-vcf=FILE            discard all variants that overlap with the
                                    ones in this file
      --include-bed=FILE            only keep variants within the regions in
                                    this BED file
      --include-vcf=FILE            only keep variants that overlap with the
                                    ones in this file
  -j, --javascript=STRING           javascript filtering functions for
                                    determining whether to keep record. May be
                                    either an expression or a file name. May be
                                    specified 0 or more times
  -e, --keep-expr=STRING            records for which this expression evaluates
                                    to true will be retained
  -k, --keep-filter=STRING          only keep variants with this FILTER tag.
                                    May be specified 0 or more times, or as a
                                    comma separated list
  -K, --keep-info=STRING            only keep variants with this INFO tag. May
                                    be specified 0 or more times, or as a comma
                                    separated list
      --max-alleles=INT             maximum number of alleles (REF included)
  -C, --max-combined-read-depth=INT maximum allowed combined read depth
  -Q, --max-quality=FLOAT           maximum allowed quality
      --min-alleles=INT             minimum number of alleles (REF included)
  -c, --min-combined-read-depth=INT minimum allowed combined read depth
  -q, --min-quality=FLOAT           minimum allowed quality
  -r, --remove-filter=STRING        remove variants with this FILTER tag. May
                                    be specified 0 or more times, or as a comma
                                    separated list
  -R, --remove-info=STRING          remove variants with this INFO tag. May be
                                    specified 0 or more times, or as a comma
                                    separated list
      --remove-overlapping          remove records that overlap with previous
                                    records

Filtering (Sample based)
  -A, --max-ambiguity-ratio=FLOAT   maximum allowed ambiguity ratio
      --max-avr-score=FLOAT         maximum allowed AVR score
      --max-denovo-score=FLOAT      maximum de novo score threshold
  -G, --max-genotype-quality=FLOAT  maximum allowed genotype quality
  -D, --max-read-depth=INT          maximum allowed sample read depth
      --min-avr-score=FLOAT         minimum allowed AVR score
      --min-denovo-score=FLOAT      minimum de novo score threshold
  -g, --min-genotype-quality=FLOAT  minimum allowed genotype quality
  -d, --min-read-depth=INT          minimum allowed sample read depth
      --non-snps-only               only keep where sample variant is MNP or
                                    INDEL
      --remove-all-same-as-ref      remove where all samples are same as
                                    reference
      --remove-hom                  remove where sample is homozygous
      --remove-same-as-ref          remove where sample is same as reference
      --snps-only                   only keep where sample variant is a simple
                                    SNP

Reporting
      --clear-failed-samples        retain failed records, set the sample GT
                                    field to missing
  -f, --fail=STRING                 retain failed records, add the provided
                                    label to the FILTER field
  -F, --fail-samples=STRING         retain failed records, add the provided
                                    label to the sample FT field

Utility
  -a, --add-header=STRING|FILE      file containing VCF header lines to add, or
                                    a literal header line. May be specified 0
                                    or more times
  -h, --help                        print help on command-line flag usage
  -Z, --no-gzip                     do not gzip the output
      --no-header                   prevent VCF header from being written
```

## rtg-tools_rtg_vcfsubset

### Tool Description
Removes columnar data from VCF records.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcfsubset [OPTION]... -i FILE -o FILE

Removes columnar data from VCF records.

File Input/Output
      --bed-regions=FILE          if set, only read VCF records that overlap
                                  the ranges contained in the specified BED
                                  file
  -i, --input=FILE                VCF file containing variants to manipulate.
                                  Use '-' to read from standard input
  -o, --output=FILE               output VCF file. Use '-' to write to standard
                                  output
      --region=REGION             if set, only read VCF records within the
                                  specified range. The format is one of
                                  <sequence_name>,
                                  <sequence_name>:<start>-<end>,
                                  <sequence_name>:<pos>+<length> or
                                  <sequence_name>:<pos>~<padding>

Filtering
      --keep-filter=STRING        keep the specified FILTER tag. May be
                                  specified 0 or more times, or as a comma
                                  separated list
      --keep-format=STRING        keep the specified FORMAT field. May be
                                  specified 0 or more times, or as a comma
                                  separated list
      --keep-info=STRING          keep the specified INFO tag. May be specified
                                  0 or more times, or as a comma separated list
      --keep-sample=STRING|FILE   file containing sample IDs to keep, or a
                                  literal sample name. May be specified 0 or
                                  more times, or as a comma separated list
      --remove-filter=STRING      remove the specified FILTER tag. May be
                                  specified 0 or more times, or as a comma
                                  separated list
      --remove-filters            remove all FILTER tags
      --remove-format=STRING      remove the specified FORMAT field. May be
                                  specified 0 or more times, or as a comma
                                  separated list
      --remove-ids                remove the contents of the ID field
      --remove-info=STRING        remove the specified INFO tag. May be
                                  specified 0 or more times, or as a comma
                                  separated list
      --remove-infos              remove all INFO tags
      --remove-qual               remove the QUAL field
      --remove-sample=STRING|FILE file containing sample IDs to remove, or a
                                  literal sample name. May be specified 0 or
                                  more times, or as a comma separated list
      --remove-samples            remove all samples

Utility
  -h, --help                      print help on command-line flag usage
  -Z, --no-gzip                   do not gzip the output
      --no-header                 prevent VCF header from being written
```

## rtg-tools_rtg_vcfmerge

### Tool Description
Merge a one or more input VCF files to a single output VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcfmerge [OPTION]... -o FILE FILE+
                    [OPTION]... -o FILE -I FILE

Merge a one or more input VCF files to a single output VCF. Use cases include
combining single sample calls into a multi-sample VCF, or to combine calls on
separate chromosomes into a single VCF.

File Input/Output
      --bed-regions=FILE       if set, only read VCF records that overlap the
                               ranges contained in the specified BED file
  -I, --input-list-file=FILE   file containing a list of VCF format files (1
                               per line) to be merged
  -o, --output=FILE            output VCF file. Use '-' to write to standard
                               output
      --region=REGION          if set, only read VCF records within the
                               specified range. The format is one of
                               <sequence_name>, <sequence_name>:<start>-<end>,
                               <sequence_name>:<pos>+<length> or
                               <sequence_name>:<pos>~<padding>
      FILE+                    input VCF files to merge. May be specified 0 or
                               more times

Utility
  -a, --add-header=STRING|FILE file containing VCF header lines to add, or a
                               literal header line. May be specified 0 or more
                               times
  -f, --force-merge=STRING     allow merging of specified header ID even when
                               descriptions do not match. May be specified 0 or
                               more times, or as a comma separated list
  -F, --force-merge-all        attempt merging of all non-matching header
                               declarations
  -h, --help                   print help on command-line flag usage
  -Z, --no-gzip                do not gzip the output
      --no-header              prevent VCF header from being written
      --no-merge-alts          do not merge multiple records if the ALTs are
                               different
      --no-merge-records       do not merge multiple records at the same
                               position into one
      --preserve-formats       do not merge multiple records containing
                               unmergeable FORMAT fields (Default is to remove
                               those FORMAT fields so the variants can be
                               combined)
      --stats                  output statistics for the merged VCF file
```

## rtg-tools_rtg_mendelian

### Tool Description
Check a multi-sample VCF for Mendelian consistency.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg mendelian [OPTION]... -i FILE -t SDF

Check a multi-sample VCF for Mendelian consistency.

File Input/Output
  -i, --input=FILE               VCF file containing multi-sample variant
                                 calls. Use '-' to read from standard input
  -o, --output=FILE              if set, output annotated calls to this VCF
                                 file. Use '-' to write to standard output
      --output-consistent=FILE   if set, output only consistent calls to this
                                 VCF file
      --output-inconsistent=FILE if set, output only non-Mendelian calls to
                                 this VCF file
  -t, --template=SDF             SDF containing the reference genome

Sensitivity Tuning
      --all-records              use all records, regardless of filters
                                 (Default is to only process records where
                                 FILTER is "." or "PASS")
  -l, --lenient                  allow homozygous diploid calls in place of
                                 haploid calls and assume missing values are
                                 equal to the reference
      --min-concordance=FLOAT    percentage concordance required for consistent
                                 parentage (Default is 99.0)
      --pedigree=FILE            genome relationships PED file (Default is to
                                 extract pedigree information from VCF header
                                 fields)

Utility
  -h, --help                     print help on command-line flag usage
  -Z, --no-gzip                  do not gzip the output
```

## rtg-tools_rtg_bgzip

### Tool Description
Compress a file with block gzip.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg bgzip [OPTION]... FILE+

Compress a file with block gzip.

File Input/Output
  -l, --compression-level=INT the compression level to use, between 1 (least
                              but fast) and 9 (highest but slow) (Default is 5)
  -d, --decompress            decompress
  -f, --force                 force overwrite of existing output file
      --no-terminate          if set, do not add the block gzip termination
                              block
  -c, --stdout                write on standard output, keep original files
                              unchanged. Implied when using standard input
      FILE+                   file to (de)compress, use '-' for standard input.
                              Must be specified 1 or more times

Utility
  -h, --help                  print help on command-line flag usage
```

## rtg-tools_rtg_index

### Tool Description
Creates index files for block compressed TAB-delimited genome position files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg index [OPTION]... FILE+
                 [OPTION]... -I FILE

Creates index files for block compressed TAB-delimited genome position files.

File Input/Output
  -f, --format=FORMAT        format of input to index. Allowed values are [sam,
                             bam, cram, sv, coveragetsv, bed, vcf, gvcf, auto]
                             (Default is auto)
  -I, --input-list-file=FILE file containing a list of block compressed files
                             (1 per line) containing genome position data
      FILE+                  block compressed files containing data to be
                             indexed. May be specified 0 or more times

Utility
  -h, --help                 print help on command-line flag usage
```

