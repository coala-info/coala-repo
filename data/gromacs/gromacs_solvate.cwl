cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - solvate
label: gromacs_solvate
doc: "Solvate a system: fills a box with solvent molecules around a solute and updates the topology.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: solute_structure
    type:
      - 'null'
      - File
    doc: "Solute structure file: gro g96 pdb brk ent esp tpr"
    inputBinding:
      position: 101
      prefix: -cp
  - id: solvent_structure
    type:
      - 'null'
      - File
    doc: "Solvent structure file (default spc216.gro from the GROMACS library)"
    inputBinding:
      position: 101
      prefix: -cs
  - id: topology_in
    type:
      - 'null'
      - File
    doc: "Input topology file; updated in place with the number of solvent molecules"
    inputBinding:
      position: 101
      prefix: -p
      valueFrom: "$(self ? self.basename : null)"
  - id: output_structure
    type:
      - 'null'
      - string
    doc: "Output structure file"
    default: out.gro
    inputBinding:
      position: 101
      prefix: -o
  - id: box
    type:
      - 'null'
      - type: array
        items: float
    doc: "Box size (in nm)"
    inputBinding:
      position: 101
      prefix: -box
  - id: radius
    type:
      - 'null'
      - float
    doc: "Default van der Waals distance"
    inputBinding:
      position: 101
      prefix: -radius
  - id: scale
    type:
      - 'null'
      - float
    doc: "Scale factor to multiply Van der Waals radii from the database in share/gromacs/top/vdwradii.dat"
    inputBinding:
      position: 101
      prefix: -scale
  - id: shell
    type:
      - 'null'
      - float
    doc: "Thickness of optional water layer around solute"
    inputBinding:
      position: 101
      prefix: -shell
  - id: maxsol
    type:
      - 'null'
      - int
    doc: "Maximum number of solvent molecules to add if they fit in the box. If zero (default) this is ignored"
    inputBinding:
      position: 101
      prefix: -maxsol
  - id: vel
    type:
      - 'null'
      - boolean
    doc: "Keep velocities from input solute and solvent"
    inputBinding:
      position: 101
      prefix: -vel
outputs:
  - id: output_structure_file
    type: File
    doc: "Solvated structure file"
    outputBinding:
      glob: $(inputs.output_structure)
  - id: topology_file
    type:
      - 'null'
      - File
    doc: "Topology file updated with the solvent molecules"
    outputBinding:
      glob: "$(inputs.topology_in ? inputs.topology_in.basename : null)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: "$(inputs.topology_in ? inputs.topology_in.basename : 'unused_topology')"
        entry: "$(inputs.topology_in ? inputs.topology_in : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_solvate.out
