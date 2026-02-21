cwlVersion: v1.2
class: CommandLineTool
baseCommand: dms
label: dms
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding disk space during a container
  build process.\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms.out
