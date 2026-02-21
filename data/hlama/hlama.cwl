cwlVersion: v1.2
class: CommandLineTool
baseCommand: hlama
label: hlama
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or command-line arguments for the tool 'hlama'.\n
  \nTool homepage: https://github.com/bihealth/hlama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlama:3.0.1--py35_0
stdout: hlama.out
