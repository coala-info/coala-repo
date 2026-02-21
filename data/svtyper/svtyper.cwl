cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtyper
label: svtyper
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to fetch the svtyper image.\n\nTool homepage: https://github.com/hall-lab/svtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtyper:0.7.1--py_0
stdout: svtyper.out
