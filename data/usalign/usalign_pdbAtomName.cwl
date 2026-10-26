cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdbAtomName
label: usalign_pdbAtomName
doc: 'Fix atom name justification in PDB format file.


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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pdb_file
    type:
      - 'null'
      - File
    doc: PDB file with fixed atom names
    outputBinding:
      glob: |
        ${ return inputs.output_pdb ? inputs.output_pdb : []; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign_pdbAtomName.out
