cwlVersion: v1.2
class: CommandLineTool
baseCommand: libmuscle
label: libmuscle
doc: "The provided text does not contain help information or a description of the
  tool; it contains a container runtime error (Apptainer/Singularity) indicating a
  failure to pull the image due to lack of disk space.\n\nTool homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libmuscle:3.7--h503566f_2
stdout: libmuscle.out
