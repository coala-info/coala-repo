cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygmes
label: pygmes
doc: "Evaluate completeness and contamination of a MAG.\n\nTool homepage: https://github.com/openpaul/pygmes"
inputs:
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete everything but the output files
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: db
    type: File
    doc: Path to the diamond DB
    inputBinding:
      position: 101
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug and thus ignore safety
    inputBinding:
      position: 101
      prefix: --debug
  - id: input
    type:
      - 'null'
      - File
    doc: path to the fasta file, or in metagenome mode path to bin folder
    inputBinding:
      position: 101
      prefix: --input
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Run in metaegnomic mode
    inputBinding:
      position: 101
      prefix: --meta
  - id: ncores
    type:
      - 'null'
      - int
    doc: Number of threads to use with GeneMark-ES and Diamond
    inputBinding:
      position: 101
      prefix: --ncores
  - id: noclean
    type:
      - 'null'
      - boolean
    doc: GeneMark-ES needs clean fasta headers and will fail if you dont 
      proveide them. Set this flag if you don't want pygmes to clean your 
      headers
    inputBinding:
      position: 101
      prefix: --noclean
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silcence most output
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output
    type: Directory
    doc: Path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygmes:0.1.7--py_0
