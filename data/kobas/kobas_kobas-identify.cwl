cwlVersion: v1.2
class: CommandLineTool
baseCommand: kobas-identify
label: kobas_kobas-identify
doc: "The provided text does not contain help information for the tool, as it is an
  error log indicating a failure to build the container image (no space left on device).\n
  \nTool homepage: http://kobas.cbi.pku.edu.cn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kobas:3.0.3--py27r3.4.1_0
stdout: kobas_kobas-identify.out
