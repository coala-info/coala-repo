cwlVersion: v1.2
class: CommandLineTool
baseCommand: multivelo
label: multivelo
doc: "Multimodal RNA velocity and chromatin accessibility analysis\n\nTool homepage:
  https://github.com/welch-lab/MultiVelo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multivelo:0.1.3--pyhdfd78af_0
stdout: multivelo.out
