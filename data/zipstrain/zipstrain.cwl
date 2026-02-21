cwlVersion: v1.2
class: CommandLineTool
baseCommand: zipstrain
label: zipstrain
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/OlmLab/ZipStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zipstrain:0.3.1--pyhdfd78af_0
stdout: zipstrain.out
