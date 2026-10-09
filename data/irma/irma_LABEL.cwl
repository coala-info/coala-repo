cwlVersion: v1.2
class: CommandLineTool
baseCommand: LABEL
label: irma_LABEL
doc: "LABEL (Lineage Assignment By Extended Learning): classify nucleotide sequences
  of influenza and other viruses into clades or subtypes with a hidden Markov model
  classifier.\n\nTool homepage: https://wonder.cdc.gov/amd/flu/irma/"
inputs:
  - id: max_proc
    type:
      - 'null'
      - int
    doc: Maximum number of processes
    inputBinding:
      position: 1
      prefix: -P
  - id: sge_option
    type:
      - 'null'
      - int
    doc: SGE clustering option. Use 1 or 2 for SGE with array jobs, else local.
    inputBinding:
      position: 2
      prefix: -E
  - id: lineage_path
    type:
      - 'null'
      - Directory
    doc: Path of the lineage (classifier) files to use
    inputBinding:
      position: 5
      prefix: -L
  - id: training
    type:
      - 'null'
      - boolean
    doc: Do TRAINING again instead of using classifier files
    inputBinding:
      position: 6
      prefix: -T
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: Do ALIGNMENT of the re-annotated fasta file (sorted by clade) and build its ML tree
    inputBinding:
      position: 7
      prefix: -A
  - id: control
    type:
      - 'null'
      - boolean
    doc: Do CONTROL alignment and ML tree construction
    inputBinding:
      position: 8
      prefix: -C
  - id: no_recursive
    type:
      - 'null'
      - boolean
    doc: No RECURSIVE prediction. Limits scope, useful with the -L option
    inputBinding:
      position: 9
      prefix: -R
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: No DELETION of extra intermediary files
    inputBinding:
      position: 10
      prefix: -D
  - id: nts_fasta
    type: File
    doc: Nucleotide sequences in fasta format
    inputBinding:
      position: 20
  - id: project
    type: string
    doc: Project name, used to name the output files
    inputBinding:
      position: 21
  - id: module
    type: string
    doc: Module (classifier) to use, for example irma-FLU, irma-FLU-HA, irma-FLU-NA, H5v2015, H9v2011
    inputBinding:
      position: 22
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: project_directory
    type: Directory
    doc: Project directory with the result files (re-annotated fasta, predictions, final table)
    outputBinding:
      glob: $(inputs.project)
arguments:
  - position: 3
    prefix: -W
    valueFrom: $(runtime.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irma:1.2.0--pl5321hdfd78af_0
stdout: irma_LABEL.out
