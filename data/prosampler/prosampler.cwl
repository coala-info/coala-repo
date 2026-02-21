cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosampler
label: prosampler
doc: "The provided text is a container execution error log and does not contain help
  information or usage instructions for the tool 'prosampler'.\n\nTool homepage: https://github.com/zhengchangsulab/ProSampler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosampler:1.5--h9948957_2
stdout: prosampler.out
