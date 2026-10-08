cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - create_top.py
label: gromacs_py_create_top
doc: "Create the topology file from a structure PDB file.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: input_pdb
    type: File
    doc: "Input PDB file"
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: "$(self.basename)"
  - id: output_directory
    type: string
    doc: "Output directory"
    inputBinding:
      position: 101
      prefix: -o
  - id: vsite
    type:
      - 'null'
      - boolean
    doc: "Use virtual site for hydrogens"
    inputBinding:
      position: 101
      prefix: -vsite
outputs:
  - id: output_directory_dir
    type: Directory
    doc: "Output directory written by create_top.py"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input_pdb.basename)
        entry: $(inputs.input_pdb)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
stdout: gromacs_py_create_top.out
