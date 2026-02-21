cwlVersion: v1.2
class: CommandLineTool
baseCommand: spingo_vault
label: spingo_vault
doc: "The provided text appears to be error logs from a container build process (Apptainer/Singularity)
  rather than help text for the tool 'spingo_vault'. No usage information or arguments
  could be extracted.\n\nTool homepage: https://github.com/homedepot/spingo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spingo:1.3
stdout: spingo_vault.out
