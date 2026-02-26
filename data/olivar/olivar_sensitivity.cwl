cwlVersion: v1.2
class: CommandLineTool
baseCommand: olivar_sensitivity
label: olivar_sensitivity
doc: "Check the sensitivity of existing primer pools against an MSA of target sequences,
  and visualize the MSA and primer alignments.\n\nTool homepage: https://gitlab.com/treangenlab/olivar"
inputs:
  - id: csv_file
    type: File
    doc: 'Path to the csv file of a primer pool. Required columns: "amplicon_id" (amplicon
      name), "fP" (sequence of forward primer), "rP" (sequence of reverse primer).'
    inputBinding:
      position: 1
  - id: align
    type:
      - 'null'
      - boolean
    doc: Control whether do alignment or not.
    inputBinding:
      position: 102
      prefix: --align
  - id: msa
    type:
      - 'null'
      - File
    doc: Path to the MSA file in FASTA format.
    inputBinding:
      position: 102
      prefix: --msa
  - id: output
    type:
      - 'null'
      - string
    doc: Output path (output to current directory by default).
    inputBinding:
      position: 102
      prefix: --output
  - id: pool
    type:
      - 'null'
      - int
    doc: Primer pool number
    default: 1
    inputBinding:
      position: 102
      prefix: --pool
  - id: sodium
    type:
      - 'null'
      - float
    doc: The sum of the concentrations of monovalent ions (Na+, K+, NH4+), in 
      molar
    default: 0.18
    inputBinding:
      position: 102
      prefix: --sodium
  - id: temperature
    type:
      - 'null'
      - float
    doc: Annealing temperature in Degree Celsius
    default: 60.0
    inputBinding:
      position: 102
      prefix: --temperature
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: title
    type:
      - 'null'
      - string
    doc: Name of validation
    default: olivar-sensitivity
    inputBinding:
      position: 102
      prefix: --title
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
stdout: olivar_sensitivity.out
