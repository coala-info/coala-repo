cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - insert_mol_no_vmd.py
label: gromacs_py_insert_mol_no_vmd
doc: "Insert molecules into a system (PDB and topology) without using VMD.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: system_pdb
    type: File
    doc: "Input PDB file of the system"
    inputBinding:
      position: 101
      prefix: -fsys
      valueFrom: "$(self.basename)"
  - id: system_topology
    type: File
    doc: "Topology in gromacs format .top of the system"
    inputBinding:
      position: 101
      prefix: -psys
      valueFrom: "$(self.basename)"
  - id: molecule_pdb
    type: File
    doc: "Input PDB file of the molecule to insert"
    inputBinding:
      position: 101
      prefix: -fmol
      valueFrom: "$(self.basename)"
  - id: molecule_topology
    type: File
    doc: "Topology in gromacs format .top of the molecule to insert"
    inputBinding:
      position: 101
      prefix: -pmol
      valueFrom: "$(self.basename)"
  - id: num_molecules
    type:
      - 'null'
      - int
    doc: "Number of molecules to insert, default=20"
    inputBinding:
      position: 101
      prefix: -nmol
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
  - id: include_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files included by the two topologies (.itp, position restraints), staged beside them"
outputs:
  - id: output_directory_dir
    type: Directory
    doc: "Output directory written by insert_mol_no_vmd.py"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.system_pdb)
      - entryname: $(inputs.system_topology.basename)
        entry: $(inputs.system_topology)
        writable: true
      - $(inputs.molecule_pdb)
      - entryname: $(inputs.molecule_topology.basename)
        entry: $(inputs.molecule_topology)
        writable: true
      - "${ return inputs.include_files ? inputs.include_files.map(function (f) { return {entryname: f.basename, entry: f, writable: true}; }) : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
stdout: gromacs_py_insert_mol_no_vmd.out
