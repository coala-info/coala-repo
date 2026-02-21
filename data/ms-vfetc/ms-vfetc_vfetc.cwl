cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms-vfetc_vfetc
label: ms-vfetc_vfetc
doc: "A tool from the ms-vfetc package (biocontainers/ms-vfetc). No specific help
  text was provided in the input to describe functionality.\n\nTool homepage: https://github.com/leidenuniv-lacdr-abs/ms-vfetc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ms-vfetc:phenomenal-v0.6_cv1.1.27
stdout: ms-vfetc_vfetc.out
