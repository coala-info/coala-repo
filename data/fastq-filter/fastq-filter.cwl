cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-filter
label: fastq-filter
doc: "A tool for filtering FASTQ files.\n\nTool homepage: https://github.com/LUMC/fastq-filter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-filter:0.3.0--py39hff71179_2
stdout: fastq-filter.out
