cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plncpro
  - predict
label: plncpro_predict
doc: "Classify transcripts as coding or non coding transcripts\n\nTool homepage: https://github.com/urmi-21/PLncPRO"
inputs:
  - id: input_fasta
    type: File
    doc: 'Path to file containing input sequences'
    inputBinding:
      position: 101
      prefix: -i
  - id: model
    type: File
    doc: 'Path to the model file'
    inputBinding:
      position: 101
      prefix: -m
  - id: prediction_file
    type: string
    doc: 'Output file name to store prediction results'
    inputBinding:
      position: 101
      prefix: -p
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
  - id: labels
    type:
      - 'null'
      - File
    doc: 'Path to the file containing labels (this outputs performance of the classifier)'
    inputBinding:
      position: 101
      prefix: -l
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
  - id: blastres
    type:
      - 'null'
      - File
    doc: 'Path to blast output for input file'
    inputBinding:
      position: 101
      prefix: --blastres
outputs:
  - id: result_directory
    type: Directory
    doc: 'Output directory with the prediction results'
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.blast_db_files)
      - entry: $(inputs.input_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
