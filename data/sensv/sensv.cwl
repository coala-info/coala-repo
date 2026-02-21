cwlVersion: v1.2
class: CommandLineTool
baseCommand: sensv
label: sensv
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sensv'. It consists of error logs from a failed container build process
  (Apptainer/Singularity) due to insufficient disk space.\n\nTool homepage: https://github.com/HKU-BAL/SENSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sensv:1.0.4--h43eeafb_2
stdout: sensv.out
