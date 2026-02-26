cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools_qualtab
label: fqtools_qualtab
doc: "Tabulate FASTQ quality character frequencies.\n\nTool homepage: https://github.com/alastair-droop/fqtools"
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
  - id: quality_type
    type:
      - 'null'
      - string
    doc: The output depends on the specified quality type (-q). If no quality 
      type is specified, then the ASCII characters in the quality strings are 
      tabulated for all possible characters (33-127). If a quality type is 
      specified, the quality score and approximate probability of error are 
      returned for only the valid characters.
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_qualtab.out
