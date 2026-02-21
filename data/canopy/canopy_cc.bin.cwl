cwlVersion: v1.2
class: CommandLineTool
baseCommand: canopy_cc.bin
label: canopy_cc.bin
doc: "The provided text does not contain help information or a description for the
  tool; it is a log of a failed container build process (Apptainer/Singularity) due
  to insufficient disk space.\n\nTool homepage: https://github.com/hildebra/canopy2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canopy:0.25--h077b44d_1
stdout: canopy_cc.bin.out
