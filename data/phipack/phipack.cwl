cwlVersion: v1.2
class: CommandLineTool
baseCommand: phipack
label: phipack
doc: "The provided text does not contain help information for the tool; it contains
  system error logs from a container runtime (Apptainer/Singularity) indicating a
  failure to fetch the image.\n\nTool homepage: http://www.maths.otago.ac.nz/~dbryant/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phipack:1.1--h779adbc_1
stdout: phipack.out
