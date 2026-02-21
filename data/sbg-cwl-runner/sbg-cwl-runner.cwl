cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbg-cwl-runner
label: sbg-cwl-runner
doc: "A tool for running Common Workflow Language (CWL) workflows on the Seven Bridges
  platform.\n\nTool homepage: https://github.com/kaushik-work/sbg-cwl-runner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbg-cwl-runner:2018.11--py_0
stdout: sbg-cwl-runner.out
