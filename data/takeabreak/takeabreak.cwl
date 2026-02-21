cwlVersion: v1.2
class: CommandLineTool
baseCommand: takeabreak
label: takeabreak
doc: "The provided text does not contain help information or a description of the
  tool; it consists of error logs from a container runtime (Apptainer/Singularity)
  failing to fetch the tool's image.\n\nTool homepage: https://colibread.inria.fr/software/takeabreak/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/takeabreak:1.1.2--h5ca1c30_8
stdout: takeabreak.out
