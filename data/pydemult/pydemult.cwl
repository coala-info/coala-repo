cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydemult
label: pydemult
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help text or usage information for the tool 'pydemult'.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/jenzopr/pydemult"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydemult:0.6--py_0
stdout: pydemult.out
