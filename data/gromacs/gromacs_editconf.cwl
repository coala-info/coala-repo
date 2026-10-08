cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - editconf
label: gromacs_editconf
doc: "Edit the box and write subgroups: converts and manipulates structure files, e.g. defines a box around a molecule.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: input_structure
    type: File
    doc: "Input structure file: gro g96 pdb brk ent esp tpr"
    inputBinding:
      position: 101
      prefix: -f
  - id: index_file
    type:
      - 'null'
      - File
    doc: "Index file"
    inputBinding:
      position: 101
      prefix: -n
  - id: bfactor_file
    type:
      - 'null'
      - File
    doc: "Generic data file with B-factors"
    inputBinding:
      position: 101
      prefix: -bf
  - id: output_structure
    type:
      - 'null'
      - string
    doc: "Output structure file: gro g96 pdb brk ent esp"
    default: out.gro
    inputBinding:
      position: 101
      prefix: -o
  - id: mead_output
    type:
      - 'null'
      - string
    doc: "Output coordinate file for MEAD (.pqr, optional)"
    inputBinding:
      position: 101
      prefix: -mead
  - id: ndef
    type:
      - 'null'
      - boolean
    doc: "Choose output from default index groups"
    inputBinding:
      position: 101
      prefix: -ndef
  - id: box_type
    type:
      - 'null'
      - string
    doc: "Box type for -box and -d: triclinic, cubic, dodecahedron, octahedron"
    inputBinding:
      position: 101
      prefix: -bt
  - id: box
    type:
      - 'null'
      - type: array
        items: float
    doc: "Box vector lengths (a,b,c)"
    inputBinding:
      position: 101
      prefix: -box
  - id: angles
    type:
      - 'null'
      - type: array
        items: float
    doc: "Angles between the box vectors (bc,ac,ab)"
    inputBinding:
      position: 101
      prefix: -angles
  - id: distance
    type:
      - 'null'
      - float
    doc: "Distance between the solute and the box (nm)"
    inputBinding:
      position: 101
      prefix: -d
  - id: center_molecule
    type:
      - 'null'
      - boolean
    doc: "Center molecule in box (implied by -box and -d)"
    inputBinding:
      position: 101
      prefix: -c
  - id: center
    type:
      - 'null'
      - type: array
        items: float
    doc: "Shift the geometrical center to (x,y,z)"
    inputBinding:
      position: 101
      prefix: -center
  - id: aligncenter
    type:
      - 'null'
      - type: array
        items: float
    doc: "Center of rotation for alignment"
    inputBinding:
      position: 101
      prefix: -aligncenter
  - id: align
    type:
      - 'null'
      - type: array
        items: float
    doc: "Align to target vector"
    inputBinding:
      position: 101
      prefix: -align
  - id: translate
    type:
      - 'null'
      - type: array
        items: float
    doc: "Translation"
    inputBinding:
      position: 101
      prefix: -translate
  - id: rotate
    type:
      - 'null'
      - type: array
        items: float
    doc: "Rotation around the X, Y and Z axes in degrees"
    inputBinding:
      position: 101
      prefix: -rotate
  - id: princ
    type:
      - 'null'
      - boolean
    doc: "Orient molecule(s) along their principal axes"
    inputBinding:
      position: 101
      prefix: -princ
  - id: scale
    type:
      - 'null'
      - type: array
        items: float
    doc: "Scaling factor"
    inputBinding:
      position: 101
      prefix: -scale
  - id: density
    type:
      - 'null'
      - float
    doc: "Density (g/L) of the output box achieved by scaling"
    inputBinding:
      position: 101
      prefix: -density
  - id: pbc
    type:
      - 'null'
      - boolean
    doc: "Remove the periodicity (make molecule whole again)"
    inputBinding:
      position: 101
      prefix: -pbc
  - id: resnr
    type:
      - 'null'
      - int
    doc: "Renumber residues starting from resnr"
    inputBinding:
      position: 101
      prefix: -resnr
  - id: grasp
    type:
      - 'null'
      - boolean
    doc: "Store the charge of the atom in the B-factor field and the radius of the atom in the occupancy field"
    inputBinding:
      position: 101
      prefix: -grasp
  - id: rvdw
    type:
      - 'null'
      - float
    doc: "Default Van der Waals radius (in nm) if one can not be found in the database or if no parameters are present in the topology file"
    inputBinding:
      position: 101
      prefix: -rvdw
  - id: sig56
    type:
      - 'null'
      - boolean
    doc: "Use rmin/2 (minimum in the Van der Waals potential) rather than sigma/2"
    inputBinding:
      position: 101
      prefix: -sig56
  - id: vdwread
    type:
      - 'null'
      - boolean
    doc: "Read the Van der Waals radii from the file vdwradii.dat rather than computing the radii based on the force field"
    inputBinding:
      position: 101
      prefix: -vdwread
  - id: atom
    type:
      - 'null'
      - boolean
    doc: "Force B-factor attachment per atom"
    inputBinding:
      position: 101
      prefix: -atom
  - id: legend
    type:
      - 'null'
      - boolean
    doc: "Make B-factor legend"
    inputBinding:
      position: 101
      prefix: -legend
  - id: label
    type:
      - 'null'
      - string
    doc: "Add chain label for all residues"
    inputBinding:
      position: 101
      prefix: -label
  - id: conect
    type:
      - 'null'
      - boolean
    doc: "Add CONECT records to a .pdb file when written. Can only be done when a topology is present"
    inputBinding:
      position: 101
      prefix: -conect
outputs:
  - id: output_structure_file
    type: File
    doc: "Output structure file"
    outputBinding:
      glob: $(inputs.output_structure)
  - id: mead_file
    type:
      - 'null'
      - File
    doc: "Coordinate file for MEAD"
    outputBinding:
      glob: $(inputs.mead_output)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_editconf.out
