cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr
label: superstr
doc: "Rapid STR characterisation in NGS data: finds repeat-containing reads in FASTQ, BAM or CRAM files.\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input files (or names of pipes in stream mode); BAM and CRAM files need their index
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 101
  - id: mode
    type:
      - 'null'
      - string
    doc: type of input data (fastq or bam; use bam for CRAM too)
    inputBinding:
      position: 1
      prefix: --mode=
      separate: false
  - id: output_dir
    type: string
    doc: output directory (created in the working directory); per_read.txt.gz is written into it
    inputBinding:
      position: 1
      prefix: -o
      valueFrom: $(self + '/')
  - id: stream
    type:
      - 'null'
      - boolean
    doc: run on named streams, not files (see manual for instructions)
    inputBinding:
      position: 1
      prefix: --stream
  - id: threshold
    type:
      - 'null'
      - float
    doc: compression threshold for processing strings
    inputBinding:
      position: 1
      prefix: --threshold=
      separate: false
  - id: retain
    type:
      - 'null'
      - int
    doc: write retained reads
    inputBinding:
      position: 1
      prefix: -r
outputs:
  - id: per_read
    type: File
    doc: One line per repeat-containing read (per_read.txt.gz)
    outputBinding:
      glob: $(inputs.output_dir)/per_read.txt.gz
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
