cwlVersion: v1.2
class: CommandLineTool
baseCommand: linkstats
label: linkstats
doc: "The provided text is an error log from a container runtime and does not contain
  the help documentation for the linkstats tool. As a result, no arguments or tool
  descriptions could be extracted.\n\nTool homepage: https://github.com/wtsi-hpag/LinkStats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkstats:0.1.3--py39ha3fbd26_2
stdout: linkstats.out
