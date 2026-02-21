cwlVersion: v1.2
class: CommandLineTool
baseCommand: kfoots
label: kfoots
doc: "The provided text does not contain help information for the tool 'kfoots'. It
  contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: http://github.com/lamortenera/kfoots"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kfoots:1.0--r44h7b50bb2_11
stdout: kfoots.out
