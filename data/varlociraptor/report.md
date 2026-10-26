# varlociraptor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| varlociraptor_call_variants_generic | PASS |  |
| varlociraptor_call_variants_tumor-normal | PASS |  |
| varlociraptor_decode-phred | PASS |  |
| varlociraptor_estimate_alignment-properties | PASS |  |
| varlociraptor_estimate_contamination | Not completed | runs and writes a posterior table and plot, but the 11-site test input gives a flat posterior, so the estimate cannot be confirmed |
| varlociraptor_estimate_mutational-burden | PASS |  |
| varlociraptor_filter-calls_control-fdr | PASS |  |
| varlociraptor_filter-calls_posterior-odds | PASS |  |
| varlociraptor_genotype | PASS |  |
| varlociraptor_methylation-candidates | PASS |  |
| varlociraptor_plot_scatter | PASS |  |
| varlociraptor_plot_variant-calling-prior | PASS |  |
| varlociraptor_preprocess_variants | PASS |  |

## varlociraptor_decode-phred

### Tool Description
Decode PHRED-scaled values to human readable probabilities.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-decode-phred 8.9.5
Decode PHRED-scaled values to human readable probabilities.

USAGE:
    varlociraptor decode-phred < in.bcf > out.bcf

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information
```


## varlociraptor_methylation-candidates

### Tool Description
Generate BCF with methylation candidates

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-methylation-candidates 8.9.5
Generate BCF with methylation candidates

USAGE:
    varlociraptor methylation-candidates input.fasta output.bcf

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --motifs <motifs>...    Comma-separated list of methylation motifs to search for in the input chromosome.
                                Supported motifs: CG, CHG, CHH, GATC.

ARGS:
    <input>     Input FASTA File
    <output>    Output BCF File
```


## varlociraptor_filter-calls_posterior-odds

### Tool Description
Filter variant calls by posterior odds of given events against the rest of events.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-filter-calls-posterior-odds 8.9.5
Filter variant calls by posterior odds of given events against the rest of events. Calls are taken from STDIN, filtered
calls are printed to STDOUT.

USAGE:
    varlociraptor filter-calls posterior-odds --events SOMATIC_TUMOR --odds strong < calls.bcf

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --events <events>...    Events to consider.
        --odds <odds>           Kass-Raftery score to filter against. [possible values: none, barely, positive, strong,
                                very-strong]
```

## varlociraptor_filter-calls_control-fdr

### Tool Description
Filter variant calls by controlling FDR.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-filter-calls-control-fdr 8.9.5
Filter variant calls by controlling FDR. Filtered calls are printed to STDOUT.

USAGE:
    varlociraptor filter-calls control-fdr calls.bcf --events SOMATIC_TUMOR --fdr 0.05 --var SNV > calls.filtered.bcf

FLAGS:
    -h, --help                      Prints help information
        --smart-retain-artifacts    Whether smart mode shall retain artifact calls instead of taking the sum of artifact
                                    probability and absent probability for determining whether a variant shall be
                                    filtered. Setting this causes variants that are marked as artifacts to be kept.
                                                
    -V, --version                   Prints version information

OPTIONS:
        --events <events>...    Events to consider.
        --fdr <fdr>             FDR to control for.
        --maxlen <maxlen>       Maximum indel length to consider (exclusive).
        --minlen <minlen>       Minimum indel length to consider.
        --mode <mode>           Mode of FDR control (recommended: local-smart). Choose between local or global and
                                strict or smart, combined via a hyphen (e.g. local-smart). Local means that for each
                                record, the posterior of the selected events has to be at least 1-fdr. Global means that
                                the posterior FDR of all selected records may not exceed the given fdr threshold. Strict
                                means that the given events are directly used for above calculations. Smart means that
                                FDR is controlled just by the probability of variants to be not absent or artifacts, and
                                the given events are used to further filter out those where the summed probability of
                                the particular events is <50%. Smart mode is recommended, as the strict mode can lead to
                                unexpected behavior. For example: if want to control for somatic variants, but there is
                                a degree of ambiguity between the somatic and some other event, strict mode will filter
                                such variants, while smart mode will keep them and you will see the ambiguity in the
                                record. The former behavior is much more intuitive than loosing such variants entirely.
        --var <vartype>         Variant type to consider. When controlling global FDR (not using --local) this should be
                                used to control FDR for each type separately. Otherwise, less certain variant types will
                                be underrepresented. [possible values: INS, DEL, METH, SNV, MNV, BND, INV, DUP, REP,
                                REF]

ARGS:
    <calls>    BCF file with varlociraptor calls.
```

## varlociraptor_preprocess_variants

### Tool Description
Preprocess given variants by obtaining internal observations for each fragment.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-preprocess-variants 8.9.5
Preprocess given variants by obtaining internal observations (allele likelihoods, strand information, ...)for each
fragment. The obtained observations are printed to STDOUT in BCF format. Note that the resulting BCFs will be very large
and are only intended for internal use (e.g. for piping into 'varlociraptor call variants generic').

USAGE:
    varlociraptor preprocess variants reference.fasta --alignment-properties alignment-properties.json --candidates candidates.bcf --bam sample.bam > sample.observations.bcf

FLAGS:
        --atomic-candidate-variants    Assume that candidate variants are given in atomic form (unlike e.g. provided by
                                       freebayes which combines adjacent variants that appear to be in phase into longer
                                       haplotypes). If variants are atomic, we do not want to perform realignment
                                       against SNVs and MNVs because those can lead to false positives if they are
                                       immediately followed or preceeded by indels.
    -h, --help                         Prints help information
        --omit-insert-size             Do not consider insert size when calculating support for a variant. Use this flag
                                       when processing amplicon data, where indels do not impact the observed insert
                                       size
        --omit-mapq-adjustment         Do not adjust mapping quality (MAPQ). By default Varlociraptor will adjust
                                       mapping qualities in order to avoid false positive hits caused by inflated MAPQ
                                       values at ambiguous loci. This happens by conservatively averaging MAPQs of all
                                       reads that overlap a given locus. While this is usually a good idea and has been
                                       validated by extensive benchmarking, there can be cases where this is not
                                       desired, e.g. when solely evaluating known variants.
        --report-fragment-ids          Report fragment IDs in output BCF. This information can be used for phasing.
    -V, --version                      Prints version information

OPTIONS:
        --alignment-properties <alignment-properties>
            Alignment properties JSON file for sample. If not provided, properties will be estimated from the given BAM
            file. It is recommended to estimate alignment properties separately, see 'varlociraptor estimate alignment-
            properties --help'.
        --bam <bam>
            BAM file with aligned reads from a single sample. BAM file must be indexed (e.g. with samtools index).

        --candidates <candidates>
            sorted VCF/BCF file to process (if omitted, read from STDIN).

        --log-mode <log-mode>
            Specify how progress should be logged. By default, a record count will be printed. With 'each-record',
            Varlociraptor will additionally print contig and position of each processed candidate variant record. This
            is useful for debugging. [default: default]  [possible values: default, each-record]
        --max-depth <max-depth>
            Maximum number of observations to use for calling. If locus is exceeding this number, downsampling is
            performed. [default: 200]
        --methylation-read-type <methylation-readtype>
            Type of methylation information encoded in the reads. Use 'converted' for reads treated with bisulfite or
            EMSeq. Use 'annotated' for reads where methylation information is encoded in the MM and ML tags. [possible
            values: annotated, converted]
        --min-bam-refetch-distance <min-bam-refetch-distance>
            Base pair distance to last fetched BAM interval such that a refetching is performed instead of reading
            through until the next interval is reached. Making this too small can cause unnecessary random access.
            Making this too large can lead to unneccessary iteration over irrelevant records. Benchmarking has shown
            that at least for short reads, a value of 1 (e.g. always refetch) does not incur additional costs and is a
            reasonable default. [default: 1]
        --output <output>
            BCF file that shall contain the results (if omitted, write to STDOUT).

        --output-raw-observations <output-raw-observations>
            Output raw observations as TSV files at the given prefix. Attention, only use this for debugging when
            processing a single variant. Otherwise it will cause a lots of files and a significant performance hit.
        --pairhmm-mode <pairhmm-mode>
            PairHMM computation mode (either fast, exact or homopolymer). Fast mode means that only the best alignment
            path is considered for probability calculation. In rare cases, this can lead to wrong results for single
            reads. Hence, we advice to not use it when discrete allele frequences are of interest (0.5, 1.0). For
            continuous allele frequencies, fast mode should cause almost no deviations from the exact results. Also, if
            per sample allele frequencies are irrelevant (e.g. in large cohorts), fast mode can be safely used. Note
            that fast and exact mode are not suitable for ONT data.The homopolymer mode should be used for ONT data; it
            is similar to the exact mode but considers homopolymer errors to be different from gaps. [default: exact]
            [possible values: fast, exact, homopolymer]
        --propagate-info-fields <propagate-info-fields>...
            Additional INFO fields in the input BCF that shall be propagated to the output BCF (not supported for
            variants connected via EVENT tags except breakends).
        --indel-window <realignment-window>
            Number of bases to consider left and right of breakpoint when calculating read support. Currently
            implemented maximum value is 64. [default: 64]
    -b, --reference-buffer-size <reference-buffer-size>
            Number of reference sequences to keep in buffer. Use a smaller value to save memory at the expense of
            sometimes reduced parallelization. [default: 10]
        --variant-heterozygosity-field <variant-heterozygosity-field>
            Name of INFO field containing an expected heterozygosity per variant allele (can be e.g. a population allele
            frequency). Field needs to have as many entries as ALT alleles per VCF/BCF record.
        --variant-somatic-effective-mutation-rate-field <variant-somatic-effective-mutation-rate-field>
            Name of INFO field containing an expected somatic effective mutation rate per variant allele (can be e.g. a
            poplulation scale prevalence of a known cancer variant from a database). Field needs to have as many entries
            as ALT alleles per VCF/BCF record.

ARGS:
    <reference>    FASTA file with reference genome. Has to be indexed with (e.g. with samtools faidx).
```

## varlociraptor_estimate_mutational-burden

### Tool Description
Estimate mutational burden from Varlociraptor calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-estimate-mutational-burden 8.9.5
Estimate mutational burden. Takes Varlociraptor calls (must be annotated with e.g. VEP but using ANN instead of CSQ)
from STDIN, prints mutational burden estimate in Vega-lite JSON format to STDOUT. It can be converted to an image via
vega-lite-cli (see conda package).

USAGE:
    varlociraptor estimate mutational-burden --mode curve --coding-genome-size 3e7 --events SOMATIC_TUMOR --sample tumor < calls.bcf | vg2svg > tmb.svg
    varlociraptor estimate mutational-burden --mode table --coding-genome-size 3e7 --events SOMATIC_TUMOR --sample tumor < calls.bcf > tmb.tsv

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --coding-genome-size <coding-genome-size>    Size (in bases) of the covered coding genome. [default: 3e7]
        --vaf-cutoff <cutoff>
            Minimal variant allelic fraction to consider for mutli-sample barplot [default: 0.2]

        --events <events>...                         Events to consider (e.g. SOMATIC_TUMOR).
        --mode <mode>
            How to output to STDOUT (as stratified curve, histogram, or multi-sample barplot, or TSV table). [possible
            values: hist, curve, multibar, table]
        --sample <sample>...
            Name(s) of the sample(s) in the given VCF/BCF. Multiple samples can be given when using the multibar plot
            mode.
```

## varlociraptor_estimate_contamination

### Tool Description
Estimate contamination between samples (still experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-estimate-contamination 8.9.5
Estimate contamination between samples (still experimental). Takes two samples, the one that is presumably contaminated
and the contaminating one, and calculates the posterior distribution of the contamination fraction, which is printed
into a TSV table. The most likely fraction comes at the top. Uses a uniform prior distribution by default. Optionally,
e.g. a pathologist's estimate can be provided, such that the calculated posterior distribution can be sharpened by the
model with the given prior knowledge. For now, it is always advisable to check the visual output generated by --output-
plot.

USAGE:
    varlociraptor estimate contamination --sample sample-a.bcf --contaminant sample-b.bcf --output-plot contamination-qc-plot.vl.json > contamination.tsv

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --contaminant <contaminant>                            Presumably contaminating sample.
        --output <output>
            Output file; if not specified, output is printed to STDOUT.

        --output-max-vaf-variants <output-max-vaf-variants>
            Path to store TSV of variant positions with maximum VAF in the contaminated sample (for QC).

        --output-plot <output-plot>                            Path to store vega-lite plot of contamination/purity.
        --prior-considered-cells <prior-considered-cells>
            Number of cells considered for the prior estimate (see --prior-estimate).

        --prior-estimate <prior-estimate>
            Prior estimate of the contamination (1-purity), e.g. obtained by counting tumor cells in a histology sample.
            Has to be used together with the number of cells considered for the estimate (--prior-considered-cells).
        --sample <sample>                                      Presumably contaminated sample.
```

## varlociraptor_genotype

### Tool Description
Infer classical genotypes from Varlociraptor's AF field.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-genotype 8.9.5
Infer classical genotypes from Varlociraptor's AF field (1.0: 1/1, 0.5: 0/1, 0.0: 0/0, otherwise: 0/1). This assumes
diploid samples.

USAGE:
    varlociraptor genotype < in.bcf > out.bcf

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information
```

## varlociraptor_call_variants_generic

### Tool Description
Call variants for a given scenario specified with the varlociraptor calling grammar.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-call-variants-generic 8.9.5
Call variants for a given scenario specified with the varlociraptor calling grammar and a VCF/BCF with candidate
variants.

USAGE:
    varlociraptor call variants --output calls.bcf generic --scenario scenario.yaml --obs relapse=relapse.bcf tumor=tumor.bcf normal=normal.bcf

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --obs <sample-observations>...    BCF file with varlociraptor preprocess results for samples defined in the
                                          given scenario (given as samplename=path/to/calls.bcf). It is possible to omit
                                          a sample here (e.g. model tumor/normal in the scenario, but only call on the
                                          tumor sample when there is no normal sequenced). In that case, the resulting
                                          probabilities will be accordingly uncertain, because observations of the
                                          omitted sample are missing (which is equivalent to having no coverage in the
                                          sample).
        --scenario <scenario>             Scenario defined in the varlociraptor calling grammar.
```

## varlociraptor_plot_variant-calling-prior

### Tool Description
Plot variant calling prior given a scenario.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-plot-variant-calling-prior 8.9.5
Plot variant calling prior given a scenario. Plot is printed to STDOUT in Vega-lite format.

USAGE:
    varlociraptor plot variant-calling-prior --scenario scenario.yaml > plot.vl.json

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --contig <contig>        Contig to consider for ploidy information.
        --sample <sample>        Sample to plot.
        --scenario <scenario>    Variant calling scenario that configures the prior.
```

## varlociraptor_call_variants_tumor-normal

### Tool Description
Call somatic and germline variants from a tumor-normal sample pair.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-call-variants-tumor-normal 8.9.5
Call somatic and germline variants from a tumor-normal sample pair and a VCF/BCF with candidate variants.

USAGE:
    varlociraptor call variants tumor-normal --purity 0.75 --tumor tumor.bcf --normal normal.bcf > calls.bcf

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --normal <normal-observations>    BCF file with varlociraptor preprocess results for the normal sample.
    -p, --purity <purity>                 Purity of tumor sample. [default: 1.0]
        --tumor <tumor-observations>      BCF file with varlociraptor preprocess results for the tumor sample.
```

## varlociraptor_estimate_alignment-properties

### Tool Description
Estimate properties like insert size, maximum softclip length, and the PCR homopolymer error model.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-estimate-alignment-properties 8.9.5
Estimate properties like insert size, maximum softclip length, and the PCR homopolymer error model.

USAGE:
    varlociraptor estimate alignment-properties reference.fasta --bams sample.bam > sample.alignment-properties.json

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --bams <bams>...               BAM files with aligned reads from a single sample or a set of samples that have
                                       been sequenced and prepared in exactly the same way. Use multiple BAM files in
                                       order to increase estimation robustness in case the samples only have comparably
                                       few reads (e.g. in case of panel sequencing).
        --num-records <num-records>    Number of records to sample from the BAM file

ARGS:
    <reference>    FASTA file with reference genome. Has to be indexed with samtools faidx.
```

## varlociraptor_plot_scatter

### Tool Description
Plot variant allelic fraction scatter plot overlayed with a contour plot between two sample groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
- **Homepage**: https://varlociraptor.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/varlociraptor/overview
- **Validation**: PASS

### Original Help Text
```text
varlociraptor-plot-scatter 8.9.5
Plot variant allelic fraction scatter plot overlayed with a contour plot between two sample groups

USAGE:
    varlociraptor plot scatter --sample-x sample1 --sample-y sample2 sample3 < calls.bcf | vg2svg > scatter.svg

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --sample-x <sample-x>       Name of the first sample in the given VCF/BCF.
        --sample-y <sample-y>...    Name(s) of the alternative sample(s) in the given VCF/BCF. Multiple samples can be
                                    given.
```

## Metadata
- **Skill**: generated
