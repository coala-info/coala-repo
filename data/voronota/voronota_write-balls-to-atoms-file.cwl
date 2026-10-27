cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - write-balls-to-atoms-file
label: voronota_write-balls-to-atoms-file
doc: "Writes balls to an atoms file in PDB format.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_balls
    type: File
    doc: "list of annotated balls (stdin)"
  - id: pdb_output_path
    type:
      - 'null'
      - string
    doc: "file path to output query result in PDB format"
    inputBinding:
      position: 101
      prefix: --pdb-output
  - id: pdb_output_b_factor
    type:
      - 'null'
      - string
    doc: "name of adjunct to output as B-factor in PDB format"
    inputBinding:
      position: 101
      prefix: --pdb-output-b-factor
  - id: pdb_output_template
    type:
      - 'null'
      - File
    doc: "file path to input template for B-factor insertions"
    inputBinding:
      position: 101
      prefix: --pdb-output-template
  - id: add_chain_terminators
    type:
      - 'null'
      - boolean
    doc: "flag to add TER lines after chains"
    inputBinding:
      position: 101
      prefix: --add-chain-terminators
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pdb_output
    type:
      - 'null'
      - File
    doc: "file path to output query result in PDB format"
    outputBinding:
      glob: $(inputs.pdb_output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_balls.path)
stdout: voronota_write-balls-to-atoms-file.out
