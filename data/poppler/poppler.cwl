cwlVersion: v1.2
class: CommandLineTool
baseCommand: poppler
label: poppler
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process (Apptainer/Singularity) while attempting
  to fetch the poppler image.\n\nTool homepage: https://github.com/oschwartz10612/poppler-windows"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppler:25.07.0
stdout: poppler.out
