# strdust CWL Generation Report

## strdust_STRdust

### Tool Description
Tool to genotype STRs from long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/strdust:0.16.0--hcdda2d0_0
- **Homepage**: https://github.com/wdecoster/STRdust
- **Package**: https://anaconda.org/channels/bioconda/packages/strdust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strdust/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/wdecoster/STRdust
- **Stars**: N/A
### Original Help Text
```text
Tool to genotype STRs from long reads

Usage: STRdust [OPTIONS] <FASTA> <BAM>

Arguments:
  <FASTA>  reference genome
  <BAM>    BAM or CRAM file to call STRs in

Options:
  -r, --region <REGION>
          Region string to genotype expansion in (format: chr:start-end)
  -R, --region-file <REGION_FILE>
          Bed file with region(s) to genotype expansion(s) in
      --pathogenic
          Genotype the pathogenic STRs from STRchive
  -m, --minlen <MINLEN>
          minimal length of insertion/deletion operation [default: 1]
  -s, --support <SUPPORT>
          minimal number of supporting reads per haplotype [default: 3]
  -t, --threads <THREADS>
          Number of parallel threads to use [default: 1]
      --sample <SAMPLE>
          Sample name to use in VCF header, if not provided, the bam file name is used
      --somatic
          Print information on somatic variability
      --unphased
          Reads are not phased
      --find-outliers
          Identify poorly supported outlier expansions (only with --unphased)
      --min-haplotype-fraction <MIN_HAPLOTYPE_FRACTION>
          Minimum fraction of reads required for a cluster to be considered a haplotype (only with --unphased) [default: 0.1]
      --haploid <HAPLOID>
          comma-separated list of haploid (sex) chromosomes
      --debug
          Debug mode
      --sorted
          Sort output by chrom, start and end
      --consensus-reads <CONSENSUS_READS>
          Max number of reads to use to generate consensus alt sequence [default: 20]
      --max-number-reads <MAX_NUMBER_READS>
          Max number of reads to extract per locus from the bam file for genotyping (use -1 for all reads) [default: 60]
      --max-locus <MAX_LOCUS>
          Maximum locus size to consider (intervals larger than this will be filtered out)
      --alignment-all
          Always use full alignment (disable fast reference check via CIGAR)
  -h, --help
          Print help
  -V, --version
          Print version
```

