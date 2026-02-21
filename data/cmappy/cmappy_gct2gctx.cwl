cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmappy_gct2gctx
label: cmappy_gct2gctx
doc: "Convert GCT files to GCTX format.\n\nTool homepage: https://github.com/cmap/cmapPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmappy:4.0.1--py39h2de1943_8
stdout: cmappy_gct2gctx.out
