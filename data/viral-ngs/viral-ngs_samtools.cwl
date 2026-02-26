cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: viral-ngs_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: command
    type: string
    doc: samtools command
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: command specific options
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_samtools.out
