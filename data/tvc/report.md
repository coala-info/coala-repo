# tvc CWL Generation Report

## tvc

### Tool Description
Torrent Variant Caller

### Metadata
- **Docker Image**: biocontainers/tvc:v5.0.3git20151221.80e144edfsg-2-deb_cv1
- **Homepage**: https://github.com/tronscan/tron-tvc-list
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tvc/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/tronscan/tron-tvc-list
- **Stars**: N/A
### Original Help Text
```text
tvc 5.0-3 (e975447-9fa85fb) - Torrent Variant Caller

Usage: tvc [options]

General options:
  -h,--help                                         print this help message and exit
  -v,--version                                      print version and exit
  -n,--num-threads                      INT         number of worker threads [2]
  -N,--num-variants-per-thread          INT         worker thread batch size [500]
     --parameters-file                  FILE        json file with algorithm control parameters [optional]

Inputs:
  -r,--reference                        FILE        reference fasta file [required]
  -b,--input-bam                        FILE        bam file with mapped reads [required]
  -g,--sample-name                      STRING      sample for which variants are called (In case of input BAM files with multiple samples) [optional if there is only one sample]
     --force-sample-name                STRING      force all read groups to have this sample name [off]
  -t,--target-file                      FILE        only process targets in this bed file [optional]
     --trim-ampliseq-primers            on/off      match reads to targets and trim the ends that reach outside them [off]
  -D,--downsample-to-coverage           INT         ?? [2000]
     --model-file                       FILE        HP recalibration model input file.
     --recal-model-hp-thres             INT         Lower threshold for HP recalibration.

Outputs:
  -O,--output-dir                       DIRECTORY   base directory for all output files [current dir]
  -o,--output-vcf                       FILE        vcf file with variant calling results [required]
     --suppress-reference-genotypes     on/off      write reference calls into the filtered variants vcf [on]
     --suppress-no-calls                on/off      write filtered variants into the filtered variants vcf [on]
     --suppress-nocall-genotypes        on/off      do not report a genotype for filtered variants [on]

Variant candidate generation (FreeBayes):
     --allow-snps                       on/off      allow generation of snp candidates [on]
     --allow-indels                     on/off      allow generation of indel candidates [on]
     --allow-mnps                       on/off      allow generation of mnp candidates [on]
     --allow-complex                    on/off      allow generation of block substitution candidates [off]
     --max-complex-gap                  INT         maximum number of reference alleles between two alternate alleles to allow merging of the alternate alleles [1]
  -m,--use-best-n-alleles               INT         maximum number of snp alleles [2]
  -M,--min-mapping-qv                   INT         do not use reads with mapping quality below this [4]
  -U,--read-snp-limit                   INT         do not use reads with number of snps above this [10]
  -z,--read-max-mismatch-fraction       FLOAT       do not use reads with fraction of mismatches above this [1.0]
     --gen-min-alt-allele-freq          FLOAT       minimum required alt allele frequency to generate a candidate [0.2]
     --gen-min-indel-alt-allele-freq    FLOAT       minimum required alt allele frequency to generate a homopolymer indel candidate [0.2]
     --gen-min-coverage                 INT         minimum required coverage to generate a candidate [6]

External variant candidates:
  -c,--input-vcf                        FILE        vcf.gz file (+.tbi) with additional candidate variant locations and alleles [optional]
     --process-input-positions-only     on/off      only generate candidates at locations from input-vcf [off]
     --use-input-allele-only            on/off      only consider provided alleles for locations in input-vcf [off]

Variant candidate scoring options:
     --min-delta-for-flow               FLOAT       minimum prediction delta for scoring flows [0.1]
     --max-flows-to-test                INT         maximum number of scoring flows [10]
     --outlier-probability              FLOAT       probability for outlier reads [0.01]
     --heavy-tailed                     INT         degrees of freedom in t-dist modeling signal residual heavy tail [3]
     --suppress-recalibration           on/off      Suppress homopolymer recalibration [on].
     --do-snp-realignment               on/off      Realign reads in the vicinity of candidate snp variants [on].
     --do-mnp-realignment               on/off      Realign reads in the vicinity of candidate mnp variants [do-snp-realignment].
     --realignment-threshold            FLOAT       Max. allowed fraction of reads where realignment causes an alignment change [1.0].

Advanced variant candidate scoring options:
     --use-sse-basecaller               on/off      Switch to use the vectorized version of the basecaller [on].
     --resolve-clipped-bases            on/off      If 'true', the basecaller is used to solve soft clipped bases [off].
     --prediction-precision             FLOAT       prior weight in bias estimator [30.0]
     --shift-likelihood-penalty         FLOAT       penalize log-likelihood for solutions involving large systematic bias [0.3]
     --minimum-sigma-prior              FLOAT       prior variance per data point, constant [0.085]
     --slope-sigma-prior                FLOAT       prior rate of increase of variance over minimum by signal [0.0084]
     --sigma-prior-weight               FLOAT       weight of prior estimate of variance compared to observations [1.0]
     --k-zero                           FLOAT       variance increase for adding systematic bias [3.0]
     --sse-relative-safety-level        FLOAT       dampen strand bias detection for SSE events for low coverage [0.025]
     --tune-sbias                       FLOAT       dampen strand bias detection for low coverage [0.01]
     --max-detail-level                 INT         number of evaluated frequencies for a given hypothesis, reduce for very high coverage, set to zero to disable this option [0]

Variant filtering:
  -k,--snp-min-coverage                 INT         filter out snps with total coverage below this [6]
  -C,--snp-min-cov-each-strand          INT         filter out snps with coverage on either strand below this [0]
  -B,--snp-min-variant-score            FLOAT       filter out snps with QUAL score below this [10.0]
  -s,--snp-strand-bias                  FLOAT       filter out snps with strand bias above this [0.95] given pval < snp-strand-bias-pval
     --snp-strand-bias-pval             FLOAT       filter out snps with pval below this [1.0] given strand bias > snp-strand-bias
  -A,--snp-min-allele-freq              FLOAT       minimum required alt allele frequency for non-reference snp calls [0.2]
     --mnp-min-coverage                 INT         filter out mnps with total coverage below this [snp-min-coverage]
     --mnp-min-cov-each-strand          INT         filter out mnps with coverage on either strand below this, [snp-min-cov-each-strand]
     --mnp-min-variant-score            FLOAT       filter out mnps with QUAL score below this [snp-min-variant-score]
     --mnp-strand-bias                  FLOAT       filter out mnps with strand bias above this [snp-strand-bias] given pval < mnp-strand-bias-pval
     --mnp-strand-bias-pval             FLOAT       filter out mnps with pval below this [snp-strand-bias-pval] given strand bias > mnp-strand-bias
     --mnp-min-allele-freq              FLOAT       minimum required alt allele frequency for non-reference mnp calls [snp-min-allele-freq]
     --indel-min-coverage               INT         filter out indels with total coverage below this [30]
     --indel-min-cov-each-strand        INT         filter out indels with coverage on either strand below this [1]
     --indel-min-variant-score          FLOAT       filter out indels with QUAL score below this [10.0]
  -S,--indel-strand-bias                FLOAT       filter out indels with strand bias above this [0.95] given pval < indel-strand-bias-pval
     --indel-strand-bias-pval           FLOAT       filter out indels with pval below this [1.0] given strand bias > indel-strand-bias
     --indel-min-allele-freq            FLOAT       minimum required alt allele frequency for non-reference indel call [0.2]
     --hotspot-min-coverage             INT         filter out hotspot variants with total coverage below this [6]
     --hotspot-min-cov-each-strand      INT         filter out hotspot variants with coverage on either strand below this [snp-min-cov-each-strand]
     --hotspot-min-variant-score        FLOAT       filter out hotspot variants with QUAL score below this [snp-min-variant-score]
     --hotspot-strand-bias              FLOAT       filter out hotspot variants with strand bias above this [0.95] given pval < hotspot-strand-bias-pval
     --hotspot-strand-bias-pval         FLOAT       filter out hotspot variants with pval below this [1.0] given strand bias > hotspot-strand-bias
  -H,--hotspot-min-allele-freq          FLOAT       minimum required alt allele frequency for non-reference hotspot variant call [0.2]
  -L,--hp-max-length                    INT         filter out indels in homopolymers above this [8]
  -e,--error-motifs                     FILE        table of systematic error motifs and their error rates [optional]
     --sse-prob-threshold               FLOAT       filter out variants in motifs with error rates above this [0.2]
     --min-ratio-reads-non-sse-strand   FLOAT       minimum required alt allele frequency for variants with error motifs on opposite strand [0.2]
  --indel-as-hpindel                    on/off      apply indel filters to non HP indels [off]

Position bias variant filtering:
     --use-position-bias                on/off      enable the position bias filter [off]
     --position-bias                    FLOAT       filter out variants with position bias relative to soft clip ends in reads > position-bias [0.75]
     --position-bias-pval               FLOAT       filter out if position bias above position-bias given pval < position-bias-pval [0.05]
     --position-bias-ref-fraction       FLOAT       skip position bias filter if (reference read count)/(reference + alt allele read count) <= to this [0.05]

Filters that depend on scoring across alleles:
     --data-quality-stringency          FLOAT       minimum mean log-likelihood delta per read [4.0]
     --read-rejection-threshold         FLOAT       filter variants where large numbers of reads are rejected as outliers [0.5]
     --filter-unusual-predictions       FLOAT       posterior log likelihood threshold for accepting bias estimate [0.3]
     --filter-deletion-predictions      FLOAT       check post-evaluation systematic bias in deletions; a high value like 100 effectively turns off this filter [100.0]
     --filter-insertion-predictions     FLOAT       check post-evaluation systematic bias in insertions; a high value like 100 effectively turns off this filter [100.0]

     --heal-snps                        on/off      suppress in/dels not participating in diploid variant genotypes if the genotype contains a SNP or MNP [on].

Debugging:
  -d,--debug                            INT         (0/1/2) display extra debug messages [0]
     --do-json-diagnostic               on/off      (devel) dump internal state to json file (uses much more time/memory/disk) [off]
     --postprocessed-bam                FILE        (devel) save tvc-processed reads to an (unsorted) BAM file [optional]
     --do-minimal-diagnostic            on/off      (devel) provide minimal read information for called variants [off]
     --override-limits                  on/off      (devel) disable limit-check on input parameters [off].
```

