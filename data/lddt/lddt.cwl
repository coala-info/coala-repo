cwlVersion: v1.2
class: CommandLineTool
baseCommand: lddt
label: lddt
doc: "Calculate the Local Distance Difference Test (LDDT) score for a given model.\n\
  \nTool homepage: https://swissmodel.expasy.org/lddt"
inputs:
  - id: mod1
    type: File
    doc: First model file
    inputBinding:
      position: 1
  - id: mod2
    type:
      - 'null'
      - File
    doc: Second model file (optional)
    inputBinding:
      position: 2
  - id: re1
    type: string
    doc: Reference structure identifier (e.g., PDB ID or file path)
    inputBinding:
      position: 3
  - id: ref2
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional reference structure identifiers (optional)
    inputBinding:
      position: 4
  - id: angle_tolerance
    type:
      - 'null'
      - float
    doc: tolerance in stddevs for angles
    inputBinding:
      position: 105
      prefix: -a
  - id: bond_tolerance
    type:
      - 'null'
      - float
    doc: tolerance in stddevs for bonds
    inputBinding:
      position: 105
      prefix: -b
  - id: calphas_only
    type:
      - 'null'
      - boolean
    doc: use Calphas only
    inputBinding:
      position: 105
      prefix: -c
  - id: fault_tolerant_parsing
    type:
      - 'null'
      - boolean
    doc: fault tolerant parsing
    inputBinding:
      position: 105
      prefix: -t
  - id: filter_input
    type:
      - 'null'
      - boolean
    doc: perform structural checks and filter input data
    inputBinding:
      position: 105
      prefix: -f
  - id: ignore_residue_name_consistency
    type:
      - 'null'
      - boolean
    doc: ignore residue name consistency checks
    inputBinding:
      position: 105
      prefix: -x
  - id: inclusion_radius
    type:
      - 'null'
      - float
    doc: distance inclusion radius
    inputBinding:
      position: 105
      prefix: -r
  - id: parameter_file
    type: File
    doc: use specified parameter file. Mandatory
    inputBinding:
      position: 105
      prefix: -p
  - id: print_version
    type:
      - 'null'
      - boolean
    doc: print version
    inputBinding:
      position: 105
      prefix: -e
  - id: selection_on_ref
    type:
      - 'null'
      - boolean
    doc: selection performed on ref
    inputBinding:
      position: 105
      prefix: -s
  - id: sequence_separation
    type:
      - 'null'
      - float
    doc: sequence separation
    inputBinding:
      position: 105
      prefix: -i
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: verbosity level (0=results only,1=problems reported, 2=full report)
    inputBinding:
      position: 105
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lddt:2.2--h9ee0642_0
stdout: lddt.out
