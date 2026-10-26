cwlVersion: v1.2
class: CommandLineTool
baseCommand: cif2pdb
label: usalign_cif2pdb
doc: 'Converting mmCIF file to PDB file(s).


  Tool homepage: https://zhanggroup.org/US-align'
inputs:
  - id: input_cif
    type: File
    doc: Input mmCIF file
    inputBinding:
      position: 1
  - id: output_pdb
    type: string
    doc: Output PDB file name
    inputBinding:
      position: 2
  - id: chain
    type:
      - 'null'
      - string
    doc: Specify auth chain ID to convert
    inputBinding:
      position: 101
      prefix: -chain
  - id: mol
    type:
      - 'null'
      - int
    doc: 'Macromolecule type. Default is all macromolecules. 1: protein only; 2: RNA only; 4: DNA only'
    inputBinding:
      position: 101
      prefix: -mol
  - id: split
    type:
      - 'null'
      - int
    doc: 'Whether to split PDB file into multiple chains: 0: do not split; output a single PDB; 1: output one PDB file per chain'
    inputBinding:
      position: 101
      prefix: -split
  - id: het
    type:
      - 'null'
      - int
    doc: 'Whether to read residues marked as ''HETATM'' in addition to ''ATOM  '': 0: only ''ATOM  '' residues; 1: ''ATOM  '' and ''HETATM'' for MSE; 2: ''ATOM  '' and all ''HETATM'', excluding HOH; 3: ''ATOM  '' and all ''HETATM'', including HOH'
    inputBinding:
      position: 101
      prefix: -het
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pdb_files
    type:
      - 'null'
      - type: array
        items: File
    doc: PDB file(s) written
    outputBinding:
      glob: |
        ${ return inputs.output_pdb ? inputs.output_pdb + '*' : []; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign_cif2pdb.out
