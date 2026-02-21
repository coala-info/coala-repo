cwlVersion: v1.2
class: CommandLineTool
baseCommand: agfusion_pyensembl
label: agfusion_pyensembl
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a system error log indicating a failure to build or extract
  a container image due to lack of disk space.\n\nTool homepage: https://github.com/murphycj/AGFusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agfusion:1.252--py_0
stdout: agfusion_pyensembl.out
