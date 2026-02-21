cwlVersion: v1.2
class: CommandLineTool
baseCommand: zol-scape
label: zol_zol-scape
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  failure.\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
stdout: zol_zol-scape.out
