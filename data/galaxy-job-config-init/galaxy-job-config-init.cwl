cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-job-config-init
label: galaxy-job-config-init
doc: "A tool for initializing Galaxy job configurations. (Note: The provided text
  contains error logs rather than help documentation, so specific arguments could
  not be identified.)\n\nTool homepage: https://github.com/galaxyproject/galaxy-job-config-init"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-job-config-init:0.1.3--pyhdfd78af_0
stdout: galaxy-job-config-init.out
