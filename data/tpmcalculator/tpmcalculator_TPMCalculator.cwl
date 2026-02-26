cwlVersion: v1.2
class: CommandLineTool
baseCommand: TPMCalculator
label: tpmcalculator_TPMCalculator
doc: "TPMCalculator calculates TPM values for genes and transcripts from BAM files
  and a GTF annotation.\n\nTool homepage: https://github.com/ncbi/TPMCalculator"
inputs:
  - id: bam_directory
    type:
      - 'null'
      - Directory
    doc: Directory with the BAM files
    inputBinding:
      position: 101
      prefix: -d
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file
    inputBinding:
      position: 101
      prefix: -b
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: Extended output. This will include transcript level TPM values.
    default: false
    inputBinding:
      position: 101
      prefix: -e
  - id: gene_key
    type:
      - 'null'
      - string
    doc: Gene key to use from GTF file
    default: gene_id
    inputBinding:
      position: 101
      prefix: -k
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: GTF file
    inputBinding:
      position: 101
      prefix: -g
  - id: min_intron_size
    type:
      - 'null'
      - int
    doc: Smaller size allowed for an intron created for genes. We recommend to 
      use the reads length
    default: 16
    inputBinding:
      position: 101
      prefix: -c
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ value to filter out reads. This value depends on the 
      aligner MAPQ value.
    default: 0
    inputBinding:
      position: 101
      prefix: -q
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between a reads and a feature.
    default: 8
    inputBinding:
      position: 101
      prefix: -o
  - id: print_all_features
    type:
      - 'null'
      - boolean
    doc: Print out all features with read counts equal to zero.
    default: false
    inputBinding:
      position: 101
      prefix: -a
  - id: print_info
    type:
      - 'null'
      - boolean
    doc: Print info
    inputBinding:
      position: 101
      prefix: -v
  - id: properly_paired_only
    type:
      - 'null'
      - boolean
    doc: Use only properly paired reads. Recommended for paired-end reads.
    default: false
    inputBinding:
      position: 101
      prefix: -p
  - id: transcript_key
    type:
      - 'null'
      - string
    doc: Transcript key to use from GTF file
    default: transcript_id
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tpmcalculator:0.0.6--h2bd4fab_0
stdout: tpmcalculator_TPMCalculator.out
