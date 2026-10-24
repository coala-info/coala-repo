cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqToFa
label: ucsc-fastqtofa
doc: "Convert from fastq to fasta format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output FASTA file
    inputBinding:
      position: 2
  - id: name_verify
    type:
      - 'null'
      - string
    doc: For multi-line fastq files, this string must match somewhere in the sequence names in order to correctly identify the next sequence block
    inputBinding:
      position: 101
      prefix: -nameVerify=
      separate: false
  - id: qual_name
    type:
      - 'null'
      - string
    doc: Output quality scores to this file (default quality scores are ignored)
    inputBinding:
      position: 101
      prefix: -qual=
      separate: false
  - id: qual_sizes_name
    type:
      - 'null'
      - string
    doc: Write a sizes file for the quality scores
    inputBinding:
      position: 101
      prefix: -qualSizes=
      separate: false
  - id: no_errors
    type:
      - 'null'
      - boolean
    doc: Warn only on problems, do not error out
    inputBinding:
      position: 101
      prefix: -noErrors
  - id: solexa
    type:
      - 'null'
      - boolean
    doc: Use Solexa/Illumina quality score algorithm (instead of Phred quality)
    inputBinding:
      position: 101
      prefix: -solexa
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set warning level to get some stats output during processing (2) or see warnings (3)
    inputBinding:
      position: 101
      prefix: -verbose=
      separate: false
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_name)
  - id: output_qual
    type:
      - 'null'
      - File
    doc: Quality scores file
    outputBinding:
      glob: $(inputs.qual_name)
  - id: output_qual_sizes
    type:
      - 'null'
      - File
    doc: Sizes file for the quality scores
    outputBinding:
      glob: $(inputs.qual_sizes_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fastqtofa:482--h0b57e2e_0
