cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools_header2
label: fqtools_header2
doc: "View FASTQ file secondary header data.\n\nTool homepage: https://github.com/alastair-droop/fqtools"
inputs:
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: The fastq file(s) to view.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_header2.out
