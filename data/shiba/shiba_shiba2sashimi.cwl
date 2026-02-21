cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba2sashimi
label: shiba_shiba2sashimi
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or extract the container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba:0.8.1--py312hdfd78af_0
stdout: shiba_shiba2sashimi.out
