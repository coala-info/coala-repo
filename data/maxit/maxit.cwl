cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxit
label: maxit
doc: "Translate between PDB and CIF formats.\n\nTool homepage: https://sw-tools.rcsb.org/apps/MAXIT"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 101
      prefix: -input
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: -log
  - id: translation_type
    type: int
    doc: 'Translation type: 1 (PDB to CIF), 2 (CIF to PDB), 8 (CIF to mmCIF)'
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxit:11.400--h503566f_0
