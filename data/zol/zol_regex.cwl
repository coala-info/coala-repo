cwlVersion: v1.2
class: CommandLineTool
baseCommand: zol_regex
label: zol_regex
doc: "The provided text does not contain help information or usage instructions; it
  is a container runtime error log reporting a failure to fetch or build the OCI image.\n
  \nTool homepage: https://github.com/Kalan-Lab/zol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
stdout: zol_regex.out
