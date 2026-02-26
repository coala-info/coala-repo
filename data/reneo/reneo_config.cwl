cwlVersion: v1.2
class: CommandLineTool
baseCommand: reneo_config
label: reneo_config
doc: "Copy system default config to reneo.out/config.yaml\n\nTool homepage: https://github.com/Vini2/phables"
inputs:
  - id: configfile
    type: File
    doc: Path to the configuration file to be copied.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reneo:0.5.0--pyhdfd78af_0
stdout: reneo_config.out
