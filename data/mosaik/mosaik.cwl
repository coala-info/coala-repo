cwlVersion: v1.2
class: CommandLineTool
baseCommand: mosaik
label: mosaik
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the SIF image due to insufficient disk space. It does
  not contain CLI help information or argument definitions.\n\nTool homepage: https://github.com/Global-Policy-Lab/mosaiks-paper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaik:2.2.26--3
stdout: mosaik.out
