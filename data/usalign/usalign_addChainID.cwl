cwlVersion: v1.2
class: CommandLineTool
baseCommand: addChainID
label: usalign_addChainID
doc: 'Add chain ID to PDB format file.


  Tool homepage: https://zhanggroup.org/US-align'
inputs:
  - id: input_pdb
    type: File
    doc: Input PDB file
    inputBinding:
      position: 1
  - id: output_pdb
    type: string
    doc: Output PDB file name
    inputBinding:
      position: 2
  - id: chain_id
    type: string
    doc: Chain ID to add
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pdb_file
    type:
      - 'null'
      - File
    doc: PDB file with the chain ID
    outputBinding:
      glob: |
        ${ return inputs.output_pdb ? inputs.output_pdb : []; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign_addChainID.out
