cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngg_erdos_renyi
label: niemagraphgen_ngg_erdos_renyi
doc: "A tool for generating Erdős-Rényi random graphs as part of the NiemaGraphGen
  suite.\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen_ngg_erdos_renyi.out
