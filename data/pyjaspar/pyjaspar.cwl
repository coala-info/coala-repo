cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyjaspar
label: pyjaspar
doc: "A Python package for accessing and maniuplating JASPAR database motifs. (Note:
  The provided text appears to be a container runtime error log rather than a help
  menu, so no arguments could be extracted.)\n\nTool homepage: https://github.com/asntech/pyjaspar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyjaspar:4.0.0--pyhdfd78af_0
stdout: pyjaspar.out
