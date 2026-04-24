cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr_longcallR
label: longcallr_longcallR
doc: "A Rust tool for SNP calling and haplotype phasing with long RNA-seq reads.\n\
  \nTool homepage: https://github.com/huangnengCSU/longcallR"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: Annotation file, GFF3 or GTF format
    inputBinding:
      position: 101
      prefix: --annotation
  - id: bam_path
    type: File
    doc: Input BAM file (must be sorted and indexed)
    inputBinding:
      position: 101
      prefix: --bam-path
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Contigs to be processed. Example: -x chr1 chr2 chr3'
    inputBinding:
      position: 101
      prefix: --contigs
  - id: dense_win_size
    type:
      - 'null'
      - int
    doc: Window size used to identify dense regions of candidate SNPs
    inputBinding:
      position: 101
      prefix: --dense-win-size
  - id: distance_to_read_end
    type:
      - 'null'
      - int
    doc: Ignore bases within distance to read end
    inputBinding:
      position: 101
      prefix: --distance-to-read-end
  - id: divergence
    type:
      - 'null'
      - float
    doc: Max sequence divergence for valid reads
    inputBinding:
      position: 101
      prefix: --divergence
  - id: downsample
    type:
      - 'null'
      - boolean
    doc: When set, allow downsampling of high coverage regions
    inputBinding:
      position: 101
      prefix: --downsample
  - id: downsample_depth
    type:
      - 'null'
      - int
    doc: Downsample depth
    inputBinding:
      position: 101
      prefix: --downsample-depth
  - id: exon_only
    type:
      - 'null'
      - boolean
    doc: When set, only call SNPs in exons
    inputBinding:
      position: 101
      prefix: --exon-only
  - id: get_blocks
    type:
      - 'null'
      - boolean
    doc: When set, show all regions to be processed
    inputBinding:
      position: 101
      prefix: --get-blocks
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: Input vcf file as Candidate SNPs
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: low_allele_cnt_cutoff
    type:
      - 'null'
      - int
    doc: Minimum allele count for low allele fraction candidate SNPs
    inputBinding:
      position: 101
      prefix: --low-allele-cnt-cutoff
  - id: low_allele_frac_cutoff
    type:
      - 'null'
      - float
    doc: Minimum allele frequency for low allele fraction candidate SNPs
    inputBinding:
      position: 101
      prefix: --low-allele-frac-cutoff
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth for a candidate SNP
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: max_enum_snps
    type:
      - 'null'
      - int
    doc: Maximum number of SNPs for enumerate haplotypes
    inputBinding:
      position: 101
      prefix: --max-enum-snps
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency for high allele fraction candidate SNPs
    inputBinding:
      position: 101
      prefix: --min-allele-freq
  - id: min_allele_freq_include_intron
    type:
      - 'null'
      - float
    doc: Minimum allele frequency for high allele fraction candidate SNPs 
      include intron
    inputBinding:
      position: 101
      prefix: --min-allele-freq-include-intron
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Minimim base quality for allele calling
    inputBinding:
      position: 101
      prefix: --min-baseq
  - id: min_dense_cnt
    type:
      - 'null'
      - int
    doc: Minimum number of candidate SNPs within the dense window to consider 
      the region as dense
    inputBinding:
      position: 101
      prefix: --min-dense-cnt
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth for a candidate SNP
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_linkers
    type:
      - 'null'
      - int
    doc: Minimum number of related candidate heterozygous SNPs required to 
      perform phasing in a region
    inputBinding:
      position: 101
      prefix: --min-linkers
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for reads
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_phase_score
    type:
      - 'null'
      - float
    doc: Minimum phase score to filter candidate SNPs
    inputBinding:
      position: 101
      prefix: --min-phase-score
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum QUAL for candidate SNPs
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: min_read_assignment_diff
    type:
      - 'null'
      - float
    doc: Minimum absolute difference between haplotype assignment probabilities 
      required for a read to be confidently assigned
    inputBinding:
      position: 101
      prefix: --min-read-assignment-diff
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum length for reads
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: no_bam_output
    type:
      - 'null'
      - boolean
    doc: When set, do not output phased bam file
    inputBinding:
      position: 101
      prefix: --no-bam-output
  - id: output
    type: string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: polya_tail_length
    type:
      - 'null'
      - int
    doc: PolyA tail length threshold for filtering
    inputBinding:
      position: 101
      prefix: --polya-tail-length
  - id: preset
    type: string
    doc: 'Preset for sequencing platform, choices: hifi-isoseq, hifi-masseq, ont-cdna,
      ont-drna'
    inputBinding:
      position: 101
      prefix: --preset
  - id: ref_path
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --ref-path
  - id: region
    type:
      - 'null'
      - string
    doc: 'Region to be processed. Format: chr:start-end, left-closed, right-open'
    inputBinding:
      position: 101
      prefix: --region
  - id: strand_bias
    type:
      - 'null'
      - boolean
    doc: Whether to use strand bias to filter SNPs
    inputBinding:
      position: 101
      prefix: --strand-bias
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: truncation
    type:
      - 'null'
      - boolean
    doc: When set, apply truncation of high coverage regions
    inputBinding:
      position: 101
      prefix: --truncation
  - id: truncation_coverage
    type:
      - 'null'
      - int
    doc: Read number threshold for region truncation
    inputBinding:
      position: 101
      prefix: --truncation-coverage
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py313ha45639b_1
stdout: longcallr_longcallR.out
