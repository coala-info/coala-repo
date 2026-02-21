cwlVersion: v1.2
class: CommandLineTool
baseCommand: campyagainst_campygstyper
label: campyagainst_campygstyper
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process indicating a
  'no space left on device' failure.\n\nTool homepage: https://github.com/LanLab/campyagainst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/campyagainst:0.1.0--pyhdfd78af_0
stdout: campyagainst_campygstyper.out
