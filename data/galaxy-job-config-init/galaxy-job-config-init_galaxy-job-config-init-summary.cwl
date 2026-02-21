cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-job-config-init
label: galaxy-job-config-init_galaxy-job-config-init-summary
doc: "A tool to initialize Galaxy job configurations. Note: The provided help text
  appears to be an error log from a container execution and does not contain usage
  information or argument definitions.\n\nTool homepage: https://github.com/galaxyproject/galaxy-job-config-init"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-job-config-init:0.1.3--pyhdfd78af_0
stdout: galaxy-job-config-init_galaxy-job-config-init-summary.out
