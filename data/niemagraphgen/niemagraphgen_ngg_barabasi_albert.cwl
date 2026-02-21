cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngg
  - barabasi_albert
label: niemagraphgen_ngg_barabasi_albert
doc: "A tool for generating Barabasi-Albert graphs. (Note: The provided text is a
  system error message regarding container execution and does not contain help documentation
  or argument definitions).\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_barabasi_albert.out
