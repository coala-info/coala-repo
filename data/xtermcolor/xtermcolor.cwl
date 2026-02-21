cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtermcolor
label: xtermcolor
doc: "The provided text does not contain help information for xtermcolor; it is a
  log of a failed container build attempt. No arguments or descriptions could be extracted
  from the input.\n\nTool homepage: https://github.com/broadinstitute/xtermcolor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtermcolor:1.3--py36_0
stdout: xtermcolor.out
