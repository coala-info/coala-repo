cwlVersion: v1.2
class: CommandLineTool
baseCommand: monopogen
label: monopogen
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/KChen-lab/Monopogen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monopogen:1.6.0--pyhdfd78af_0
stdout: monopogen.out
