cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybigwig
label: pybigwig
doc: "A python extension for accessing BigWig files\n\nTool homepage: https://github.com/deeptools/pyBigWig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybigwig:0.3.25--py39h956d262_0
stdout: pybigwig.out
