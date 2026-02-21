cwlVersion: v1.2
class: CommandLineTool
baseCommand: rseg
label: rseg
doc: "The provided text does not contain help information for the 'rseg' tool. It
  is a log of a failed container build process (Singularity/Apptainer) attempting
  to fetch the rseg image from a container registry.\n\nTool homepage: https://github.com/yzhang/rseg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseg:0.4.9--he941832_1
stdout: rseg.out
