cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools_basetab
label: fqtools_basetab
doc: "Tabulate FASTQ base frequencies.\n\nTool homepage: https://github.com/alastair-droop/fqtools"
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
  - id: show_all_bases
    type:
      - 'null'
      - boolean
    doc: Show all valid base frequencies, even if zero.
    inputBinding:
      position: 102
      prefix: -a
  - id: sort_bases
    type:
      - 'null'
      - boolean
    doc: Sort returned base frequencies (otherwise alphabetical).
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_basetab.out
