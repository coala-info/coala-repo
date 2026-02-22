cwlVersion: v1.2
class: CommandLineTool
baseCommand: assemblerflow
label: assemblerflow
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process (Singularity/OCI)
  due to insufficient disk space.\n\nTool homepage: https://github.com/ODiogoSilva/assemblerflow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblerflow:1.1.0.post3--py35_1
stdout: assemblerflow.out
