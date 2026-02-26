cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools_lengthtab
label: fqtools_lengthtab
doc: "Tabulate FASTQ read lengths.\n\nTool homepage: https://github.com/alastair-droop/fqtools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The fastq file(s) to count. If no input file is specified, input will 
      be read from stdin.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_lengthtab.out
