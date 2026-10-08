cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - stats
label: fanc_stats
doc: "Get statistics on the number of reads used at each step of a pipeline.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: output
    type: string
    doc: "Output file (.txt) to store statistics."
    inputBinding:
      position: 1
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of FASTQ files or folders containing FASTQ files."
    inputBinding:
      position: 20
      prefix: --fastq
  - id: pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of Pairs files or folders containing Pairs files ('.pairs ending')."
    inputBinding:
      position: 20
      prefix: --pairs
  - id: hic
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of Hic files or folders containing Hic files ('.hic ending')."
    inputBinding:
      position: 20
      prefix: --hic
outputs:
  - id: stats
    type: File
    doc: "Read statistics."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
