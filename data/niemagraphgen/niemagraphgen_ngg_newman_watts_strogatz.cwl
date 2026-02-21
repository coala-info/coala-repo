cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - niemagraphgen
  - ngg_newman_watts_strogatz
label: niemagraphgen_ngg_newman_watts_strogatz
doc: "A tool for generating Newman-Watts-Strogatz small-world graphs. (Note: The provided
  text contains system error messages regarding container image conversion and disk
  space, rather than the tool's help documentation.)\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_newman_watts_strogatz.out
