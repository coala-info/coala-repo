cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrunzip
label: lrzip_lrunzip
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the tool lrzip_lrunzip.\n
  \nTool homepage: https://github.com/ckolivas/lrzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrzip:0.651--h32784b6_1
stdout: lrzip_lrunzip.out
