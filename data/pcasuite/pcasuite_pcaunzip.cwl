cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcaunzip
label: pcasuite_pcaunzip
doc: "Decompress PCA data from a file\n\nTool homepage: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite"
inputs:
  - id: input_file
    type: File
    doc: Input file to be decompressed
    inputBinding:
      position: 101
      prefix: -i
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Output in PDB format
    inputBinding:
      position: 101
      prefix: --pdb
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcasuite:1.0.0--h7baada4_6
