cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clsify
  - cli
label: clsify_cli
doc: "Classify sequence files and extract sample information using regular expressions.\n\
  \nTool homepage: https://github.com/holtgrewe/clsify"
inputs:
  - id: seq_files
    type:
      type: array
      items: File
    doc: Sequence files to be processed
    inputBinding:
      position: 1
  - id: sample_regex
    type:
      - 'null'
      - string
    doc: Regular expression to match file name to sample name.
    inputBinding:
      position: 102
      prefix: --sample-regex
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clsify:0.1.1--py_0
