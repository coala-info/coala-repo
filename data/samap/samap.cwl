cwlVersion: v1.2
class: CommandLineTool
baseCommand: samap
label: samap
doc: "SAMap (Self-Assembling Manifolds) is a tool for integrating single-cell RNA-seq
  data across species. Note: The provided text appears to be a container build log
  rather than CLI help text, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/atarashansky/SAMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samap:1.0.15--pyhdfd78af_0
stdout: samap.out
