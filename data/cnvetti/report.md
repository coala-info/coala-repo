# cnvetti CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cnvetti_cmd_build-model-pool | PASS |  |
| cnvetti_cmd_build-model-wis | PASS |  |
| cnvetti_cmd_coverage | PASS |  |
| cnvetti_cmd_genotype | PASS |  |
| cnvetti_cmd_merge-cov | PASS |  |
| cnvetti_cmd_merge-seg | PASS |  |
| cnvetti_cmd_mod-coverage | PASS |  |
| cnvetti_cmd_normalize | PASS |  |
| cnvetti_cmd_ratio | PASS |  |
| cnvetti_cmd_segment | PASS |  |
| cnvetti_quick_pool-build-model | PASS |  |
| cnvetti_quick_pool-call | PASS |  |
| cnvetti_quick_wis-build-model | PASS |  |
| cnvetti_quick_wis-call | Failed | Tool bug: the built-in genotyping step fails for every segmentation method (missing FORMAT/SGS or FORMAT/CVZ, or 'Not implemented yet'). |
| cnvetti_visualize_cov-to-igv | PASS |  |

## cnvetti_cmd_build-model-pool

### Tool Description
Build model based on pooling a reference panel.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-build-model-pool 0.1.0
Build model based on pooling a reference panel.

USAGE:
    cnvetti cmd build-model-pool [OPTIONS] <MULTICOV.bcf> --output <OUT.bcf>

OPTIONS:
    -o, --output <OUT.bcf>      Path to output normalized counts BCF file.
    -v, --verbose               Increase verbosity
    -q, --quiet                 Decrease verbosity
    -t, --io-threads <COUNT>    Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                  Prints help information
    -V, --version               Prints version information

ARGS:
    <MULTICOV.bcf>    Path to indexed BCF file that was merged from multiple coverage files.

This command takes a multi-sample coverage BCF file and computes per-region statistics across the cohort.  The output of
this step is a BCF without sample information that describes the coverage distribution for each region.  This file can
be used for annotation and filtering coverage BCF files (e.g., unreliable regions with a large normalized coverage IQR
across a cohort).
```

## cnvetti_cmd_build-model-wis

### Tool Description
Build within-sample model.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-build-model-wis 0.1.0
Build within-sample model.

USAGE:
    cnvetti cmd build-model-wis [OPTIONS] --input <INPUT.bcf> --output <OUT.bcf>

OPTIONS:
    -i, --input <INPUT.bcf>                        Path to indexed input BCF file from wise count.
    -o, --output <OUT.bcf>                         Path to output normalized counts BCF file.
        --num-threads <THREADS>
            Number of threads to use, '0' to disable multi-threading. [default: 0]

        --filter-z-score <MULT>                    Threshold on z score (default_value: 5.64). [default: 5.64]
        --filter-rel <REL>                         Relative threshold [default: 0.35]
        --min-ref-targets <COUNT>
            Minimal number of targets before filtering (default_value: 10). [default: 10]

        --max-ref-targets <COUNT>                  Number of targets to start out with. [default: 100]
        --max-samples-reliable <COUNT>
            If a CNV is called for more than this many reference samples then ignore.
             [default: 4]
        --min-samples-min-fragments <FRAGMENTS>
            Minimal number of samples that must have a number of fragments above `--min-fragments` from `normalize`.
             [default: 10]
    -v, --verbose                                  Increase verbosity
    -q, --quiet                                    Decrease verbosity
    -t, --io-threads <COUNT>
            Number of additional threads to use for (de)compression in I/O. [default: 0]

    -h, --help                                     Prints help information
    -V, --version                                  Prints version information

This command takes a multi-sample coverage file and computes a model for the analysis using the WISExome approach by
Straver et al. (2018).  The result is a BCF file without any per-sample annotation that is used as the reference BCF
file for input to the `cmd mod-coverage` step.
```

## cnvetti_cmd_coverage

### Tool Description
Record coverage from input BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-coverage 0.1.0
Record coverage from input BAM file

USAGE:
    cnvetti cmd coverage [FLAGS] [OPTIONS] --considered-regions <REGIONS> --count-kind <COUNT> --input <INPUT.bam> --output <OUT.bcf>

FLAGS:
    -h, --help          Prints help information
        --mask-piles    Enable pile-masking algorithm using the other `--pile-*` arguments.  See the manual for details.
    -q, --quiet         Decrease verbosity
    -V, --version       Prints version information
    -v, --verbose       Increase verbosity

OPTIONS:
        --blacklist-bed <MASKED.bed.gz>    Path to tabix-indexed blacklist BED file.
        --considered-regions <REGIONS>     The region type to consider.
                                            [possible values: GenomeWide, TargetRegions]
        --contig-regex <REGEX>             Regular expression for contigs considered for coverage. [default:
                                           ^(chr)?\d\d?$]
        --count-kind <COUNT>               Whether to consider alignment coverage or number of aligning fragments.  In
                                           the cases of WES data and low-coverage WGS data, counting fragment is
                                           recommended. Considering coverage is only recommended in the case of high-
                                           coverage WGS data.
                                            [possible values: Coverage, Fragments]
        --genome-region <REGION>           Optional genome region to limit the processing to.
        --input <INPUT.bam>                Path to BAI-indexed BAM file.
    -t, --io-threads <COUNT>               Number of additional threads to use for (de)compression in I/O. [default: 0]
        --mask-piles-fdr <FDR>             Compute pile depth threshold to get FDR less than or equal to this value.
                                           [default: 0.001]
        --min-mapq <MIN_MAPQ>              Alignments with alignment quality less than `MIN_MAPQ` will be ignored.
                                            [default: 0]
        --min-raw-coverage <COUNT>         Target regions with lower coverage are ignored. [default: 10]
        --min-unclipped <MIN_UNCLIPPED>    At least `MIN_UNCLIPPED` percent of the read have to be unclipped for it to
                                           be counted.
                                            [default: 0.6]
        --min-window-remaining <FRAC>      Minimal fraction of window that must remain after masking (e.g., for piles).
                                           [default: 0.5]
        --model-bcf <MODEL.bcf>            Path to WIS or pool-based model BCF file.
        --output <OUT.bcf>                 Path to output BCF file with the coverage information.  This will also write
                                           a corresponding `.csi` file.
        --output-masked-bed <MSK.bed>      Path to BED file with masked regions.
        --pile-mask-window-size <SIZE>     Mask windows of length `SIZE` when a pile occurs.  Set to `1` to do no
                                           window-based masking.
                                            [default: 1]
        --pile-max-gap <VAL>               Merge intervals for piles if distance is <= `VAL`. [default: 20]
        --reference <REF.fa>               Path to FAI-indexed reference FASTA file used for read alignment.  This is
                                           only required if GC-correction is to be performed downstream which is most
                                           likely the case except for on-target WES processing.
        --targets-bed <TGT.bed.gz>         Path to tabix-indexed BED file with intervals of the targets of WES.
        --window-length <LENGTH>           Length of window for binning on coverage computation.  Required unless

This command takes a BAM file with aligned reads from a WGS or targeted sequencing experiment and produces a BCF file
that describes read depth.  The depth can be either measured in base-wise coverage or fragment count.  It can be
generated for genome bins or for target regions.  The command will generate raw read depth information as well as
length-normalized read-depth information.  In the case of targeted sequencing and genomic bins (aka "off-target reads"),
read piles from target or off-target enriched regions can be masked.
```

## cnvetti_cmd_genotype

### Tool Description
Genotype calls from segmentation or calls and coverage BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-genotype 0.1.0
Genotype calls from segmentation or calls and coverage BCF files.

USAGE:
    cnvetti cmd genotype [OPTIONS] --genotyping <TYPE> --input <REGIONS.bcf> --output <OUT.bcf> --segmentation <TYPE>

OPTIONS:
    -i, --input <REGIONS.bcf>                Path to indexed input per-region segmentation or coverage file.
        --input-calls <CALLS.bcf>            Optional path to indexed call file.
    -o, --output <OUT.bcf>                   Path to output BCF file (will also write .csi file)
        --genotyping <TYPE>                  The method to use for the genotyping. [possible values:
                                             ExomeHiddenMarkovModel, SegmentOverlap]
        --segmentation <TYPE>                The method to use for the segmentation when using SegmentOverlap
                                             genotyping. [default: HaarSeg]  [possible values: HaarSeg]
        --overlap <overlap>                  Overlap to require for calling a segment as called when using
                                             SegmentOverlap genotyping.
                                              [default: 0.8]
        --xhmm-z-score-threshold <THRESH>    Z-score threshold to use. [default: 3.0]
        --xhmm-cnv-rate <RATE>               Expected exome-wide CNV rate for exome HMM segmentation. [default: 1e-08]
        --xhmm-mean-target-count <DIST>      Mean number of targets in a CNV for exome HMM segmentation. [default: 6]
        --xhmm-mean-target-dist <DIST>       Mean distance of targets in a CNV for exome HMM segmentation. [default:
                                             70000]
        --haar-seg-l-min <VALUE>              [default: 1]
        --haar-seg-l-max <VALUE>              [default: 5]
        --haar-seg-fdr <VALUE>                [default: 0.001]
        --thresh-p-value <P-VALUE>            [default: 0.05]
    -v, --verbose                            Increase verbosity
    -q, --quiet                              Decrease verbosity
    -t, --io-threads <COUNT>                 Number of additional threads to use for (de)compression in I/O. [default:
                                             0]
    -h, --help                               Prints help information
    -V, --version                            Prints version information

This command either creates genotype calls from a segmetation or from a call and a coverage BCF file. It will write out
a variant call file.
```

## cnvetti_cmd_merge-cov

### Tool Description
Merge the coverage information for multiple samples

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-merge-cov 0.1.0
Merge the coverage information for multiple samples

USAGE:
    cnvetti cmd merge-cov [OPTIONS] <INPUT.bcf>... --output <OUT.bcf>

OPTIONS:
    -o, --output <OUT.bcf>      Path to output BCF file (will also write .csi file)
    -v, --verbose               Increase verbosity
    -q, --quiet                 Decrease verbosity
    -t, --io-threads <COUNT>    Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                  Prints help information
    -V, --version               Prints version information

ARGS:
    <INPUT.bcf>...    Path to indexed input BCF or VCF file from `cnvetti cmd coverage` output.

This command merges multiple coverage BCF files with non-overlapping sample sets into one multi-sample coverage BCF
file.
Please note that this is only appropriate for merging coverage BCF files.  In case you have any problems with this
command, try using `bcftools merge -m id` instead of this cnvetti sub command.
```

## cnvetti_cmd_merge-seg

### Tool Description
Merge segmentation result files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-merge-seg 0.1.0
Merge segmentation result files.

USAGE:
    cnvetti cmd merge-seg [OPTIONS] <INPUT.bcf>... --output <OUT.bcf>

OPTIONS:
    -o, --output <OUT.bcf>                Path to BCF file with merged segments (will also write .csi file)
        --reciprocal-overlap <overlap>    Reciprocal overlap to require for merging segments [default: 0.8]
    -v, --verbose                         Increase verbosity
    -q, --quiet                           Decrease verbosity
    -t, --io-threads <COUNT>              Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                            Prints help information
    -V, --version                         Prints version information

ARGS:
    <INPUT.bcf>...    Path to indexed input BCF or VCF segment file from `cnvetti cmd segment` output.

This command takes one or more segment BCF files with segmentation results, merges the segments based on reciprocal
overlap and then writes out a BCF file that contains the segments as site list (only).
```

## cnvetti_cmd_mod-coverage

### Tool Description
Compute coverage with information from a model.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-mod-coverage 0.1.0
Compute coverage with information from a model.

USAGE:
    cnvetti cmd mod-coverage [OPTIONS] <INPUT.bcf> --output <OUT.bcf> <--input-wis-model <MODEL.bcf>|--input-pool-model <MODEL.bcf>>

OPTIONS:
        --input-wis-model <MODEL.bcf>     Path to BCF file with the within-sample model.
        --input-pool-model <MODEL.bcf>    Path to BCF file with the pool-of-reference model.
    -o, --output <OUT.bcf>                Path to output normalized counts BCF file.
    -v, --verbose                         Increase verbosity
    -q, --quiet                           Decrease verbosity
    -t, --io-threads <COUNT>              Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                            Prints help information
    -V, --version                         Prints version information

ARGS:
    <INPUT.bcf>    Path to indexed BCF file containing normalized counts.

This command takes a coverage BCF file as created by `cmd coverage` and a model BCF file generated by one of the `cmd
build-model-*` commands.  It then generates a coverage BCF file that expresses coverage incorporating information from
the model (i.e., coverage will be expressed relative to the model and be annotated with reliability information from the
model).
```

## cnvetti_cmd_normalize

### Tool Description
Normalize coverage on a per-sample level

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-normalize 0.1.0
Normalize coverage on a per-sample level

USAGE:
    cnvetti cmd normalize [OPTIONS] --input <INPUT.bcf> --normalization <TYPE> --output <OUT.bcf>

OPTIONS:
    -i, --input <INPUT.bcf>              Path to indexed input BCF or VCF file from `cnvetti cmd coverage` output.
    -o, --output <OUT.bcf>               Path to output BCF file (will also write .csi file)
        --min-gc-window-count <COUNT>    Flag windows of GC content with an occurence of less than `COUNT` as
                                         `INFO/FEW_GCWINDOWS`.
                                          [default: 100]
        --contig-regex <regex>           Regular expression for contigs taking part in statistics. [default:
                                         ^(chr)?\d\d?$]
        --normalization <TYPE>           The method to use for read count/coverage normalization. [possible values:
                                         TotalCoverageSum, CoverageMedian, MedianGcBinned, ExcavatorStyle]
    -v, --verbose                        Increase verbosity
    -q, --quiet                          Decrease verbosity
    -t, --io-threads <COUNT>             Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                           Prints help information
    -V, --version                        Prints version information

This command takes the coverage BAM file generated by `cmd coverage` and performs normalization on the whole-sample
level.
```

## cnvetti_cmd_ratio

### Tool Description
Compute the ratio between the coverages in two files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-ratio 0.1.0
Compute the ratio between the coverages in two files.

USAGE:
    cnvetti cmd ratio [OPTIONS] <INPUT.bcf> --denominator-sample <DENOMINATOR> --numerator-sample <NUMERATOR> --output <OUT.bcf>

OPTIONS:
    -o, --output <OUT.bcf>                    Path to output BCF file (will also write .csi file)
        --numerator-sample <NUMERATOR>        Name of numerator sample name (tumor).
        --denominator-sample <DENOMINATOR>    Name of denominator sample name (normal).
    -v, --verbose                             Increase verbosity
    -q, --quiet                               Decrease verbosity
    -t, --io-threads <COUNT>                  Number of additional threads to use for (de)compression in I/O. [default:
                                              0]
    -h, --help                                Prints help information
    -V, --version                             Prints version information

ARGS:
    <INPUT.bcf>    Path to BCF or VCF file with merged coverages

After computing coverage of tumor and normal samples and merging the resulting files, use this command to compute the
ratio and log2-ratio between the two samples.
```

## cnvetti_cmd_segment

### Tool Description
Segment normalized coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd-segment 0.1.0
Segment normalized coverage.

USAGE:
    cnvetti cmd segment [OPTIONS] --input <INPUT.bcf> --output <OUT.bcf> --segmentation <TYPE>

OPTIONS:
    -i, --input <INPUT.bcf>                   Path to indexed input BCF or VCF file from `cnvetti cmd coverage` output.
    -o, --output <OUT.bcf>                    Path to output BCF file (will also write .csi file)
        --output-segments <SEGS.bcf>          Path to output BCF file with the segment information (only).
        --segmentation <TYPE>                 The method to use for the segmentation. [possible values: HaarSeg,
                                              CircularBinarySegmentation, GenomeHiddenMarkovModel,
                                              ExomeHiddenMarkovModel, WISExome]
        --thresh-p-value <P-VALUE>             [default: 0.05]
        --haar-seg-l-min <VALUE>               [default: 1]
        --haar-seg-l-max <VALUE>               [default: 5]
        --haar-seg-fdr <VALUE>                 [default: 0.001]
        --wisexome-max-window-size <VALUE>     [default: 15]
        --wisexome-thresh-rel-cov <THRESH>    Threshold on relative coverage deviation. [default: 0.35]
        --wisexome-thresh-z-score <THRESH>    Threshold on Z-score [default: 5.64]
        --xhmm-z-score-threshold <THRESH>     Z-score threshold to use. [default: 3.0]
        --xhmm-cnv-rate <RATE>                Expected exome-wide CNV rate for exome HMM segmentation. [default: 1e-08]
        --xhmm-mean-target-count <DIST>       Mean number of targets in a CNV for exome HMM segmentation. [default: 6]
        --xhmm-mean-target-dist <DIST>        Mean distance of targets in a CNV for exome HMM segmentation. [default:
                                              70000]
    -v, --verbose                             Increase verbosity
    -q, --quiet                               Decrease verbosity
    -t, --io-threads <COUNT>                  Number of additional threads to use for (de)compression in I/O. [default:
                                              0]
    -h, --help                                Prints help information
    -V, --version                             Prints version information

This command takes a normalized coverage BCF file and performs a segmentation of the coverage values found therein with
the selected segmentation algorithm.
```

## cnvetti_quick_pool-build-model

### Tool Description
Build a pool-based-sample model for targeted sequencing CNV calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-quick-pool-build-model 0.1.0
Build a pool-based-sample model for targeted sequencing CNV calling.

USAGE:
    cnvetti quick pool-build-model [OPTIONS] <INPUT.bam>... --output <OUT.bcf> --targets-bed <TGT.bed.gz>

OPTIONS:
        --targets-bed <TGT.bed.gz>    Path to tabix-indexed BED file with intervals of the targets of WES.
    -o, --output <OUT.bcf>            Path to output model BCF file.
        --output-cov <OUT.cov.bcf>    Path to output per-sample coverage BCF file.
        --num-threads <THREADS>       Number of threads to use. [default: 1]
    -v, --verbose                     Increase verbosity
    -q, --quiet                       Decrease verbosity
    -t, --io-threads <COUNT>          Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                        Prints help information
    -V, --version                     Prints version information

ARGS:
    <INPUT.bam>...    Path to indexed input BAM file.

This call takes a list of BAM files that are aligned to the same reference and are ideally unrelated to reduce biases
and skews in the resulting model.  Further, a tabix- indexed BED file with target regions is required.
The command writes a BCF file that gives per-region coverage statistics.
The processing of the input files happens in parallel.
```

## cnvetti_quick_pool-call

### Tool Description
Perform CNV calling on germline or unmatched tumor using pooling approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-quick-pool-call 0.1.0
Perform CNV calling on germline or unmatched tumor using pooling approach.

USAGE:
    cnvetti quick pool-call [OPTIONS] <INPUT.bam> --input-model <MODEL.bcf> --output <OUT.bcf> --segmentation <TYPE>

OPTIONS:
        --input-model <MODEL.bcf>             Path to BCF file with the pool model.
    -o, --output <OUT.bcf>                    Path to output CNV call file.
        --output-targets <OUT.tgts.bcf>       Optional path to BCF file with per-target coverage information (similar
                                              level of information to probes in arrays).
        --output-igv-cov <COV.igv>            Optional path to IGV file to write (linear relative) coverage to.
        --output-igv-cov2 <COV2.igv>          Optional path to IGV file to write log2-scaled coverage to.
        --output-igv-covz <COVZ.igv>          Optional path to IGV file to write coverage Z-score to.
        --output-igv-scov <SCOV.igv>          Optional path to IGV file to write (linear relative) smoothed coverage to.
        --output-igv-scov2 <SCOV2.igv>        Optional path to IGV file to write log2-scaled smoothed coverage to.
        --output-igv-seg <SEG.igv>            Optional path to IGV file to write (linear relative) segmented coverage
                                              to.
        --output-igv-seg2 <SEG2.igv>          Optional path to IGV file to write log2-scaled segmented coverage to.
        --segmentation <TYPE>                 The method to use for the segmentation. [possible values: HaarSeg,
                                              CircularBinarySegmentation, GenomeHiddenMarkovModel,
                                              ExomeHiddenMarkovModel, WISExome]
        --thresh-p-value <P-VALUE>             [default: 0.05]
        --haar-seg-l-min <VALUE>               [default: 1]
        --haar-seg-l-max <VALUE>               [default: 5]
        --haar-seg-fdr <VALUE>                 [default: 0.001]
        --wisexome-max-window-size <VALUE>     [default: 15]
        --wisexome-thresh-rel-cov <THRESH>    Threshold on relative coverage deviation. [default: 0.35]
        --wisexome-thresh-z-score <THRESH>    Threshold on Z-score [default: 5.64]
        --xhmm-z-score-threshold <THRESH>     Z-score threshold to use. [default: 3.0]
        --xhmm-cnv-rate <RATE>                Expected exome-wide CNV rate for exome HMM segmentation. [default: 1e-08]
        --xhmm-cnv-target-count <DIST>        Mean number of targets in a CNV for exome HMM segmentation. [default: 6]
        --xhmm-mean-target-dist <DIST>        Mean distance of targets in a CNV for exome HMM segmentation. [default:
                                              70000]
    -v, --verbose                             Increase verbosity
    -q, --quiet                               Decrease verbosity
    -t, --io-threads <COUNT>                  Number of additional threads to use for (de)compression in I/O. [default:
                                              0]
    -h, --help                                Prints help information
    -V, --version                             Prints version information

ARGS:
    <INPUT.bam>    Path to indexed input BAM file.

This shortcut takes as the input a BCF file with the pooling model from `cnvetti quick pool-build-model` and a BAM file
of one germline or unmatched tumor sample.
It will then generate on-target CNV analysis and perform CNV variant calling using the resulting on-target coverage
result.
```

## cnvetti_quick_wis-build-model

### Tool Description
Build an within-sample model for targeted sequencing CNV calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-quick-wis-build-model 0.1.0
Build an within-sample model for targeted sequencing CNV calling.

USAGE:
    cnvetti quick wis-build-model [OPTIONS] <INPUT.bam>... --output <OUT.bcf> --targets-bed <TGT.bed.gz>

OPTIONS:
        --targets-bed <TGT.bed.gz>    Path to tabix-indexed BED file with intervals of the targets of WES.
    -o, --output <OUT.bcf>            Path to output model BCF file.
        --output-cov <OUT.cov.bcf>    Path to output per-sample coverage BCF file.
        --num-threads <THREADS>       Number of threads to use. [default: 1]
    -v, --verbose                     Increase verbosity
    -q, --quiet                       Decrease verbosity
    -t, --io-threads <COUNT>          Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                        Prints help information
    -V, --version                     Prints version information

ARGS:
    <INPUT.bam>...    Path to indexed input BAM file.

This call takes a list of BAM files that are aligned to the same reference and are ideally unrelated to reduce biases
and skews in the resulting model.  Further, a tabix- indexed BED file with target regions is required.
The command writes a BCF file that defines a list of reference target regions for each of the input target regions.
The processing of the input files happens in parallel as well as the computation of the distance matrix when building
the model.
```

## cnvetti_quick_wis-call

### Tool Description
Perform CNV calling on germline or unmatched tumor using within-sample approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-quick-wis-call 0.1.0
Perform CNV calling on germline or unmatched tumor using within-sample approach.

USAGE:
    cnvetti quick wis-call [OPTIONS] <INPUT.bam> --input-model <MODEL.bcf> --output <OUT.bcf> --segmentation <TYPE>

OPTIONS:
        --input-model <MODEL.bcf>             Path to BCF file with the WIS model.
    -o, --output <OUT.bcf>                    Path to output CNV call file.
        --output-targets <OUT.tgts.bcf>       Optional path to BCF file with per-target coverage information (similar
                                              level of information to probes in arrays).
        --output-igv-cov <COV.igv>            Optional path to IGV file to write (linear relative) coverage to.
        --output-igv-cov2 <COV2.igv>          Optional path to IGV file to write log2-scaled coverage to.
        --output-igv-scov <SCOV.igv>          Optional path to IGV file to write (linear relative) smoothed coverage to.
        --output-igv-scov2 <SCOV2.igv>        Optional path to IGV file to write log2-scaled smoothed coverage to.
        --output-igv-covz <COVZ.igv>          Optional path to IGV file to write coverage Z-score to.
        --output-igv-seg <SEG.igv>            Optional path to IGV file to write (linear relative) segmented coverage
                                              to.
        --output-igv-seg2 <SEG.igv>           Optional path to IGV file to write log2-scaled segmented coverage to.
        --segmentation <TYPE>                 The method to use for the segmentation. [possible values: HaarSeg,
                                              CircularBinarySegmentation, GenomeHiddenMarkovModel,
                                              ExomeHiddenMarkovModel, WISExome]
        --thresh-p-value <P-VALUE>             [default: 0.05]
        --haar-seg-l-min <VALUE>               [default: 1]
        --haar-seg-l-max <VALUE>               [default: 5]
        --haar-seg-fdr <VALUE>                 [default: 0.001]
        --wisexome-max-window-size <VALUE>     [default: 15]
        --wisexome-thresh-rel-cov <THRESH>    Threshold on relative coverage deviation. [default: 0.35]
        --wisexome-thresh-z-score <THRESH>    Threshold on Z-score [default: 5.64]
        --xhmm-z-score-threshold <THRESH>     Z-score threshold to use. [default: 3.0]
        --xhmm-cnv-rate <RATE>                Expected exome-wide CNV rate for exome HMM segmentation. [default: 1e-08]
        --xhmm-cnv-target-count <DIST>        Mean number of targets in a CNV for exome HMM segmentation. [default: 6]
        --xhmm-mean-target-dist <DIST>        Mean distance of targets in a CNV for exome HMM segmentation. [default:
                                              70000]
    -v, --verbose                             Increase verbosity
    -q, --quiet                               Decrease verbosity
    -t, --io-threads <COUNT>                  Number of additional threads to use for (de)compression in I/O. [default:
                                              0]
    -h, --help                                Prints help information
    -V, --version                             Prints version information

ARGS:
    <INPUT.bam>    Path to indexed input BAM file.

This shortcut takes as the input a BCF file with the within-sample model from `cnvetti quick wis-build-model` and a BAM
file of one germline or unmatched tumor sample.
It will then generate on-target CNV analysis and perform CNV variant calling using the resulting on-target coverage
result.
```

## cnvetti_visualize_cov-to-igv

### Tool Description
Build `.igv` visualization tracks from coverage BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-visualize-cov-to-igv 0.1.0
Build `.igv` visualization tracks from coverage BCF files.

USAGE:
    cnvetti visualize cov-to-igv [OPTIONS] <COV.bcf> --output-igv-cov <OUT.cov.igv> --output-igv-cov2 <OUT.cov2.igv>

OPTIONS:
        --output-igv-cov <OUT.cov.igv>      Path to IGV coverage file writing out the raw coverage signal.
        --output-igv-cov2 <OUT.cov2.igv>    Path to IGV coverage file writing out the log2-transformed coverage signal.
        --output-igv-covz <COVZ.igv>        Optional path to IGV file to write coverage Z-score to.
        --output-igv-scov <SCOV.igv>        Optional path to IGV file to write (linear relative) smoothed coverage to.
        --output-igv-scov2 <SCOV2.igv>      Optional path to IGV file to write log2-scaled smoothed coverage to.
        --output-igv-seg <SEG.igv>          Optional path to IGV file to write (linear relative) segmented coverage to.
        --output-igv-seg2 <SEG2.igv>        Optional path to IGV file to write log2-scaled segmented coverage to.
    -v, --verbose                           Increase verbosity
    -q, --quiet                             Decrease verbosity
    -t, --io-threads <COUNT>                Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                              Prints help information
    -V, --version                           Prints version information

ARGS:
    <COV.bcf>    Path to indexed input BCF file.

This visualization command allows to extract coverage information tracks in IGV format from (target) coverage BCF files.
These files can then be convered into TDF format using `igvtools totdf FILE GENOME`.
```

## Metadata
- **Skill**: generated
