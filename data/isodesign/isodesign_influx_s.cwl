cwlVersion: v1.2
class: CommandLineTool
baseCommand: isodesign_influx_s
label: isodesign_influx_s
doc: "The provided text contains system log messages and a fatal error regarding container
  image conversion and disk space, rather than the help documentation for the tool
  'isodesign_influx_s'. As a result, no command-line arguments could be extracted.\n
  \nTool homepage: https://github.com/MetaboHUB-MetaToul-FluxoMet/IsoDesign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isodesign:2.0.3--pyhdfd78af_0
stdout: isodesign_influx_s.out
