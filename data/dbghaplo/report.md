# dbghaplo CWL Generation Report

## dbghaplo

### Tool Description
Long-read haplotyping for diverse small sequences (e.g. viruses, genes).

### Metadata
- **Docker Image**: quay.io/biocontainers/dbghaplo:0.0.2--ha6fb395_1
- **Homepage**: https://github.com/bluenote-1577/dbghaplo
- **Package**: https://anaconda.org/channels/bioconda/packages/dbghaplo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbghaplo/overview
- **Total Downloads**: 887
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bluenote-1577/dbghaplo
- **Stars**: N/A
### Original Help Text
```text
Long-read haplotyping for diverse small sequences (e.g. viruses, genes).

Usage: dbghaplo [OPTIONS] --bam-file <BAM_FILE> --vcf-file <VCF_FILE> --reference-fasta <REFERENCE_FASTA>

Options:
  -t, --threads <NUM_THREADS>  Number of threads to use [default: 10]
      --trace                  Trace logging (VERY VERBOSE)
      --debug                  Debug logging
  -h, --help                   Print help
  -V, --version                Print version

PRESETS:
  -p, --preset <PRESET>  Presets for different technologies. More accurate technologies use more aggressive parameters [default: nanopore-r9] [possible values: old-long-reads, nanopore-r9, nanopore-r10, hi-fi]

INPUT:
  -b, --bam-file <BAM_FILE>
          Indexed bam file to phase
  -v, --vcf-file <VCF_FILE>
          VCF file with SNPs
  -r, --reference-fasta <REFERENCE_FASTA>
          Reference fasta file
  -S, --sequences-to-phase <SEQUENCES_TO_PHASE>
          Sequences to phase separated by commas (e.g. NC_001802.1:1-1000,NC_045512.2). See also --bed-file
      --bed-file <BED_FILE>
          BED file with >= 3 columns (contig, start, end). Only these regions will be phased; reads must cover 50% of the region to be considered

OUTPUT:
  -o, --output-dir <OUTPUT_DIR>  Output directory [default: dbghaplo_output]
  -O, --overwrite                Overwrite output directory if it exists
      --output-reads             Output haplotype-tagged reads
      --allele-output            Output nucleotide alleles instead of 0-1 (ref,alt) alleles
      --n-fraction <N_FRACTION>  > this fraction supporting the major allele to call a non-N base [default: 0.66]

OPTIONS:
      --dont-use-supp-aln
          Do not use supplementary alignments
      --mapq-cutoff <MAPQ_CUTOFF>
          Don't use primary mappings with < --mapq-cutoff [default: 5]
      --supp-mapq-cutoff <SUPP_MAPQ_CUTOFF>
          Don't use supp. mappings with < --supp-mapq-cutoff [default: 30]
      --supp-aln-dist-cutoff <SUPP_ALN_DIST_CUTOFF>
          Require supplementary alignments to be within this distance of the primary alignment [default: 5000]
      --snp-count-filter <SNP_COUNT_FILTER>
          Only phase contigs with > this # of SNPs [default: 1]
      --min-qual <MIN_QUAL>
          Minimum base quality to consider for fastq [default: 3]
      --max-frags <MAX_FRAGS>
          Maximum number of alignments per contig [default: 1000000000000]
      --no-realign
          No base realignment against SNPs

ALGORITHM:
  -k <K>
          Value of "k". Set automatically if not provided
      --min-abund <MIN_ABUND>
          Minimum abundance (in %) of a haplotype to be considered [default: 0.25]
      --min-cov <MIN_COV>
          Minimum coverage (depth) of a haplotype to be considered [default: 5]
      --resolution <RESOLUTION>
          Merge haplotypes with < this fractional difference. Value depends on preset
      --strand-bias-fdr <STRAND_BIAS_FDR>
          FDR for strand bias filtering [default: 0.005]
```

