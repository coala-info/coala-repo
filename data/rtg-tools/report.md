# rtg-tools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rtg-tools_rtg_bgzip | PASS | compress then decompress of a real VCF gives the identical file |
| rtg-tools_rtg_bndeval | PASS | real simulated SV VCF decomposed to 334 breakends: compared with itself gives 334 TP, 0 FP, 0 FN; note: EXPR. score expressions crash with a null JavaScript processor |
| rtg-tools_rtg_cgsim | PASS | synthetic data by design: 100 simulated CG v1 read pairs of 35 bp, read by sdf2sam |
| rtg-tools_rtg_childsim | PASS | synthetic data by design: child from simulated parents, 849 records with 0 Mendelian violations; child SDF written |
| rtg-tools_rtg_cnveval | PASS | real cnvkit CNV calls: against themselves 344 TP, 0 FP, 0 FN; deletions-only calls vs all gives precision 0.885 and sensitivity 0.404, consistent with the counts; region BED was derived from the VCF intervals |
| rtg-tools_rtg_denovosim | PASS | synthetic data by design: derived sample has 18 new sites over 849 (20 requested); derived SDF written |
| rtg-tools_rtg_extract | PASS | real GATK calls on chr21 (indexed): region chr21:6M-12M returned the 2 records an independent count finds, plus the header |
| rtg-tools_rtg_fastqtrim | PASS | 100 real SARS-CoV-2 reads: trim 5 from start and 10 from end gave every read 15 bases shorter with matching sequence |
| rtg-tools_rtg_format | PASS | real chr21 FASTA (nf-core) became an SDF with 46,709,983 residues, as in the FASTA |
| rtg-tools_rtg_genomesim | PASS | synthetic data by design: 2 contigs of 637 and 763 bp (within 500-800); --length 300 --length 400 and --freq also checked |
| rtg-tools_rtg_index | PASS | tabix index of the block-gzipped VCF was written and used by vcfeval --region |
| rtg-tools_rtg_mendelian | PASS | real trio VCF with PED: 96 violations in 3250 checked records (own check of fully called records: 86); template is N-only contigs with the VCF contig names, since no GRCh37 SDF is small |
| rtg-tools_rtg_pedfilter | PASS | real PED (3 members) was converted to a VCF header with 3 samples and the child-parent line |
| rtg-tools_rtg_pedsamplesim | PASS | synthetic data by design: trio PED gave a 3-sample VCF of 876 records, summary and per-sample SDFs |
| rtg-tools_rtg_pedstats | PASS | real PED: --families lists father, mother and one child as in the file |
| rtg-tools_rtg_popsim | PASS | synthetic data by design: 849 population variants on the chr22 slice, bgzip VCF plus tabix index, used by samplesim |
| rtg-tools_rtg_readsim | PASS | synthetic data by design from real chr22 slice: 100 illumina_pe pairs, left 50 bp and right 60 bp, read by sdf2fastq |
| rtg-tools_rtg_rocplot | PASS | ROC files from a real vcfeval run gave a valid PNG and SVG plot (checked the PNG: title, baseline total 404, two curves) |
| rtg-tools_rtg_samplereplay | PASS | synthetic data by design: replayed SDF is identical in sequence to the samplesim --output-sdf of the same sample |
| rtg-tools_rtg_samplesim | PASS | synthetic data by design: father/mother genotypes from popsim VCF (849 records); --output-sdf gave a 2-haplotype SDF of 80027 residues |
| rtg-tools_rtg_sdf2fasta | PASS | chain: readsim reads (100 pairs) gave 2 gz FASTA files; simulated 2-contig genome gave contigs of 637 and 763 bp; --names selected simctg1 only |
| rtg-tools_rtg_sdf2fastq | PASS | readsim paired SDF gave left/right FASTQ with 100 reads each, lengths 50 and 60, as requested |
| rtg-tools_rtg_sdf2sam | PASS | cgsim SDF (100 simulated 35 bp pairs) gave a BAM with 200 records of length 35 |
| rtg-tools_rtg_sdfstats | PASS | reports 1 sequence, 46,709,983 residues and 39 N blocks for the formatted chr21 |
| rtg-tools_rtg_sdfsubseq | PASS | chr21:6456942+10 from the real chr21 SDF gives GTTGCGGTAC, the same as the FASTA |
| rtg-tools_rtg_sdfsubset | PASS | ids 10-14 of an SDF of 100 real sarscov2 reads gave an SDF with those 5 reads (names match the FASTQ lines 11-15) |
| rtg-tools_rtg_svdecompose | PASS | real simulated chr21 SV VCF (136 records): 61 inversions became breakend pairs, DUPs kept, 334 BND records written |
| rtg-tools_rtg_vcf2rocplot | PASS | real vcfeval annotated calls and baseline VCFs: SNP ROC has 403 baseline and 729 call variants, and 184 TP at score 99 as in vcfeval |
| rtg-tools_rtg_vcfannotate | PASS | real GATK calls: all 733 records kept, AN/AC filled and a computed QD annotation added (header declares it) |
| rtg-tools_rtg_vcfdecompose | PASS | real dbSNP chr22 slice with its 40 kb chr22 SDF: 7 complex records decomposed, 2174 to 2186 records, CAG>CTC became two SNPs |
| rtg-tools_rtg_vcfeval | PASS | real GATK calls vs their GQ>=50 SNP subset: 403 TP, 0 FP, 330 FN as expected; --region chr21:6M-20M gives 10 TP |
| rtg-tools_rtg_vcffilter | PASS | snps-only plus GQ>=50 kept 403 of 733 real calls; independent count matches (397 single-ALT SNPs plus 6 multi-allelic SNP sites) |
| rtg-tools_rtg_vcfmerge | PASS | merged two real single-sample GATK VCFs (74 + 733) into a 2-sample VCF with 807 records |
| rtg-tools_rtg_vcfsplit | PASS | real trio VCF split into 3 per-sample files; the first sample has 2364 non-reference records, as in an independent count of the input |
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

## rtg-tools_rtg_extract

### Tool Description
Extract records from an indexed genomic position data file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg extract [OPTION]... FILE REGION+
                   [OPTION]... FILE

Extract records from an indexed genomic position data file.

File Input/Output
      FILE          the indexed block compressed genome position data file to
                    extract

Filtering
      REGION+       the range to display. The format is one of <sequence_name>,
                    <sequence_name>:<start>-<end>,
                    <sequence_name>:<pos>+<length> or
                    <sequence_name>:<pos>~<padding>. May be specified 0 or more
                    times

Reporting
      --header      print out header also
      --header-only print out header only

Utility
  -h, --help        print help on command-line flag usage
```

## rtg-tools_rtg_sdfsubset

### Tool Description
Extracts a subset of sequences from one SDF and outputs them to another SDF.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg sdfsubset [OPTION]... -i SDF -o SDF STRING+
                     [OPTION]... -i SDF -o SDF -I FILE
                     [OPTION]... -i SDF -o SDF --end-id INT --start-id INT

Extracts a subset of sequences from one SDF and outputs them to another SDF.

File Input/Output
  -i, --input=SDF    SDF containing sequences
  -o, --output=SDF   output SDF

Filtering
      --end-id=INT   exclusive upper bound on sequence id
  -I, --id-file=FILE file containing sequence ids, or sequence names if --names
                     flag is set, one per line
  -n, --names        interpret supplied sequence as names instead of numeric
                     ids
      --start-id=INT inclusive lower bound on sequence id
      STRING+        id of sequence to extract, or sequence name if --names
                     flag is set. May be specified 0 or more times

Utility
  -h, --help         print help on command-line flag usage
```

## rtg-tools_rtg_sdfsubseq

### Tool Description
Prints a subsequence of a given sequence in an SDF.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg sdfsubseq [OPTION]... -i SDF REGION+

Prints a subsequence of a given sequence in an SDF.

File Input/Output
  -i, --input=SDF          input SDF

Filtering
  -I, --sequence-id        if set, use sequence id instead of sequence name in
                           region (0-based)
      REGION+              the range to display. The format is one of
                           <sequence_name>, <sequence_name>:<start>-<end>,
                           <sequence_name>:<pos>+<length> or
                           <sequence_name>:<pos>~<padding>. Must be specified 1
                           or more times

Utility
  -f, --fasta              if set, output in FASTA format
  -q, --fastq              if set, output in FASTQ format
  -h, --help               print help on command-line flag usage
  -r, --reverse-complement if set, output in reverse complement
```

## rtg-tools_rtg_vcfannotate

### Tool Description
Adds annotations to a VCF file, either to the VCF ID field, or as a VCF INFO sub-field.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcfannotate [OPTION]... -i FILE -o FILE

Adds annotations to a VCF file, either to the VCF ID field, or as a VCF INFO
sub-field.

File Input/Output
      --bed-regions=FILE        if set, only read VCF records that overlap the
                                ranges contained in the specified BED file
  -i, --input=FILE              VCF file containing variants to annotate. Use
                                '-' to read from standard input
  -o, --output=FILE             output VCF file name. Use '-' to write to
                                standard output
      --region=REGION           if set, only read VCF records within the
                                specified range. The format is one of
                                <sequence_name>, <sequence_name>:<start>-<end>,
                                <sequence_name>:<pos>+<length> or
                                <sequence_name>:<pos>~<padding>

Reporting
  -A, --annotation=STRING       add computed annotation to VCF records. Allowed
                                values are [AC, AN, EP, GQD, IC, LAL, MEANQAD,
                                NAA, PD, QA, QD, RA, SCONT, VAF, VAF1, ZY]. May
                                be specified 0 or more times, or as a comma
                                separated list
      --bed-ids=FILE            add variant IDs from BED file. May be specified
                                0 or more times
      --bed-info=FILE           add INFO annotations from BED file. May be
                                specified 0 or more times
      --fill-an-ac              add or update the AN and AC INFO fields
      --info-description=STRING if the BED INFO field is not already declared,
                                use this description in the header (Default is
                                Annotation)
      --info-id=STRING          the INFO ID for BED INFO annotations (Default
                                is ANN)
      --relabel=FILE            relabel samples according to "old-name
                                new-name" pairs in specified file
      --vcf-ids=FILE            add variant IDs from VCF file. May be specified
                                0 or more times

Utility
  -a, --add-header=STRING|FILE  file containing VCF header lines to add, or a
                                literal header line. May be specified 0 or more
                                times
  -h, --help                    print help on command-line flag usage
  -Z, --no-gzip                 do not gzip the output
      --no-header               prevent VCF header from being written
```

## rtg-tools_rtg_vcfsplit

### Tool Description
Splits samples contained within a VCF into separate files, one per sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcfsplit [OPTION]... -i FILE -o DIR

Splits samples contained within a VCF into separate files, one per sample.

File Input/Output
      --bed-regions=FILE          if set, only read VCF records that overlap
                                  the ranges contained in the specified BED
                                  file
  -i, --input=FILE                the input VCF, or '-' to read from standard
                                  input
  -o, --output=DIR                directory for output
      --region=REGION             if set, only read VCF records within the
                                  specified range. The format is one of
                                  <sequence_name>,
                                  <sequence_name>:<start>-<end>,
                                  <sequence_name>:<pos>+<length> or
                                  <sequence_name>:<pos>~<padding>

Filtering
      --keep-ref                  keep records where the sample is reference
      --keep-sample=STRING|FILE   file containing sample IDs to select, or a
                                  literal sample name. May be specified 0 or
                                  more times, or as a comma separated list
      --remove-sample=STRING|FILE file containing sample IDs to ignore, or a
                                  literal sample name. May be specified 0 or
                                  more times, or as a comma separated list

Utility
  -h, --help                      print help on command-line flag usage
  -Z, --no-gzip                   do not gzip the output
```

## rtg-tools_rtg_vcfdecompose

### Tool Description
Decomposes complex variants within a VCF file into smaller components.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcfdecompose [OPTION]... -i FILE -o FILE

Decomposes complex variants within a VCF file into smaller components.

File Input/Output
  -i, --input=FILE   VCF file containing variants to decompose. Use '-' to read
                     from standard input
  -o, --output=FILE  output VCF file name. Use '-' to write to standard output
  -t, --template=SDF SDF of the reference genome the variants are called
                     against

Sensitivity Tuning
      --break-indels if set, peel as many SNPs off an indel as possible
      --break-mnps   if set, break MNPs into individual SNPs

Utility
  -h, --help         print help on command-line flag usage
  -Z, --no-gzip      do not gzip the output
      --no-header    prevent VCF header from being written
```

## rtg-tools_rtg_vcf2rocplot

### Tool Description
Produce rocplot compatible ROC data files from vcfeval annotated VCFs.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg vcf2rocplot [OPTION]... -o DIR FILE+

Produce rocplot compatible ROC data files from vcfeval annotated VCFs.

File Input/Output
      --bed-regions=FILE       if set, only read VCF records that overlap the
                               ranges contained in the specified BED file
  -o, --output=DIR             directory for output
      --region=REGION          if set, only read VCF records within the
                               specified range. The format is one of
                               <sequence_name>, <sequence_name>:<start>-<end>,
                               <sequence_name>:<pos>+<length> or
                               <sequence_name>:<pos>~<padding>
      FILE+                    input VCF files containing vcfeval annotations.
                               Must be specified 1 or more times

Reporting
      --at-precision=FLOAT     output summary statistics where precision >=
                               supplied value (Default is to summarize at
                               maximum F-measure)
      --at-score=FLOAT         output summary statistics where score meets
                               supplied value (Default is to summarize at
                               maximum F-measure)
      --at-sensitivity=FLOAT   output summary statistics where sensitivity >=
                               supplied value (Default is to summarize at
                               maximum F-measure)
      --roc-cross-join         output ROC files for each intersection of
                               --roc-subset, --roc-expr, and --roc-regions
                               values provided
      --roc-expr=STRING        output ROC file for variants matching custom
                               JavaScript expression. Use the form
                               <LABEL>=<EXPRESSION>. May be specified 0 or more
                               times
      --roc-regions=STRING     output ROC file for variants overlapping custom
                               regions supplied in BED file. Use the form
                               <LABEL>=<FILENAME>. May be specified 0 or more
                               times
      --roc-subset=STRING      output ROC file for preset variant subset.
                               Allowed values are [hom, het, snp, non-snp, mnp,
                               indel, dup, del]. May be specified 0 or more
                               times, or as a comma separated list
  -O, --sort-order=STRING      the order in which to sort the ROC scores so
                               that "good" scores come before "bad" scores.
                               Allowed values are [ascending, descending]
                               (Default is descending)
  -f, --vcf-score-field=STRING the name of the VCF FORMAT field to use as the
                               ROC score. Also valid are "QUAL", "INFO.<name>"
                               or "FORMAT.<name>" to select the named VCF
                               FORMAT or INFO field, or use
                               "EXPR.<LABEL>=<EXPRESSION>" to define a
                               JavaScript expression that dynamically computes
                               a score (Default is QUAL)

Utility
  -h, --help                   print help on command-line flag usage
  -Z, --no-gzip                do not gzip the output
  -T, --threads=INT            number of threads (Default is the number of
                               available cores)
```

## rtg-tools_rtg_svdecompose

### Tool Description
Split composite structural variants into a breakend representation.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg svdecompose [OPTION]... -i FILE -o FILE

Split composite structural variants into a breakend representation.

File Input/Output
  -i, --input=FILE           VCF file containing variants to filter. Use '-' to
                             read from standard input
  -o, --output=FILE          output VCF file name. Use '-' to write to standard
                             output

Utility
  -h, --help                 print help on command-line flag usage
      --min-indel-length=INT minimum length for converting precise insertions
                             and deletions to breakend (Default is 20)
  -Z, --no-gzip              do not gzip the output
      --no-header            prevent VCF header from being written
```

## rtg-tools_rtg_bndeval

### Tool Description
Evaluate called breakends for agreement with a baseline breakend set.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg bndeval [OPTION]... -b FILE -c FILE -o DIR

Evaluate called breakends for agreement with a baseline breakend set. Outputs a
weighted ROC file which can be viewed with rtg rocplot and VCF files containing
false positives (called breakends not matched in the baseline), false negatives
(baseline breakends not matched in the call set), and true positives (breakends
that match between the baseline and calls).

File Input/Output
  -b, --baseline=FILE          VCF file containing baseline variants
      --bed-regions=FILE       if set, only read VCF records that overlap the
                               ranges contained in the specified BED file
  -c, --calls=FILE             VCF file containing called variants
  -o, --output=DIR             directory for output
      --region=REGION          if set, only read VCF records within the
                               specified range. The format is one of
                               <sequence_name>, <sequence_name>:<start>-<end>,
                               <sequence_name>:<pos>+<length> or
                               <sequence_name>:<pos>~<padding>

Filtering
      --all-records            use all records regardless of FILTER status
                               (Default is to only process records where FILTER
                               is "." or "PASS")
      --bidirectional          if set, allow matches between flipped breakends
      --tolerance=INT          positional tolerance for breakend matching
                               (Default is 100)

Reporting
      --at-precision=FLOAT     output summary statistics where precision >=
                               supplied value (Default is to summarize at
                               maximum F-measure)
      --at-score=FLOAT         output summary statistics where score meets
                               supplied value (Default is to summarize at
                               maximum F-measure)
      --at-sensitivity=FLOAT   output summary statistics where sensitivity >=
                               supplied value (Default is to summarize at
                               maximum F-measure)
      --no-roc                 do not produce ROCs
  -m, --output-mode=STRING     output reporting mode. Allowed values are
                               [split, annotate] (Default is split)
      --roc-cross-join         output ROC files for each intersection of
                               --roc-subset, --roc-expr, and --roc-regions
                               values provided
      --roc-expr=STRING        output ROC file for variants matching custom
                               JavaScript expression. Use the form
                               <LABEL>=<EXPRESSION>. May be specified 0 or more
                               times
      --roc-regions=STRING     output ROC file for variants overlapping custom
                               regions supplied in BED file. Use the form
                               <LABEL>=<FILENAME>. May be specified 0 or more
                               times
  -O, --sort-order=STRING      the order in which to sort the ROC scores so
                               that "good" scores come before "bad" scores.
                               Allowed values are [ascending, descending]
                               (Default is descending)
  -f, --vcf-score-field=STRING the name of the VCF FORMAT field to use as the
                               ROC score. Also valid are "QUAL", "INFO.<name>"
                               or "FORMAT.<name>" to select the named VCF
                               FORMAT or INFO field, or use
                               "EXPR.<LABEL>=<EXPRESSION>" to define a
                               JavaScript expression that dynamically computes
                               a score (Default is INFO.DP)

Utility
  -h, --help                   print help on command-line flag usage
  -Z, --no-gzip                do not gzip the output
```

## rtg-tools_rtg_cnveval

### Tool Description
Evaluate called CNV regions for agreement with a baseline CNV set.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg cnveval [OPTION]... -b FILE -c FILE -e FILE -o DIR

Evaluate called CNV regions for agreement with a baseline CNV set.

File Input/Output
  -b, --baseline=FILE           VCF file containing baseline variants
  -c, --calls=FILE              VCF file containing called variants
  -e, --evaluation-regions=FILE evaluate with respect to the supplied regions
                                of interest BED file
  -o, --output=DIR              directory for output

Filtering
      --all-records             use all records regardless of FILTER status
                                (Default is to only process records where
                                FILTER is "." or "PASS")

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
      --names                   include evaluation region names in annotated
                                outputs
      --no-roc                  do not produce ROCs
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
                                Allowed values are [dup, del]. May be specified
                                0 or more times, or as a comma separated list
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
                                a score (Default is QUAL)

Utility
  -h, --help                    print help on command-line flag usage
  -Z, --no-gzip                 do not gzip the output
  -T, --threads=INT             number of threads (Default is the number of
                                available cores)
```

## rtg-tools_rtg_pedfilter

### Tool Description
Filter and convert a pedigree file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg pedfilter [OPTION]... FILE

Filter and convert a pedigree file.

File Input/Output
      FILE                 the pedigree file to process, may be PED or VCF, use
                           '-' to read from stdin

Filtering
      --keep-family=STRING keep only individuals with the specified family ID.
                           May be specified 0 or more times, or as a comma
                           separated list
      --keep-ids=STRING    keep only individuals with the specified ID. May be
                           specified 0 or more times, or as a comma separated
                           list
      --keep-primary       keep only primary individuals (those with a PED
                           individual line / VCF sample column)
      --remove-parentage   remove all parent-child relationship information

Reporting
      --vcf                output pedigree in the form of a VCF header

Utility
  -h, --help               print help on command-line flag usage
```

## rtg-tools_rtg_pedstats

### Tool Description
Output information from pedigree files of various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg pedstats [OPTION]... FILE

Output information from pedigree files of various formats. For quick pedigree
visualization using Graphviz, try:

  dot -Tpng <(rtg pedstats --dot "A Title" PEDFILE) | display -

or for a larger pedigree:

  dot -Tpdf -o mypedigree.pdf <(rtg pedstats --dot "A Title" PEDFILE)

File Input/Output
      FILE               the pedigree file to process, may be PED or VCF, use
                         '-' to read from stdin

Reporting
  -d, --delimiter=STRING output id lists using this separator (Default is \n)
      --dot=STRING       output pedigree in Graphviz format, using the supplied
                         text as a title
      --families         output information about family structures
      --female-ids       output ids of all females
      --founder-ids      output ids of all founders
      --male-ids         output ids of all males
      --maternal-ids     output ids of maternal individuals
      --paternal-ids     output ids of paternal individuals
      --primary-ids      output ids of all primary individuals
      --simple-dot       when outputting Graphviz format, use a layout that
                         looks less like a traditional pedigree diagram but
                         works better with large complex pedigrees

Utility
  -h, --help             print help on command-line flag usage
```

## rtg-tools_rtg_rocplot

### Tool Description
Plot ROC curves from vcfeval ROC data files, either to an image, or an interactive GUI.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg rocplot [OPTION]... FILE+
                   [OPTION]... --curve STRING

Plot ROC curves from vcfeval ROC data files, either to an image, or an
interactive GUI.

File Input/Output
      --curve=STRING          ROC data file with title optionally specified
                              (path[=title]). May be specified 0 or more times
      --png=FILE              if set, output a PNG image to the given file
      --svg=FILE              if set, output a SVG image to the given file
      --zoom=STRING           show a zoomed view with the given coordinates,
                              supplied in the form <xmax>,<ymax> or
                              <xmin>,<ymin>,<xmax>,<ymax>
      FILE+                   ROC data file. May be specified 0 or more times

Reporting
      --cmd=FILE              if set, print rocplot command used in previously
                              saved image
      --hide-sidepane         if set, hide the side pane from the GUI on
                              startup
      --interpolate           if set, interpolate curves at regular intervals
      --line-width=INT        sets the plot line width (Default is 2)
      --palette=STRING        name of color palette to use. Allowed values are
                              [blind_13, blind_15, blind_8, brewer_accent,
                              brewer_dark2, brewer_paired, brewer_pastel1,
                              brewer_pastel2, brewer_set1, brewer_set2,
                              brewer_set3, classic] (Default is classic)
      --plain                 if set, use a plain plot style
      --points                if set, show points on each curve
  -P, --precision-sensitivity if set, plot precision vs sensitivity rather than
                              ROC
      --scores                if set, show scores on the plot
  -t, --title=STRING          title for the plot

Utility
  -h, --help                  print help on command-line flag usage
```

## rtg-tools_rtg_popsim

### Tool Description
Generates a VCF containing simulated population variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg popsim [OPTION]... -o FILE -t SDF

Generates a VCF containing simulated population variants.

File Input/Output
  -o, --output=FILE   output VCF file name
  -t, --reference=SDF SDF containing the reference genome

Utility
  -h, --help          print help on command-line flag usage
  -Z, --no-gzip       do not gzip the output
      --seed=INT      seed for the random number generator
```

## rtg-tools_rtg_cgsim

### Tool Description
Simulate Complete Genomics Inc sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg cgsim [OPTION]... -V INT -t SDF -o SDF -c FLOAT
                 [OPTION]... -V INT -t SDF -o SDF -n INT

Simulate Complete Genomics Inc sequencing reads. Supports the original 35 bp
read structure (5-10-10-10), and the newer 29 bp read structure (10-9-10).

File Input/Output
  -t, --input=SDF                  SDF containing input genome
  -o, --output=SDF                 name for reads output SDF

Fragment Generation
      --abundance                  if set, the user-supplied distribution
                                   represents desired abundance
  -N, --allow-unknowns             allow reads to be drawn from template
                                   fragments containing unknown nucleotides
  -c, --coverage=FLOAT             coverage, must be positive
  -D, --distribution=FILE          file containing probability distribution for
                                   sequence selection
      --dna-fraction               if set, the user-supplied distribution
                                   represents desired DNA fraction
  -M, --max-fragment-size=INT      maximum fragment size (Default is 500)
  -m, --min-fragment-size=INT      minimum fragment size (Default is 350)
      --n-rate=FLOAT               rate that the machine will generate new
                                   unknowns in the read (Default is 0.0)
  -n, --num-reads=INT              number of reads to be generated
      --taxonomy-distribution=FILE file containing probability distribution for
                                   sequence selection expressed by taxonomy id

Complete Genomics
  -V, --cg-read-version=INT        select Complete Genomics read structure
                                   version, 1 (35 bp) or 2 (29 bp)

Utility
      --comment=STRING             comment to include in the generated SDF
  -h, --help                       print help on command-line flag usage
      --no-names                   do not create read names in the output SDF
      --no-qualities               do not create read qualities in the output
                                   SDF
  -q, --qual-range=STRING          set the range of base quality values
                                   permitted e.g.: 3-40 (Default is fixed
                                   qualities corresponding to overall machine
                                   base error rate)
      --sam-rg=STRING|FILE         file containing a single valid read group
                                   SAM header line or a string in the form
                                   "@RG\tID:READGROUP1\tSM:BACT_SAMPLE\tPL:ILLUMINA"
  -s, --seed=INT                   seed for random number generator
```

## rtg-tools_rtg_samplesim

### Tool Description
Generates a VCF containing a genotype simulated from population variants according to allele frequency.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg samplesim [OPTION]... -i FILE -o FILE -t SDF -s STRING

Generates a VCF containing a genotype simulated from population variants
according to allele frequency.

File Input/Output
  -i, --input=FILE       input VCF containing population variants
  -o, --output=FILE      output VCF file name
      --output-sdf=SDF   if set, output an SDF containing the sample genome
  -t, --reference=SDF    SDF containing the reference genome
  -s, --sample=STRING    name for sample

Utility
      --allow-missing-af if set, treat variants without allele frequency
                         annotation as uniformly likely
  -h, --help             print help on command-line flag usage
  -Z, --no-gzip          do not gzip the output
      --ploidy=STRING    ploidy to use. Allowed values are [auto, diploid,
                         haploid] (Default is auto)
      --seed=INT         seed for the random number generator
      --sex=SEX          sex of individual. Allowed values are [male, female,
                         either] (Default is either)
```

## rtg-tools_rtg_pedsamplesim

### Tool Description
Generates simulated genotypes for all members of a pedigree.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg pedsamplesim [OPTION]... -i FILE -o DIR -p FILE -t SDF

Generates simulated genotypes for all members of a pedigree.

File Input/Output
  -i, --input=FILE             input VCF containing parent variants
  -o, --output=DIR             directory for output
      --output-sdf             if set, output an SDF for the genome of each
                               simulated sample
  -p, --pedigree=FILE          genome relationships PED file
  -t, --reference=SDF          SDF containing the reference genome

Utility
      --extra-crossovers=FLOAT probability of extra crossovers per chromosome
                               (Default is 0.01)
      --genetic-map-dir=DIR    if set, load genetic maps from this directory
                               for recombination point selection
  -h, --help                   print help on command-line flag usage
  -Z, --no-gzip                do not gzip the output
      --num-mutations=INT      expected number of mutations per genome (Default
                               is 70)
      --ploidy=STRING          ploidy to use. Allowed values are [auto,
                               diploid, haploid] (Default is auto)
      --remove-unused          if set, output only variants used by at least
                               one sample
      --seed=INT               seed for the random number generator
```

## rtg-tools_rtg_fastqtrim

### Tool Description
Trim reads in FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg fastqtrim [OPTION]... -i FILE -o FILE

Trim reads in FASTQ files.

File Input/Output
  -i, --input=FILE                  input FASTQ file, Use '-' to read from
                                    standard input
  -o, --output=FILE                 output filename. Use '-' to write to
                                    standard output
  -q, --quality-format=FORMAT       quality data encoding method used in FASTQ
                                    input files (Illumina 1.8+ uses sanger).
                                    Allowed values are [sanger, solexa,
                                    illumina] (Default is sanger)

Filtering
      --discard-empty-reads         if set, discard reads that have zero length
                                    after trimming. Should not be used with
                                    paired-end data
  -E, --end-quality-threshold=INT   trim read ends to maximise base quality
                                    above the given threshold (Default is 0)
      --min-read-length=INT         if a read ends up shorter than this
                                    threshold it will be trimmed to zero length
                                    (Default is 0)
  -S, --start-quality-threshold=INT trim read starts to maximise base quality
                                    above the given threshold (Default is 0)
  -e, --trim-end-bases=INT          always trim the specified number of bases
                                    from read end (Default is 0)
  -s, --trim-start-bases=INT        always trim the specified number of bases
                                    from read start (Default is 0)

Utility
  -h, --help                        print help on command-line flag usage
  -Z, --no-gzip                     do not gzip the output
  -r, --reverse-complement          if set, output in reverse complement
      --seed=INT                    seed used during subsampling
      --subsample=FLOAT             if set, subsample the input to retain this
                                    fraction of reads
  -T, --threads=INT                 number of threads (Default is the number of
                                    available cores)
```

## rtg-tools_rtg_denovosim

### Tool Description
Generates a VCF containing a derived genotype containing de novo variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg denovosim [OPTION]... -i FILE --original STRING -o FILE -t SDF -s STRING

Generates a VCF containing a derived genotype containing de novo variants.

File Input/Output
  -i, --input=FILE        input VCF containing genotype of original sample
      --original=STRING   name of the existing sample to use as the original
                          genotype
  -o, --output=FILE       output VCF file name
      --output-sdf=SDF    if set, output an SDF containing the sample genome
  -t, --reference=SDF     SDF containing the reference genome
  -s, --sample=STRING     name for new derived sample

Utility
  -h, --help              print help on command-line flag usage
  -Z, --no-gzip           do not gzip the output
      --num-mutations=INT expected number of de novo mutations per genome
                          (Default is 70)
      --ploidy=STRING     ploidy to use. Allowed values are [auto, diploid,
                          haploid] (Default is auto)
      --seed=INT          seed for the random number generator
      --show-mutations    if set, display information regarding de novo
                          mutation points
```

## rtg-tools_rtg_sdf2sam

### Tool Description
Converts SDF data into SAM/BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg sdf2sam [OPTION]... -i SDF -o FILE STRING+
                   [OPTION]... -i SDF -o FILE -I FILE
                   [OPTION]... -i SDF -o FILE --end-id INT --start-id INT

Converts SDF data into SAM/BAM.

File Input/Output
  -i, --input=SDF    SDF containing sequences
  -o, --output=FILE  output filename (extension added if not present). Use '-'
                     to write to standard output

Filtering
      --end-id=INT   exclusive upper bound on sequence id
  -I, --id-file=FILE file containing sequence ids, or sequence names if --names
                     flag is set, one per line
  -n, --names        interpret supplied sequence as names instead of numeric
                     ids
      --start-id=INT inclusive lower bound on sequence id
      STRING+        id of sequence to extract, or sequence name if --names
                     flag is set. May be specified 0 or more times

Utility
  -h, --help         print help on command-line flag usage
  -Z, --no-gzip      do not gzip the output
```

## rtg-tools_rtg_sdf2fasta

### Tool Description
Converts SDF data into FASTA file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg sdf2fasta [OPTION]... -i SDF -o FILE STRING+
                     [OPTION]... -i SDF -o FILE -I FILE
                     [OPTION]... -i SDF -o FILE --end-id INT --start-id INT

Converts SDF data into FASTA file(s).

File Input/Output
  -i, --input=SDF       SDF containing sequences
  -o, --output=FILE     output filename (extension added if not present). Use
                        '-' to write to standard output

Filtering
      --end-id=INT      exclusive upper bound on sequence id
  -I, --id-file=FILE    file containing sequence ids, or sequence names if
                        --names flag is set, one per line
  -n, --names           interpret supplied sequence as names instead of numeric
                        ids
      --start-id=INT    inclusive lower bound on sequence id
      --taxons          interpret supplied sequence as taxon ids instead of
                        numeric sequence ids
      STRING+           id of sequence to extract, or sequence name if --names
                        flag is set. May be specified 0 or more times

Utility
  -h, --help            print help on command-line flag usage
      --interleave      interleave paired data into a single output file.
                        Default is to split to separate output files
  -l, --line-length=INT maximum number of nucleotides to print on a line of
                        output. A value of 0 indicates no limit (Default is 0)
  -Z, --no-gzip         do not gzip the output
```

## rtg-tools_rtg_sdf2fastq

### Tool Description
Converts SDF data into FASTQ file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg sdf2fastq [OPTION]... -i SDF -o FILE STRING+
                     [OPTION]... -i SDF -o FILE -I FILE
                     [OPTION]... -i SDF -o FILE --end-id INT --start-id INT

Converts SDF data into FASTQ file(s).

File Input/Output
  -i, --input=SDF           SDF containing sequences
  -o, --output=FILE         output filename (extension added if not present).
                            Use '-' to write to standard output

Filtering
      --end-id=INT          exclusive upper bound on sequence id
  -I, --id-file=FILE        file containing sequence ids, or sequence names if
                            --names flag is set, one per line
  -n, --names               interpret supplied sequence as names instead of
                            numeric ids
      --start-id=INT        inclusive lower bound on sequence id
      STRING+               id of sequence to extract, or sequence name if
                            --names flag is set. May be specified 0 or more
                            times

Utility
  -q, --default-quality=INT default quality value to use if the SDF does not
                            contain quality data (0-63)
  -h, --help                print help on command-line flag usage
      --interleave          interleave paired data into a single output file.
                            Default is to split to separate output files
  -l, --line-length=INT     maximum number of nucleotides to print on a line of
                            output. A value of 0 indicates no limit (Default is
                            0)
  -Z, --no-gzip             do not gzip the output
```

## rtg-tools_rtg_genomesim

### Tool Description
Simulates a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg genomesim [OPTION]... -o SDF --max-length INT --min-length INT -n INT
                     [OPTION]... -o SDF -l INT

Simulates a reference genome.

File Input/Output
  -o, --output=SDF      output SDF

Utility
      --comment=STRING  comment to include in the generated SDF
      --freq=STRING     relative frequencies of A,C,G,T in the generated
                        sequence (Default is 1,1,1,1)
  -h, --help            print help on command-line flag usage
  -l, --length=INT      length of generated sequence. May be specified 0 or
                        more times, or as a comma separated list
      --max-length=INT  maximum sequence length
      --min-length=INT  minimum sequence length
  -n, --num-contigs=INT number of sequences to generate
      --prefix=STRING   sequence name prefix (Default is simulatedSequence)
  -s, --seed=INT        seed for random number generator
```

## rtg-tools_rtg_childsim

### Tool Description
Generates a VCF containing a genotype simulated as a child of two parents.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg childsim [OPTION]... --father STRING -i FILE --mother STRING -o FILE -t SDF -s STRING

Generates a VCF containing a genotype simulated as a child of two parents.

File Input/Output
      --father=STRING          name of the existing sample to use as the father
  -i, --input=FILE             input VCF containing parent variants
      --mother=STRING          name of the existing sample to use as the mother
  -o, --output=FILE            output VCF file name
      --output-sdf=SDF         if set, output an SDF containing the sample
                               genome
  -t, --reference=SDF          SDF containing the reference genome
  -s, --sample=STRING          name for new child sample

Utility
      --extra-crossovers=FLOAT probability of extra crossovers per chromosome
                               (Default is 0.01)
      --genetic-map-dir=DIR    if set, load genetic maps from this directory
                               for recombination point selection
  -h, --help                   print help on command-line flag usage
  -Z, --no-gzip                do not gzip the output
      --ploidy=STRING          ploidy to use. Allowed values are [auto,
                               diploid, haploid] (Default is auto)
      --seed=INT               seed for the random number generator
      --sex=SEX                sex of individual. Allowed values are [male,
                               female, either] (Default is either)
      --show-crossovers        if set, display information regarding haplotype
                               selection and crossover points
```

## rtg-tools_rtg_samplereplay

### Tool Description
Generates the genome corresponding to a sample genotype.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg samplereplay [OPTION]... -i FILE -o SDF -t SDF -s STRING

Generates the genome corresponding to a sample genotype.

File Input/Output
  -i, --input=FILE    input VCF containing the sample genotype
  -o, --output=SDF    name for output SDF
  -t, --reference=SDF SDF containing the reference genome
  -s, --sample=STRING name of the sample to select from the VCF

Utility
  -h, --help          print help on command-line flag usage
```

## rtg-tools_rtg_readsim

### Tool Description
Generates reads from a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rtg readsim [OPTION]... -t SDF --machine STRING -o SDF -c FLOAT
                   [OPTION]... -t SDF --machine STRING -o SDF -n INT

Generates reads from a reference genome.

File Input/Output
  -t, --input=SDF                  SDF containing input genome
      --machine=STRING             select the sequencing technology to model.
                                   Allowed values are [illumina_se,
                                   illumina_pe, complete_genomics,
                                   complete_genomics_2, 454_pe, 454_se,
                                   iontorrent]
  -o, --output=SDF                 name for reads output SDF

Fragment Generation
      --abundance                  if set, the user-supplied distribution
                                   represents desired abundance
  -N, --allow-unknowns             allow reads to be drawn from template
                                   fragments containing unknown nucleotides
  -c, --coverage=FLOAT             coverage, must be positive
  -D, --distribution=FILE          file containing probability distribution for
                                   sequence selection
      --dna-fraction               if set, the user-supplied distribution
                                   represents desired DNA fraction
  -M, --max-fragment-size=INT      maximum fragment size (Default is 250)
  -m, --min-fragment-size=INT      minimum fragment size (Default is 200)
      --n-rate=FLOAT               rate that the machine will generate new
                                   unknowns in the read (Default is 0.0)
  -n, --num-reads=INT              number of reads to be generated
      --taxonomy-distribution=FILE file containing probability distribution for
                                   sequence selection expressed by taxonomy id

Illumina PE
  -L, --left-read-length=INT       target read length on the left side
  -R, --right-read-length=INT      target read length on the right side

Illumina SE
  -r, --read-length=INT            target read length, must be positive

454 SE/PE
      --454-max-total-size=INT     maximum 454 read length (in paired end case
                                   the sum of the left and the right read
                                   lengths)
      --454-min-total-size=INT     minimum 454 read length (in paired end case
                                   the sum of the left and the right read
                                   lengths)

IonTorrent SE
      --ion-max-total-size=INT     maximum IonTorrent read length
      --ion-min-total-size=INT     minimum IonTorrent read length

Utility
      --comment=STRING             comment to include in the generated SDF
  -h, --help                       print help on command-line flag usage
      --no-names                   do not create read names in the output SDF
      --no-qualities               do not create read qualities in the output
                                   SDF
  -q, --qual-range=STRING          set the range of base quality values
                                   permitted e.g.: 3-40 (Default is fixed
                                   qualities corresponding to overall machine
                                   base error rate)
      --sam-rg=STRING|FILE         file containing a single valid read group
                                   SAM header line or a string in the form
                                   "@RG\tID:READGROUP1\tSM:BACT_SAMPLE\tPL:ILLUMINA"
  -s, --seed=INT                   seed for random number generator
```

