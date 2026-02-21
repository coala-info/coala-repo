cwlVersion: v1.2
class: CommandLineTool
baseCommand: vqbg
label: vqbg
doc: "Variant Quality Binning and Grouping (Note: The provided text is an error log
  from a container build process and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/qdu-bioinfo/VQBG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vqbg:1.0.2--h884bc47_0
stdout: vqbg.out
