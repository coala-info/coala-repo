cwlVersion: v1.2
class: CommandLineTool
baseCommand: xunit-wrapper
label: xunit-wrapper
doc: "A wrapper tool that runs a command and generates an xUnit-style XML report from
  its output and exit code.\n\nTool homepage: https://github.com/TAMU-CPT/xunit-python-decorator"
inputs:
  - id: command
    type: string
    doc: The command to be executed and wrapped.
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to be passed to the command.
    inputBinding:
      position: 2
  - id: suite_name
    type:
      - 'null'
      - string
    doc: The name of the test suite to be used in the XML report.
    inputBinding:
      position: 103
      prefix: --name
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The path to the output xUnit XML report file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xunit-wrapper:0.12--pyh7e72e81_3
