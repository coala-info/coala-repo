cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - TMscore
label: tmalign_TMscore
doc: "TM-score: compare a model with a native structure (residue pairs with the same residue index are equivalent unless -seq is used)\n\nTool homepage: https://zhanglab.ccmb.med.umich.edu/TM-align/"
inputs:
  - id: model
    type: File
    doc: "Model structure in PDB format"
    inputBinding:
      position: 1
  - id: native
    type: File
    doc: "Native structure in PDB format"
    inputBinding:
      position: 2
  - id: complex_mode
    type:
      - 'null'
      - boolean
    doc: "Compare two complex structures with multiple chains"
    inputBinding:
      position: 3
      prefix: -c
  - id: d0_value
    type:
      - 'null'
      - float
    doc: "TM-score normalized with an assigned scale d0, e.g. 5 Angstroms"
    inputBinding:
      position: 4
      prefix: -d
  - id: length
    type:
      - 'null'
      - int
    doc: "TM-score normalized by a specific length, e.g. 120 residues"
    inputBinding:
      position: 5
      prefix: -l
  - id: superposition_prefix
    type:
      - 'null'
      - string
    doc: "Write the superposition to <prefix>* files, e.g. TM_sup"
    inputBinding:
      position: 6
      prefix: -o
  - id: sequence_alignment
    type:
      - 'null'
      - boolean
    doc: "Establish residue equivalence by sequence alignment instead of residue index"
    inputBinding:
      position: 7
      prefix: -seq
outputs:
  - id: superposition_files
    type:
      - 'null'
      - File[]
    doc: "Superposition files written with -o"
    outputBinding:
      glob: "$(inputs.superposition_prefix)*"
  - id: stdout
    type: stdout
    doc: Alignment report written to standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmalign:20220227--h9948957_0
stdout: tmalign_TMscore.out
