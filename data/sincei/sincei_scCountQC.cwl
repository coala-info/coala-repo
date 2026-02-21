cwlVersion: v1.2
class: CommandLineTool
baseCommand: sincei_scCountQC
label: sincei_scCountQC
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log.\n\nTool homepage: https://github.com/bhardwaj-lab/sincei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sincei:0.5.2--pyhdfd78af_0
stdout: sincei_scCountQC.out
