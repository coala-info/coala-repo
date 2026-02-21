cwlVersion: v1.2
class: CommandLineTool
baseCommand: duphist
label: duphist
doc: "A tool for generating duplicate histograms. (Note: The provided input text contains
  system error messages regarding a container runtime failure and does not include
  the actual help documentation for the tool.)\n\nTool homepage: https://github.com/minjeongjj/DupHIST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duphist:1.0.9--hdfd78af_0
stdout: duphist.out
