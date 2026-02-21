cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe_hp_assemble
label: haphpipe_hp_assemble
doc: "Assemble reads into contigs (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_hp_assemble.out
