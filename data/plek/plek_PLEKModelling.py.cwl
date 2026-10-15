cwlVersion: v1.2
class: CommandLineTool
baseCommand: PLEKModelling.py
label: plek_PLEKModelling.py
doc: "Build your own PLEK classifier with training data (mRNA and lncRNA transcripts).\n\nTool homepage: https://sourceforge.net/projects/plek"
inputs:
  - id: mrna
    type: File
    doc: mRNA transcripts used to build the predictor, in fasta format.
    inputBinding:
      position: 101
      prefix: -mRNA
  - id: lncrna
    type: File
    doc: lncRNA transcripts used to build the predictor, in fasta format.
    inputBinding:
      position: 101
      prefix: -lncRNA
  - id: prefix
    type: string
    doc: Prefix of the output files.
    inputBinding:
      position: 101
      prefix: -prefix
  - id: log2c
    type:
      - 'null'
      - string
    doc: The specified range of C parameter for the svm parameter search (from,to,by). Default 0,5,1.
    inputBinding:
      position: 103
      prefix: -log2c
  - id: log2g
    type:
      - 'null'
      - string
    doc: The specified range of G parameter for the svm parameter search (from,to,by). Default 0,-5,-1.
    inputBinding:
      position: 103
      prefix: -log2g
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads. Default 12.
    inputBinding:
      position: 103
      prefix: -thread
  - id: model
    type:
      - 'null'
      - string
    doc: The name of a predictor model file (an output file by PLEKModelling.py).
    inputBinding:
      position: 103
      prefix: -model
  - id: range
    type:
      - 'null'
      - string
    doc: The name of a svm range file (an output file by PLEKModelling.py).
    inputBinding:
      position: 103
      prefix: -range
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of sequences. Default 200.
    inputBinding:
      position: 103
      prefix: -minlength
  - id: is_out_msg
    type:
      - 'null'
      - int
    doc: Output messages to stdout or not (0 or 1). Default 0.
    inputBinding:
      position: 103
      prefix: -isoutmsg
  - id: is_rm_temp_file
    type:
      - 'null'
      - int
    doc: Remove temporary files or not (0 or 1). Default 1.
    inputBinding:
      position: 103
      prefix: -isrmtempfile
  - id: k
    type:
      - 'null'
      - int
    doc: Range of k; k=5 calculates usage of 1364 k-mer patterns. Default 5.
    inputBinding:
      position: 103
      prefix: -k
  - id: nfold
    type:
      - 'null'
      - int
    doc: n-fold cross-validation in search for optimal parameters. Default 10.
    inputBinding:
      position: 103
      prefix: -nfold
  - id: is_balanced
    type:
      - 'null'
      - int
    doc: If 1 and the samples are unbalanced, subsample the overrepresented class (0 or 1). Default 0.
    inputBinding:
      position: 103
      prefix: -isbalanced
outputs:
  - id: model_file
    type:
      - 'null'
      - File
    doc: Predictor model file
    outputBinding:
      glob: $(inputs.prefix).model
  - id: range_file
    type:
      - 'null'
      - File
    doc: svm-scale range file
    outputBinding:
      glob: $(inputs.prefix).range
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plek:1.2--py310h8ea774a_10
