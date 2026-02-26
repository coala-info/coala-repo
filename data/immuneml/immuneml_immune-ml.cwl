cwlVersion: v1.2
class: CommandLineTool
baseCommand: immune-ml
label: immuneml_immune-ml
doc: "immuneML command line tool\n\nTool homepage: https://github.com/uio-bmi/immuneML"
inputs:
  - id: specification_path
    type: File
    doc: Path to specification YAML file. Always used to define the analysis.
    inputBinding:
      position: 1
  - id: result_path
    type: Directory
    doc: Output directory path.
    inputBinding:
      position: 2
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level to use
    inputBinding:
      position: 103
      prefix: --logging
  - id: tool
    type:
      - 'null'
      - string
    doc: Name of the tool which calls immuneML. This name will be used to invoke
      appropriate API call, which will then do additional work in tool-dependent
      way before running standard immuneML.
    inputBinding:
      position: 103
      prefix: --tool
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/immuneml:3.0.17--pyhdfd78af_0
stdout: immuneml_immune-ml.out
