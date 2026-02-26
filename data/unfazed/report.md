# unfazed CWL Generation Report

## unfazed

### Tool Description
Identify de novo mutations (DNMs) in offspring using parental and offspring genotype and read data.

### Metadata
- **Docker Image**: quay.io/biocontainers/unfazed:1.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/jbelyeu/unfazed
- **Package**: https://anaconda.org/channels/bioconda/packages/unfazed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unfazed/overview
- **Total Downloads**: 16.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jbelyeu/unfazed
- **Stars**: N/A
### Original Help Text
```text
usage: unfazed [-h] [-v] -d DNMS -s SITES -p PED [-b BAM_DIR]
               [--bam-pairs [BAM_PAIRS [BAM_PAIRS ...]]] [-t THREADS]
               [-o {vcf,bed}] [--include-ambiguous] [--verbose]
               [--outfile OUTFILE] [-r REFERENCE] -g {37,38,na}
               [--no-extended] [--multiread-proc-min MULTIREAD_PROC_MIN] [-q]
               [--min-gt-qual MIN_GT_QUAL] [--min-depth MIN_DEPTH]
               [--ab-homref AB_HOMREF] [--ab-homalt AB_HOMALT]
               [--ab-het AB_HET] [--evidence-min-ratio EVIDENCE_MIN_RATIO]
               [--search-dist SEARCH_DIST]
               [--insert-size-max-sample INSERT_SIZE_MAX_SAMPLE]
               [--min-map-qual MIN_MAP_QUAL] [--stdevs STDEVS]
               [--readlen READLEN] [--split-error-margin SPLIT_ERROR_MARGIN]
               [--max-reads MAX_READS]

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         Installed version (1.0.2)
  -d DNMS, --dnms DNMS  valid VCF OR BED file of the DNMs of interest> If BED,
                        must contain chrom, start, end, kid_id, var_type
                        columns (default: None)
  -s SITES, --sites SITES
                        sorted/bgzipped/indexed VCF/BCF file of SNVs to
                        identify informative sites. Must contain each kid and
                        both parents (default: None)
  -p PED, --ped PED     ped file including the kid and both parent IDs
                        (default: None)
  -b BAM_DIR, --bam-dir BAM_DIR
                        directory where bam/cram files (named {sample_id}.bam
                        or {sample_id}.cram) are stored for offspring. If not
                        included, --bam-pairs must be set (default: None)
  --bam-pairs [BAM_PAIRS [BAM_PAIRS ...]]
                        space-delimited list of pairs in the format
                        {sample_id}:{bam_path} where {sample_id} matches an
                        offspring id from the dnm file. Can be used with
                        --bam-dir arg, must be used in its absence (default:
                        None)
  -t THREADS, --threads THREADS
                        number of threads to use (default: 2)
  -o {vcf,bed}, --output-type {vcf,bed}
                        choose output type. If --dnms is not a VCF/BCF, output
                        must be to BED format. Defaults to match --dnms input
                        file (default: None)
  --include-ambiguous   include ambiguous phasing results (default: False)
  --verbose             print verbose output including sites and reads used
                        for phasing. Only applies to BED output (default:
                        False)
  --outfile OUTFILE     name for output file. Defaults to stdout (default:
                        /dev/stdout)
  -r REFERENCE, --reference REFERENCE
                        reference fasta file (required for crams) (default:
                        None)
  -g {37,38,na}, --build {37,38,na}
                        human genome build, used to determine sex chromosome
                        pseudoautosomal regions. If `na` option is chosen, sex
                        chromosomes will not be auto-phased. HG19/GRCh37
                        interchangeable (default: None)
  --no-extended         do not perform extended read-based phasing (default
                        True) (default: False)
  --multiread-proc-min MULTIREAD_PROC_MIN
                        min number of variants required to perform multiple
                        parallel reads of the sites file (default: 1000)
  -q, --quiet           no logging of variant processing data (default: False)
  --min-gt-qual MIN_GT_QUAL
                        min genotype and base quality for informative sites
                        (default: 20)
  --min-depth MIN_DEPTH
                        min coverage for informative sites (default: 10)
  --ab-homref AB_HOMREF
                        allele balance range for homozygous reference
                        informative sites (default: 0.0:0.2)
  --ab-homalt AB_HOMALT
                        allele balance range for homozygous alternate
                        informative sites (default: 0.8:1.0)
  --ab-het AB_HET       allele balance range for heterozygous informative
                        sites (default: 0.2:0.8)
  --evidence-min-ratio EVIDENCE_MIN_RATIO
                        minimum ratio of evidence for a parent to provide an
                        unambiguous call. Default 10:1 (default: 10)
  --search-dist SEARCH_DIST
                        maximum search distance from variant for informative
                        sites (in bases) (default: 5000)
  --insert-size-max-sample INSERT_SIZE_MAX_SAMPLE
                        maximum number of read inserts to sample in order to
                        estimate concordant read insert size (default:
                        1000000)
  --min-map-qual MIN_MAP_QUAL
                        minimum map quality for reads (default: 1)
  --stdevs STDEVS       number of standard deviations from the mean insert
                        length to define a discordant read (default: 3)
  --readlen READLEN     expected length of input reads (default: 151)
  --split-error-margin SPLIT_ERROR_MARGIN
                        margin of error for the location of split read
                        clipping in bases (default: 5)
  --max-reads MAX_READS
                        maximum number of reads to collect for phasing a
                        single variant (default: 100)
```

