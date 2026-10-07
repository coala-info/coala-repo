cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - fastq
  - digest
label: capcruncher_fastq_digest
doc: "Performs in silico digestion of one or a pair of fastq files.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: fastqs
    type:
      type: array
      items: File
    doc: "FASTQ file(s) to digest (one, or a pair for pe mode)"
    inputBinding:
      position: 1
  - id: restriction_enzyme
    type: string
    doc: "Restriction enzyme name or sequence to use for in silico digestion."
    inputBinding:
      position: 2
      prefix: -r
  - id: mode
    type: string
    doc: "Digestion mode. Combined (flashed) or non-combined (pe) read pairs."
    inputBinding:
      position: 2
      prefix: -m
  - id: output_file
    type: string
    default: out.fastq.gz
    doc: "Output file name"
    inputBinding:
      position: 2
      prefix: -o
  - id: minimum_slice_length
    type:
      - 'null'
      - int
    doc: "Minimum slice length"
    inputBinding:
      position: 2
      prefix: --minimum_slice_length
  - id: statistics
    type:
      - 'null'
      - string
    doc: "Output path for stats file"
    inputBinding:
      position: 2
      prefix: --statistics
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Name of sample e.g. DOX_treated_1. Required for correct statistics."
    inputBinding:
      position: 2
      prefix: --sample-name
outputs:
  - id: digested_fastq
    type: File
    doc: "Digested FASTQ file"
    outputBinding:
      glob: $(inputs.output_file)
  - id: statistics_file
    type:
      - 'null'
      - File
    doc: "Digestion statistics"
    outputBinding:
      glob: '$(inputs.statistics ? inputs.statistics : [])'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
