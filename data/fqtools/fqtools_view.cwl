cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools_view
label: fqtools_view
doc: "View FASTQ files.\n\nTool homepage: https://github.com/alastair-droop/fqtools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The fastq file(s) to view.
    inputBinding:
      position: 1
  - id: output_stem
    type:
      - 'null'
      - string
    doc: Output file stem (default "output%").
    inputBinding:
      position: 102
      prefix: -o
  - id: preserve_secondary_headers
    type:
      - 'null'
      - boolean
    doc: Preserve secondary headers (if present).
    inputBinding:
      position: 102
      prefix: -k
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_view.out
