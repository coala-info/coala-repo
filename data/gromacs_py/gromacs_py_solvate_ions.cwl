cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - solvate_ions.py
label: gromacs_py_solvate_ions
doc: "Solvate a gromacs system with water and add ions to neutralize the system charge and to reach an ionic concentration.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: input_pdb
    type: File
    doc: "Input PDB file"
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: "$(self.basename)"
  - id: topology
    type: File
    doc: "Topology in gromacs format .top"
    inputBinding:
      position: 101
      prefix: -p
      valueFrom: "$(self.basename)"
  - id: output_directory
    type: string
    doc: "Output directory"
    inputBinding:
      position: 101
      prefix: -o
  - id: name
    type: string
    doc: "Output file name"
    inputBinding:
      position: 101
      prefix: -n
  - id: distance
    type:
      - 'null'
      - float
    doc: "Distance between the solute and the box"
    inputBinding:
      position: 101
      prefix: -d
  - id: ion_concentration
    type:
      - 'null'
      - float
    doc: "Ion concentration (mM), default = 0.15 (150mM)"
    inputBinding:
      position: 101
      prefix: -C
  - id: include_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files included by the topology (.itp, position restraints), staged beside the topology"
outputs:
  - id: output_directory_dir
    type: Directory
    doc: "Output directory written by solvate_ions.py"
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
      - entryname: $(inputs.topology.basename)
        entry: $(inputs.topology)
        writable: true
      - $(inputs.include_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
stdout: gromacs_py_solvate_ions.out
