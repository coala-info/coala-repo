cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - needle
  - estimate
label: needle_estimate
doc: "Estimate expression value of transcript based on the Needle index.\n\nTool homepage:\
  \ https://github.com/seqan/needle"
inputs:
  - id: sequence_file
    type: File
    doc: Please provide a sequence file.
    inputBinding:
      position: 1
  - id: index_dir
    type: Directory
    doc: Directory where the input files (the Needle index made by needle ibf or ibfmin)
      can be found.
    inputBinding:
      position: 5
      prefix: --in
      valueFrom: $(self.path + "/")
  - id: out
    type: string
    doc: Output file, where the expression values are saved (default expressions.out).
    default: expressions.out
    inputBinding:
      position: 6
      prefix: --out
  - id: normalization_mode
    type:
      - 'null'
      - boolean
    doc: Set, if normalization is wanted. Normalization is achieved by dividing the
      expression value with the expression threshold of the first ibf. Only makes
      sense if every bin has its own expression thresholds (which is the case if expression
      thresholds were generated automatically).
    inputBinding:
      position: 10
      prefix: --normalization-mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: expressions
    type: File
    doc: Estimated expression values
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
stdout: needle_estimate.out
