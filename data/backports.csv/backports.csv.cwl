cwlVersion: v1.2
class: CommandLineTool
baseCommand: backports.csv
label: backports.csv
doc: "The provided text does not contain help information for the tool. It consists
  of Apptainer/Singularity build logs and a fatal error indicating that the executable
  'backports.csv' was not found in the system PATH.\n\nTool homepage: https://github.com/ryanhiebert/backports.csv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/backports.csv:1.0.1--py36_0
stdout: backports.csv.out
