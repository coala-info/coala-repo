cwlVersion: v1.2
class: CommandLineTool
baseCommand: skyline2isocor
label: skyline2isocor
doc: "Skyline2IsoCor: Convert Skyline output to IsoCor input.\n\nTool homepage: https://pypi.org/project/skyline2isocor/"
inputs:
  - id: input
    type: File
    doc: Path to input file to convert (tab-separated; extension .tsv, .txt or .dat)
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: Path to output IsoCor input data
    inputBinding:
      position: 2
      prefix: --output
stdout: skyline2isocor_stdout.txt
outputs:
  - id: isocor_input
    type: File
    doc: IsoCor input table (tab-separated)
    outputBinding:
      glob: $(inputs.output)
  - id: stdout_log
    type: File
    doc: Console output (the input and final tables)
    outputBinding:
      glob: skyline2isocor_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skyline2isocor:1.0.0--pyhdfd78af_0
