cwlVersion: v1.2
class: CommandLineTool
baseCommand: troika
label: troika-tb_troika
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  or fetch the image due to insufficient disk space.\n\nTool homepage: https://github.com/kristyhoran/troika"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/troika-tb:0.0.5--py_0
stdout: troika-tb_troika.out
