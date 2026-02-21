cwlVersion: v1.2
class: CommandLineTool
baseCommand: cain
label: cain
doc: "A tool for the stochastic simulation of chemical reaction networks (inferred
  from biocontainers/cain). Note: The provided text is a system error log and does
  not contain CLI help information.\n\nTool homepage: https://github.com/CainKernel/CainCamera"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cain:v1.10dfsg-3-deb_cv1
stdout: cain.out
