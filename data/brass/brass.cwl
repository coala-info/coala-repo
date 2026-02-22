cwlVersion: v1.2
class: CommandLineTool
baseCommand: brass
label: brass
doc: "The provided text does not contain help information or usage instructions for
  the tool 'brass'. It consists of system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull or build a SIF image due to lack of disk
  space.\n\nTool homepage: https://github.com/fonsecapeter/brass_mono"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brass:5.1.6--2
stdout: brass.out
