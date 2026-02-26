cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_write-balls-to-atoms-file
label: voronota_write-balls-to-atoms-file
doc: "Writes balls to an atoms file.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (line format: 'annotation x y z r tags adjuncts')"
    inputBinding:
      position: 1
  - id: add_chain_terminators
    type:
      - 'null'
      - boolean
    doc: flag to add TER lines after chains
    inputBinding:
      position: 102
      prefix: --add-chain-terminators
  - id: pdb_output_b_factor
    type:
      - 'null'
      - string
    doc: name of adjunct to output as B-factor in PDB format
    inputBinding:
      position: 102
      prefix: --pdb-output-b-factor
  - id: pdb_output_template
    type:
      - 'null'
      - File
    doc: file path to input template for B-factor insertions
    inputBinding:
      position: 102
      prefix: --pdb_output_template
outputs:
  - id: pdb_output
    type:
      - 'null'
      - File
    doc: file path to output query result in PDB format
    outputBinding:
      glob: $(inputs.pdb_output)
  - id: output_balls
    type: File
    doc: "list of balls (line format: 'annotation x y z r tags adjuncts')"
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
