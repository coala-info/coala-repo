cwlVersion: v1.2
class: CommandLineTool
baseCommand: guide-counter
label: guide-counter_FASTQs
doc: "A tool for counting guide RNAs in FASTQ files.\n\nTool homepage: https://github.com/fulcrumgenomics/guide-counter"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run (e.g., count, analyze)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guide-counter:0.1.3--h503566f_4
stdout: guide-counter_FASTQs.out
