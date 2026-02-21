cwlVersion: v1.2
class: CommandLineTool
baseCommand: difcover_from_bams_to_unionbed.sh
label: difcover_from_bams_to_unionbed.sh
doc: "A script from the DifCover package to convert BAM files to unionbed format.
  (Note: The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/timnat/DifCover"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_bams_to_unionbed.sh.out
