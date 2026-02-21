cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngg_barbell
label: niemagraphgen_ngg_barbell
doc: "A tool for generating barbell graphs, part of the NiemaGraphGen suite. (Note:
  The provided text contains a system error message rather than command-line help
  documentation, so specific arguments could not be extracted.)\n\nTool homepage:
  https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_barbell.out
