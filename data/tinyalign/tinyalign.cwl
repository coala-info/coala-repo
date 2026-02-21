cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinyalign
label: tinyalign
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) failure.\n
  \nTool homepage: https://github.com/marcelm/tinyalign/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinyalign:0.2.2--py311haab0aaa_2
stdout: tinyalign.out
