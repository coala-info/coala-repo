cwlVersion: v1.2
class: CommandLineTool
baseCommand: genefuse
label: genefuse
doc: "GeneFuse is a tool for detecting gene fusions from NGS data. (Note: The provided
  help text contains system error messages regarding a container execution failure
  and does not list command-line arguments.)\n\nTool homepage: https://github.com/OpenGene/genefuse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genefuse:0.8.0--h5ca1c30_4
stdout: genefuse.out
