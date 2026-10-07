cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - ensemble
label: clair_ensemble
doc: "Combine probabilities from several callVarBam/call_var runs made with --output_for_ensemble (read from standard input)\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: ensemble_input
    type: File
    doc: "Concatenated --output_for_ensemble outputs, read from standard input"
  - id: minimum_count_to_output
    type:
      - 'null'
      - int
    doc: "minimum # of calls to output the probabilities"
    inputBinding:
      position: 101
      prefix: --minimum_count_to_output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdin: "$(inputs.ensemble_input.path)"
stdout: clair_ensemble.out
