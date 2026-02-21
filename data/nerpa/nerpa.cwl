cwlVersion: v1.2
class: CommandLineTool
baseCommand: nerpa
label: nerpa
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) attempting
  to pull the nerpa image from a container registry.\n\nTool homepage: https://cab.spbu.ru/software/nerpa/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nerpa:1.0.0--py39h2de1943_7
stdout: nerpa.out
