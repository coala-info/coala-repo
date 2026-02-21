cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruamel.ordereddict
label: ruamel.ordereddict
doc: "A drop-in replacement for Python's OrderedDict that is sorted by key.\n\nTool
  homepage: https://github.com/ruamel/ordereddict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruamel.ordereddict:0.4.6--py27_0
stdout: ruamel.ordereddict.out
