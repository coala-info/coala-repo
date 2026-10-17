cwlVersion: v1.2
class: CommandLineTool
baseCommand: provean
label: provean
doc: "Protein Variation Effect Analyzer (PROVEAN) predicts the functional effect of
  amino acid substitutions and indels.\n\nTool homepage: https://www.jcvi.org/research/provean"
inputs:
  - id: blastdbcmd_path
    type: string
    default: /usr/local/bin/blastdbcmd
    doc: Path to blastdbcmd (path inside the image)
    inputBinding:
      position: 101
      prefix: --blastdbcmd
  - id: cdhit_path
    type: string
    default: /usr/local/bin/cd-hit
    doc: Path to cd-hit (path inside the image)
    inputBinding:
      position: 101
      prefix: --cdhit
  - id: database
    type: File
    secondaryFiles:
      - pattern: .phr
        required: true
      - pattern: .pin
        required: true
      - pattern: .psq
        required: true
      - pattern: .pog
        required: false
      - pattern: .psd
        required: false
      - pattern: .psi
        required: false
      - pattern: .pdb
        required: false
      - pattern: .pot
        required: false
      - pattern: .ptf
        required: false
      - pattern: .pto
        required: false
    doc: BLAST protein database; give the FASTA file the database was built from
      (makeblastdb -in x.fa), with the index files beside it
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
    type: string
    default: /usr/local/bin/psiblast
    doc: Path to psiblast (path inside the image)
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
      - string
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
  - id: save_supporting_set_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --save_supporting_set
outputs:
  - id: scores
    type: stdout
    doc: PROVEAN scores, one line per variation
  - id: save_supporting_set
    type:
      - 'null'
      - File
    doc: Save supporting set to file
    outputBinding:
      glob: '$(inputs.save_supporting_set_path ? inputs.save_supporting_set_path : [])'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/provean:1.1.5--h503566f_3
stdout: provean_scores.txt
