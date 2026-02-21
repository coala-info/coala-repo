cwlVersion: v1.2
class: CommandLineTool
baseCommand: roguenarok
label: roguenarok
doc: "A tool for identifying rogue taxa in phylogenetic tree sets (Note: The provided
  text contains container build logs and error messages rather than the tool's help
  documentation).\n\nTool homepage: https://github.com/aberer/RogueNaRok"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/roguenarok:v1.0-3-deb_cv1
stdout: roguenarok.out
