cwlVersion: v1.2
class: CommandLineTool
baseCommand: spingo
label: spingo
doc: "The provided text is an error log from a container execution environment (Apptainer/Singularity)
  and does not contain help text or usage information for the tool 'spingo'.\n\nTool
  homepage: https://github.com/homedepot/spingo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spingo:1.3
stdout: spingo.out
