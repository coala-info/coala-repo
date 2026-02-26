cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stag
  - check_input
label: stag_check_input
doc: "Check the input for the train command\n\nTool homepage: https://github.com/zellerlab/stag"
inputs:
  - id: command
    type: string
    doc: The command to run (e.g., train, classify, align, create_db, 
      check_input, correct_seq, convert_ali, unzip_db, train_genome, 
      classify_genome)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
stdout: stag_check_input.out
