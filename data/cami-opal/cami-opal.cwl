cwlVersion: v1.2
class: CommandLineTool
baseCommand: opal.py
label: cami-opal
doc: "The provided text is a system error log (out of disk space) and does not contain
  help documentation or argument definitions for the tool. OPAL (cami-opal) is typically
  used for assessing metagenome profilers.\n\nTool homepage: https://github.com/CAMI-challenge/OPAL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-opal:1.0.13--pyhdfd78af_0
stdout: cami-opal.out
