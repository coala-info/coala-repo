cwlVersion: v1.2
class: CommandLineTool
baseCommand: zeroc-ice
label: zeroc-ice
doc: "The provided text does not contain CLI help information; it is a log of a failed
  container build/fetch process for the ZeroC Ice framework.\n\nTool homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice.out
