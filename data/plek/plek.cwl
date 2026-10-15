cwlVersion: v1.2
class: CommandLineTool
baseCommand: PLEK.py
label: plek
doc: "Predictor of Long non-coding RNAs and messenger RNAs based on K-mer scheme\n\
  \ \nTool homepage: https://sourceforge.net/projects/plek"
inputs:
  - id: fasta
    type: File
    doc: The name of a fasta file, its sequences are to be predicted.
    inputBinding:
      position: 101
      prefix: -fasta
  - id: output_path
    type: string
    doc: The file name for the results of prediction. Predicted positive samples
      are labeled as "Coding", and negative as "Non-coding".
    inputBinding:
      position: 102
      prefix: -out
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads for running the PLEK program. Default value 5.
    inputBinding:
      position: 103
      prefix: -thread
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of sequences. The sequences whose lengths are more
      than minlength will be processed. Default value 200.
    inputBinding:
      position: 103
      prefix: -minlength
  - id: is_out_msg
    type:
      - 'null'
      - int
    doc: Output messages to stdout (screen) or not. 0 runs PLEK quietly, 1
      outputs the details of processing. Default value 0.
    inputBinding:
      position: 103
      prefix: -isoutmsg
  - id: is_rm_temp_file
    type:
      - 'null'
      - int
    doc: Remove temporary files or not. 0 retains temporary files, 1 removes
      them. Default value 1.
    inputBinding:
      position: 103
      prefix: -isrmtempfile
outputs:
  - id: output
    type: File
    doc: Output file with the predictions
    outputBinding:
      glob: $(inputs.output_path)
  - id: temp_files
    type:
      type: array
      items: File
    doc: Detail files written when temporary files are kept (-isrmtempfile 0)
    outputBinding:
      glob: $(inputs.output_path)_*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plek:1.2--py310h8ea774a_10
