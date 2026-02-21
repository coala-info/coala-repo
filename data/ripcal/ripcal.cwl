cwlVersion: v1.2
class: CommandLineTool
baseCommand: ripcal
label: ripcal
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to fetch the image.\n\nTool homepage: https://sourceforge.net/projects/ripcal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ripcal:2.0--hdfd78af_0
stdout: ripcal.out
