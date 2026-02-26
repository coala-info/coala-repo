cwlVersion: v1.2
class: CommandLineTool
baseCommand: phables config
label: phables_config
doc: "Copy system default config to phables.out/config.yaml\n\nTool homepage: https://github.com/Vini2/phables"
inputs:
  - id: configfile
    type: File
    doc: Path to the configuration file to copy
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phables:1.5.0--pyhdfd78af_0
stdout: phables_config.out
