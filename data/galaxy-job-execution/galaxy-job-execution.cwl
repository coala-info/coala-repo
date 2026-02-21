cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-job-execution
label: galaxy-job-execution
doc: "A tool for executing Galaxy jobs (Note: The provided text appears to be a container
  execution error log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-job-execution:25.0.4--pyhdfd78af_0
stdout: galaxy-job-execution.out
