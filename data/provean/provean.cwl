cwlVersion: v1.2
class: CommandLineTool
baseCommand: provean
label: provean
doc: "Protein Variation Effect Analyzer (PROVEAN) predicts the functional effect of
  amino acid substitutions and indels.\n\nTool homepage: https://www.jcvi.org/research/provean"
inputs:
  - id: blastdbcmd_path
    type:
      - 'null'
      - File
    doc: Path to blastdbcmd
    inputBinding:
      position: 101
      prefix: --blastdbcmd
  - id: cdhit_path
    type:
      - 'null'
      - File
    doc: Path to cd-hit
    inputBinding:
      position: 101
      prefix: --cdhit
  - id: database
    type:
      - 'null'
      - File
    doc: Protein database
    inputBinding:
      position: 101
      prefix: -d
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (>=1)
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: psiblast_path
    type:
      - 'null'
      - File
    doc: Path to psiblast
    inputBinding:
      position: 101
      prefix: --psiblast
  - id: query_sequence
    type:
      - 'null'
      - File
    doc: Query protein sequence in FASTA format
    inputBinding:
      position: 101
      prefix: -q
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in quiet mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: subject_sequences
    type:
      - 'null'
      - File
    doc: Subject sequences file
    inputBinding:
      position: 101
      prefix: --subject_sequences
  - id: supporting_set
    type:
      - 'null'
      - File
    doc: Supporting set file
    inputBinding:
      position: 101
      prefix: --supporting_set
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    inputBinding:
      position: 101
      prefix: --tmp_dir
  - id: variation
    type:
      - 'null'
      - File
    doc: Variation file containing amino acid substitutions or indels
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: save_supporting_set
    type:
      - 'null'
      - File
    doc: Save supporting set to file
    outputBinding:
      glob: $(inputs.save_supporting_set)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/provean:1.1.5--h503566f_3
