cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstag
label: cstag
doc: "The provided text does not contain help information for the tool 'cstag'. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build or extract the image due to insufficient disk space ('no space left on
  device').\n\nTool homepage: https://github.com/akikuno/cstag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cstag:1.1.0--pyhdfd78af_1
stdout: cstag.out
