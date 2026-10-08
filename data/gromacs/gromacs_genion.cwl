cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - genion
label: gromacs_genion
doc: "Generate monoatomic ions: replaces solvent molecules by ions to neutralize the system or reach a salt concentration.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: run_input
    type: File
    doc: "Portable xdr run input file (.tpr)"
    inputBinding:
      position: 101
      prefix: -s
  - id: index_file
    type:
      - 'null'
      - File
    doc: "Index file"
    inputBinding:
      position: 101
      prefix: -n
  - id: topology_in
    type:
      - 'null'
      - File
    doc: "Input topology file; updated in place with the added ions"
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
  - id: selection_file
    type: File
    doc: "Text file with the name of the solvent group to replace with ions (read from standard input), e.g. a file containing SOL"
  - id: positive_ions
    type:
      - 'null'
      - int
    doc: "Number of positive ions"
    inputBinding:
      position: 101
      prefix: -np
  - id: positive_name
    type:
      - 'null'
      - string
    doc: "Name of the positive ion"
    inputBinding:
      position: 101
      prefix: -pname
  - id: positive_charge
    type:
      - 'null'
      - int
    doc: "Charge of the positive ion"
    inputBinding:
      position: 101
      prefix: -pq
  - id: negative_ions
    type:
      - 'null'
      - int
    doc: "Number of negative ions"
    inputBinding:
      position: 101
      prefix: -nn
  - id: negative_name
    type:
      - 'null'
      - string
    doc: "Name of the negative ion"
    inputBinding:
      position: 101
      prefix: -nname
  - id: negative_charge
    type:
      - 'null'
      - int
    doc: "Charge of the negative ion"
    inputBinding:
      position: 101
      prefix: -nq
  - id: rmin
    type:
      - 'null'
      - float
    doc: "Minimum distance between ions and non-solvent"
    inputBinding:
      position: 101
      prefix: -rmin
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator (0 means generate)"
    inputBinding:
      position: 101
      prefix: -seed
  - id: concentration
    type:
      - 'null'
      - float
    doc: "Salt concentration (mol/liter); overrides -np and -nn"
    inputBinding:
      position: 101
      prefix: -conc
  - id: neutral
    type:
      - 'null'
      - boolean
    doc: "Add enough ions to neutralize the system"
    inputBinding:
      position: 101
      prefix: -neutral
outputs:
  - id: output_structure_file
    type: File
    doc: "Structure file with ions"
    outputBinding:
      glob: $(inputs.output_structure)
  - id: topology_file
    type:
      - 'null'
      - File
    doc: "Topology file updated with the ions"
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
stdin: $(inputs.selection_file.path)
stdout: gromacs_genion.out
