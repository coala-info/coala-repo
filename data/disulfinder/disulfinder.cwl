cwlVersion: v1.2
class: CommandLineTool
baseCommand: disulfinder
label: disulfinder
doc: "Predicts disulfide bonding state and connectivity from protein sequences.\n\n\
  Tool homepage: https://github.com/ajvenkat/disulfinder-test"
inputs:
  - id: input_file
    type: File
    doc: Input protein sequence file in FASTA format
    inputBinding:
      position: 1
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: Path to the sequence database for psiblast
    inputBinding:
      position: 102
      prefix: -d
  - id: predict_all
    type:
      - 'null'
      - boolean
    doc: Predict both disulfide bonding state and connectivity (default)
    inputBinding:
      position: 102
      prefix: -a
  - id: predict_state_only
    type:
      - 'null'
      - boolean
    doc: Predict disulfide bonding state only
    inputBinding:
      position: 102
      prefix: -r
  - id: psiblast_path
    type:
      - 'null'
      - Directory
    doc: Path to the psiblast executable or directory
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/disulfinder:v1.2.11-8-deb_cv1
