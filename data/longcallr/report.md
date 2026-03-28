# longcallr CWL Generation Report

## longcallr_longcallR

### Tool Description
A Rust tool for SNP calling and haplotype phasing with long RNA-seq reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/longcallr:1.12.0--py313ha45639b_1
- **Homepage**: https://github.com/huangnengCSU/longcallR
- **Package**: https://anaconda.org/channels/bioconda/packages/longcallr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/longcallr/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-08-08
- **GitHub**: https://github.com/huangnengCSU/longcallR
- **Stars**: N/A
### Original Help Text
```text
A Rust tool for SNP calling and haplotype phasing with long RNA-seq reads.

Usage: longcallR [OPTIONS] --bam-path <BAM_PATH> --ref-path <REF_PATH> --output <OUTPUT> --preset <PRESET>

Options:
  -b, --bam-path <BAM_PATH>
          Input BAM file (must be sorted and indexed)
  -f, --ref-path <REF_PATH>
          Reference FASTA file
  -a, --annotation <ANNOTATION>
          Annotation file, GFF3 or GTF format
  -o, --output <OUTPUT>
          Output file prefix
  -r, --region <REGION>
          Region to be processed. Format: chr:start-end, left-closed, right-open
  -x, --contigs [<CONTIGS>...]
          Contigs to be processed. Example: -x chr1 chr2 chr3
  -v, --input-vcf <INPUT_VCF>
          Input vcf file as Candidate SNPs
  -t, --threads <THREADS>
          Number of threads [Default: 1]
  -p, --preset <PRESET>
          Preset for sequencing platform, choices: hifi-isoseq, hifi-masseq, ont-cdna, ont-drna [possible values: hifi-isoseq, hifi-masseq, ont-cdna, ont-drna]
      --min-allele-freq <MIN_ALLELE_FREQ>
          Minimum allele frequency for high allele fraction candidate SNPs [Default: 0.20]
      --min-allele-freq-include-intron <MIN_ALLELE_FREQ_INCLUDE_INTRON>
          Minimum allele frequency for high allele fraction candidate SNPs include intron [Default: 0.0]
      --low-allele-frac-cutoff <LOW_ALLELE_FRAC_CUTOFF>
          Minimum allele frequency for low allele fraction candidate SNPs [Default: 0.05]
      --low-allele-cnt-cutoff <LOW_ALLELE_CNT_CUTOFF>
          Minimum allele count for low allele fraction candidate SNPs [Default: 10]
      --min-read-length <MIN_READ_LENGTH>
          Minimum length for reads [Default: 500]
      --min-mapq <MIN_MAPQ>
          Minimum mapping quality for reads [Default: 20]
      --min-baseq <MIN_BASEQ>
          Minimim base quality for allele calling [Default: 10]
      --divergence <DIVERGENCE>
          Max sequence divergence for valid reads [Default: 0.05]
      --min-depth <MIN_DEPTH>
          Minimum depth for a candidate SNP [Default: 10]
      --max-depth <MAX_DEPTH>
          Maximum depth for a candidate SNP [Default: 50000]
      --strand-bias <STRAND_BIAS>
          Whether to use strand bias to filter SNPs [Default: false] [possible values: true, false]
      --min-qual <MIN_QUAL>
          Minimum QUAL for candidate SNPs [Default: 2]
      --distance-to-read-end <DISTANCE_TO_READ_END>
          Ignore bases within distance to read end [Default: 20]
      --polya-tail-length <POLYA_TAIL_LENGTH>
          PolyA tail length threshold for filtering [Default: 5]
      --dense-win-size <DENSE_WIN_SIZE>
          Window size used to identify dense regions of candidate SNPs [Default: 500]
      --min-dense-cnt <MIN_DENSE_CNT>
          Minimum number of candidate SNPs within the dense window to consider the region as dense [Default: 5]
      --min-linkers <MIN_LINKERS>
          Minimum number of related candidate heterozygous SNPs required to perform phasing in a region [Default: 1]
      --max-enum-snps <MAX_ENUM_SNPS>
          Maximum number of SNPs for enumerate haplotypes [Default: 10]
      --min-phase-score <MIN_PHASE_SCORE>
          Minimum phase score to filter candidate SNPs [Default: 8.0]
      --min-read-assignment-diff <MIN_READ_ASSIGNMENT_DIFF>
          Minimum absolute difference between haplotype assignment probabilities required for a read to be confidently assigned [Default: 0.15]
      --truncation
          When set, apply truncation of high coverage regions
      --truncation-coverage <TRUNCATION_COVERAGE>
          Read number threshold for region truncation [Default: 200000]
      --downsample
          When set, allow downsampling of high coverage regions
      --downsample-depth <DOWNSAMPLE_DEPTH>
          Downsample depth [Default: 10000]
      --exon-only
          When set, only call SNPs in exons
      --no-bam-output
          When set, do not output phased bam file
      --get-blocks
          When set, show all regions to be processed
  -h, --help
          Print help
  -V, --version
          Print version
```


## longcallr_longcallR-ase

### Tool Description
Performs allele-specific expression analysis using LongcallR.

### Metadata
- **Docker Image**: quay.io/biocontainers/longcallr:1.12.0--py313ha45639b_1
- **Homepage**: https://github.com/huangnengCSU/longcallR
- **Package**: https://anaconda.org/channels/bioconda/packages/longcallr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: longcallR-ase [-h] -b BAM [--vcf1 VCF1] [--vcf2 VCF2] [--vcf3 VCF3]
                     -a ANNOTATION [-d OVERDISPERSION] -o OUTPUT [-t THREADS]
                     [--gene_types GENE_TYPES [GENE_TYPES ...]]
                     [--min_support MIN_SUPPORT]

options:
  -h, --help            show this help message and exit
  -b, --bam BAM         phased BAM file
  --vcf1 VCF1           LongcallR phased vcf file
  --vcf2 VCF2           Whole genome haplotype phased DNA vcf file
  --vcf3 VCF3           DNA vcf file
  -a, --annotation ANNOTATION
                        Annotation file
  -d, --overdispersion OVERDISPERSION
                        Overdispersion parameter
  -o, --output OUTPUT   prefix of output file
  -t, --threads THREADS
                        Number of threads
  --gene_types GENE_TYPES [GENE_TYPES ...]
                        Gene types to be analyzed. Default is
                        ["protein_coding", "lncRNA"]
  --min_support MIN_SUPPORT
                        Minimum support reads for counting event (default: 10)
```


## longcallr_longcallR-asj

### Tool Description
longcallR-asj

### Metadata
- **Docker Image**: quay.io/biocontainers/longcallr:1.12.0--py313ha45639b_1
- **Homepage**: https://github.com/huangnengCSU/longcallR
- **Package**: https://anaconda.org/channels/bioconda/packages/longcallr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: longcallR-asj [-h] -a ANNOTATION_FILE -b BAM_FILE [--dna_vcf DNA_VCF]
                     [--rna_vcf RNA_VCF] [--min_junctions MIN_JUNCTIONS]
                     [--cluster_with_exons] -f REFERENCE -o OUTPUT_PREFIX
                     [-t THREADS] [-g GENE_TYPES [GENE_TYPES ...]]
                     [-m MIN_SUP] [--no_gtag]

options:
  -h, --help            show this help message and exit
  -a, --annotation_file ANNOTATION_FILE
                        Annotation file in GFF3 or GTF format
  -b, --bam_file BAM_FILE
                        BAM file
  --dna_vcf DNA_VCF     DNA VCF file
  --rna_vcf RNA_VCF     RNA VCF file
  --min_junctions MIN_JUNCTIONS
                        Minimum number of junctions to be considered
  --cluster_with_exons  Cluster junctions with exons
  -f, --reference REFERENCE
                        Reference genome file
  -o, --output_prefix OUTPUT_PREFIX
                        prefix of output differential splicing file and
                        allele-specific junctions file
  -t, --threads THREADS
                        Number of threads
  -g, --gene_types GENE_TYPES [GENE_TYPES ...]
                        Gene types to be analyzed. Default is
                        ["protein_coding", "lncRNA"]
  -m, --min_sup MIN_SUP
                        Minimum support of phased reads for exon or junction
  --no_gtag             Do not filter read junction with GT-AG signal
```


## Metadata
- **Skill**: generated
