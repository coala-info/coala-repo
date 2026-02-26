cwlVersion: v1.2
class: CommandLineTool
baseCommand: phase
label: longphase_phase
doc: "Phases genomic reads using SNP and optionally SV information.\n\nTool homepage:
  https://github.com/twolinin/longphase"
inputs:
  - id: reads_file
    type: File
    doc: Input reads file (e.g., FASTQ)
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 102
      prefix: --bam-file
  - id: base_quality
    type:
      - 'null'
      - int
    doc: Change edge's weight to --edgeWeight if base quality is lower than the 
      threshold
    default: 12
    inputBinding:
      position: 102
      prefix: --baseQuality
  - id: connect_adjacent
    type:
      - 'null'
      - int
    doc: Connect adjacent N SNPs
    default: 35
    inputBinding:
      position: 102
      prefix: --connectAdjacent
  - id: distance
    type:
      - 'null'
      - int
    doc: Phase two variants if distance is less than threshold
    default: 300000
    inputBinding:
      position: 102
      prefix: --distance
  - id: dot
    type:
      - 'null'
      - boolean
    doc: Generate dot file for each contig/chromosome
    inputBinding:
      position: 102
      prefix: --dot
  - id: edge_threshold
    type:
      - 'null'
      - float
    doc: Give up SNP-SNP phasing pair if the number of reads of the two 
      combinations are similar
    default: 0.7
    inputBinding:
      position: 102
      prefix: --edgeThreshold
  - id: edge_weight
    type:
      - 'null'
      - float
    doc: If one of the bases connected by the edge has a quality lower than 
      --baseQuality, its weight is reduced from the normal 1
    default: 0.1
    inputBinding:
      position: 102
      prefix: --edgeWeight
  - id: indel_quality
    type:
      - 'null'
      - int
    doc: Filter indels with QUAL less than threshold (only effective when 
      --indels is enabled)
    default: 0
    inputBinding:
      position: 102
      prefix: --indelQuality
  - id: indels
    type:
      - 'null'
      - boolean
    doc: Phase small indels
    default: false
    inputBinding:
      position: 102
      prefix: --indels
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: Filter alignment if mapping quality is lower than threshold
    default: 1
    inputBinding:
      position: 102
      prefix: --mappingQuality
  - id: mismatch_rate
    type:
      - 'null'
      - float
    doc: Mark reads as false if mismatch rate of them are higher than threshold
    default: 3
    inputBinding:
      position: 102
      prefix: --mismatchRate
  - id: mod_file
    type:
      - 'null'
      - File
    doc: Input modified VCF file (produced by longphase modcall)
    inputBinding:
      position: 102
      prefix: --mod-file
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Use Oxford Nanopore genomic reads
    inputBinding:
      position: 102
      prefix: --ont
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Prefix of phasing result
    default: result
    inputBinding:
      position: 102
      prefix: --out-prefix
  - id: overlap_threshold
    type:
      - 'null'
      - float
    doc: Filter different alignments of the same read if there is overlap
    default: 0.2
    inputBinding:
      position: 102
      prefix: --overlapThreshold
  - id: pb
    type:
      - 'null'
      - boolean
    doc: Use PacBio HiFi/CCS genomic reads
    inputBinding:
      position: 102
      prefix: --pb
  - id: read_confidence
    type:
      - 'null'
      - float
    doc: The confidence of a read being assigned to any haplotype
    default: 0.65
    inputBinding:
      position: 102
      prefix: --readConfidence
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 102
      prefix: --reference
  - id: snp_confidence
    type:
      - 'null'
      - float
    doc: The confidence of assigning two alleles of a SNP to different 
      haplotypes
    default: 0.75
    inputBinding:
      position: 102
      prefix: --snpConfidence
  - id: snp_file
    type: File
    doc: Input SNP VCF file
    inputBinding:
      position: 102
      prefix: --snp-file
  - id: sv_file
    type:
      - 'null'
      - File
    doc: Input SV VCF file
    inputBinding:
      position: 102
      prefix: --sv-file
  - id: sv_threshold
    type:
      - 'null'
      - float
    doc: Relative difference threshold for read to support a SV
    default: 0.1
    inputBinding:
      position: 102
      prefix: --sv-threshold
  - id: sv_window
    type:
      - 'null'
      - int
    doc: Window size for evaluating surrounding CIGAR operations
    default: 20
    inputBinding:
      position: 102
      prefix: --sv-window
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longphase:2.0.1--hfc4162c_0
stdout: longphase_phase.out
