cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngs-smap
  - smap
label: ngs-smap_smap
doc: "The provided text does not contain help information for the tool, but rather
  a fatal error message regarding container image conversion and disk space issues.\n
  \nTool homepage: https://gitlab.com/truttink/smap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
stdout: ngs-smap_smap.out
