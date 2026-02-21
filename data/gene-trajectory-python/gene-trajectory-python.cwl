cwlVersion: v1.2
class: CommandLineTool
baseCommand: gene-trajectory-python
label: gene-trajectory-python
doc: "A tool for gene trajectory analysis (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/KlugerLab/GeneTrajectory-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gene-trajectory-python:1.0.4--pyhdfd78af_0
stdout: gene-trajectory-python.out
