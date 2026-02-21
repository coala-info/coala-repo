cwlVersion: v1.2
class: CommandLineTool
baseCommand: FRCbam
label: frc_align_FRCbam
doc: "The provided text contains system error messages related to a container environment
  (Singularity/Apptainer) and does not include the actual help documentation for the
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/vezzi/FRC_align"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
stdout: frc_align_FRCbam.out
