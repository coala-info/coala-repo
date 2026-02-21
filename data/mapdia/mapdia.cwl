cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapdia
label: mapdia
doc: "A tool for differential protein expression analysis using Mass Spectrometry
  data. (Note: The provided help text contains only system error messages and no usage
  information.)\n\nTool homepage: http://sourceforge.net/projects/mapdia/."
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapdia:3.1.0--h503566f_7
stdout: mapdia.out
