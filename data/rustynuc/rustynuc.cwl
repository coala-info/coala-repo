cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustynuc
label: rustynuc
doc: "Investigate alignments for possible 8-oxoG damage\n\nTool homepage: https://github.com/bjohnnyd/rustynuc"
inputs:
  - id: bam_file
    type: File
    doc: Alignments to investigate for possible 8-oxoG damage
    inputBinding:
      position: 1
  - id: af_both_pass
    type:
      - 'null'
      - float
    doc: AF on both the ff and fr at which point a call in the VCF will excluded
      from the OxoAF filter
    inputBinding:
      position: 102
      prefix: --af-both-pass
  - id: af_either_pass
    type:
      - 'null'
      - float
    doc: AF above this cutoff in EITHER read orientation will be excluded from 
      OxoAF filter
    inputBinding:
      position: 102
      prefix: --af-either-pass
  - id: alpha
    type:
      - 'null'
      - float
    doc: FDR threshold
    inputBinding:
      position: 102
      prefix: --alpha
  - id: bcf_vcf_file
    type:
      - 'null'
      - File
    doc: BCF/VCF for variants called on the supplied alignment file
    inputBinding:
      position: 102
      prefix: --bcf
  - id: bed_file
    type:
      - 'null'
      - File
    doc: A BED file to restrict analysis to specific regions
    inputBinding:
      position: 102
      prefix: --bed
  - id: fishers_sig
    type:
      - 'null'
      - float
    doc: Significance threshold for Fisher's test
    inputBinding:
      position: 102
      prefix: --fishers-sig
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum pileup depth to use
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider
    inputBinding:
      position: 102
      prefix: --quality
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of aligned reads in ff or fr orientation for a position 
      to be considered
    inputBinding:
      position: 102
      prefix: --min-reads
  - id: no_overlapping_mates
    type:
      - 'null'
      - boolean
    doc: Do not count overlapping mates when calculating total depth
    inputBinding:
      position: 102
      prefix: --no-overlapping
  - id: no_qval
    type:
      - 'null'
      - boolean
    doc: Skip calculating qvalue
    inputBinding:
      position: 102
      prefix: --no-qval
  - id: process_all_positions
    type:
      - 'null'
      - boolean
    doc: Whether to process and print information for every position in the BAM 
      file
    inputBinding:
      position: 102
      prefix: --all
  - id: pseudocount
    type:
      - 'null'
      - boolean
    doc: Whether to use pseudocounts (increments all counts by 1) when 
      calculating statistics
    inputBinding:
      position: 102
      prefix: --pseudocount
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Optional reference which will be used to determine sequence context and
      type of change
    inputBinding:
      position: 102
      prefix: --reference
  - id: skip_fishers
    type:
      - 'null'
      - boolean
    doc: Skip applying Fisher's Exact Filter on VCF
    inputBinding:
      position: 102
      prefix: --skip-fishers
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Determines verbosity of the processing, can be specified multiple times
      -vvv
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: with_track_line
    type:
      - 'null'
      - boolean
    doc: Include track line (for correct visualization with IGV)
    inputBinding:
      position: 102
      prefix: --with-track-line
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustynuc:0.3.1--h577a1d6_3
stdout: rustynuc.out
