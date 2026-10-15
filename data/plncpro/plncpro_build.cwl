cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plncpro
  - build
label: plncpro_build
doc: "Generate a classification model from coding and non coding transcripts\n\nTool homepage: https://github.com/urmi-21/PLncPRO"
inputs:
  - id: pos
    type: File
    doc: 'Path to file containing protein coding examples'
    inputBinding:
      position: 101
      prefix: -p
  - id: neg
    type: File
    doc: 'Path to file containing non coding examples'
    inputBinding:
      position: 101
      prefix: -n
  - id: model
    type: string
    doc: 'Output model name'
    inputBinding:
      position: 101
      prefix: -m
  - id: outdir
    type: string
    doc: 'Output directory name to store all results'
    inputBinding:
      position: 101
      prefix: -o
  - id: blast_db_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files of the protein BLAST database (for example mydb.phr, mydb.pin and mydb.psq), staged in the working directory so that blast_db_prefix resolves'
  - id: blast_db_prefix
    type:
      - 'null'
      - string
    doc: 'Path (prefix) of the protein BLAST database'
    inputBinding:
      position: 101
      prefix: -d
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads [default: 4]'
    inputBinding:
      position: 101
      prefix: -t
  - id: trees
    type:
      - 'null'
      - int
    doc: 'Number of trees [default: 1000]'
    inputBinding:
      position: 101
      prefix: -k
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: 'Clean up intermediate files'
    inputBinding:
      position: 101
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show more messages'
    inputBinding:
      position: 101
      prefix: -v
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'Minimum length to filter input files'
    inputBinding:
      position: 101
      prefix: --min_len
  - id: noblast
    type:
      - 'null'
      - boolean
    doc: 'Do not use blast features'
    inputBinding:
      position: 101
      prefix: --noblast
  - id: no_ff
    type:
      - 'null'
      - boolean
    doc: 'Do not use framefinder features'
    inputBinding:
      position: 101
      prefix: --no_ff
  - id: qcov_hsp
    type:
      - 'null'
      - int
    doc: 'Query coverage parameter for blast [default: 30]'
    inputBinding:
      position: 101
      prefix: --qcov_hsp
  - id: pos_blastres
    type:
      - 'null'
      - File
    doc: 'Path to blast output for positive input file'
    inputBinding:
      position: 101
      prefix: --pos_blastres
  - id: neg_blastres
    type:
      - 'null'
      - File
    doc: 'Path to blast output for negative input file'
    inputBinding:
      position: 101
      prefix: --neg_blastres
outputs:
  - id: result_directory
    type: Directory
    doc: 'Output directory with the model and intermediate results'
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.blast_db_files)
      - entry: $(inputs.pos)
        writable: true
      - entry: $(inputs.neg)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
