cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet
label: hymet
doc: "The provided text does not contain help information for the tool 'hymet'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.2.1--hdfd78af_0
stdout: hymet.out
