cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydmtools
label: pydmtools
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to fetch the image.\n\nTool homepage: https://github.com/ZhouQiangwei/pydmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydmtools:0.1.1--py310h79000e5_1
stdout: pydmtools.out
