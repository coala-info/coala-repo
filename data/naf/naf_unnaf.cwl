cwlVersion: v1.2
class: CommandLineTool
baseCommand: unnaf
label: naf_unnaf
doc: "Decompress Nucleotide Archival Format (NAF) files. (Note: The provided text
  contains container runtime error messages rather than the tool's help output; arguments
  are derived from standard tool usage).\n\nTool homepage: https://github.com/KirillKryukov/naf"
inputs:
  - id: input_file
    type: File
    doc: Input NAF file to decompress
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file (defaults to stdout if not specified)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naf:1.3.0--h7b50bb2_5
