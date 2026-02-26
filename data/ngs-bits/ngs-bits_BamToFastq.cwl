cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamToFastq
label: ngs-bits_BamToFastq
doc: "Converts a coordinate-sorted BAM file to FASTQ files.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Output FASTQ compression level from 1 (fastest) to 9 (best 
      compression).
    default: '1'
    inputBinding:
      position: 101
      prefix: -compression_level
  - id: extend_reads
    type:
      - 'null'
      - int
    doc: Extend all reads to the given length. Base 'N' and base qualiy '2' are 
      used for extension.
    default: '0'
    inputBinding:
      position: 101
      prefix: -extend
  - id: fix_duplicates
    type:
      - 'null'
      - boolean
    doc: 'Keep only one read pair if several have the same name (note: needs much
      memory as read names are kept in memory).'
    default: 'false'
    inputBinding:
      position: 101
      prefix: -fix
  - id: input_file
    type: File
    doc: Input BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -in
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome for CRAM support (mandatory if CRAM is used).
    default: ''
    inputBinding:
      position: 101
      prefix: -ref
  - id: region
    type:
      - 'null'
      - string
    doc: 'Export only reads in the given region. Format: chr:start-end.'
    default: ''
    inputBinding:
      position: 101
      prefix: -reg
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Does not export reads marked as duplicates in SAM flags into the FASTQ 
      file.
    default: 'false'
    inputBinding:
      position: 101
      prefix: -remove_duplicates
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: write_buffer_size
    type:
      - 'null'
      - int
    doc: Output write buffer size (number of FASTQ entry pairs).
    default: '100'
    inputBinding:
      position: 101
      prefix: -write_buffer_size
outputs:
  - id: output_read1
    type: File
    doc: Read 1 output FASTQ.GZ file.
    outputBinding:
      glob: $(inputs.output_read1)
  - id: output_read2
    type:
      - 'null'
      - File
    doc: Read 2 output FASTQ.GZ file (required for pair-end samples).
    outputBinding:
      glob: $(inputs.output_read2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
