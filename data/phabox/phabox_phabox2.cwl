cwlVersion: v1.2
class: CommandLineTool
baseCommand: phabox2
label: phabox_phabox2
doc: "PhaBOX: A tool for phage analysis (Note: The provided help text contains only
  system error logs regarding a failed container build and does not list command-line
  arguments).\n\nTool homepage: https://github.com/KennthShang/PhaBOX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phabox:2.1.13--pyhdfd78af_0
stdout: phabox_phabox2.out
