cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaffold_builder_scaffold_builder.py
label: scaffold_builder_scaffold_builder.py
doc: "\nTool homepage: http://edwards.sdsu.edu/scaffold_builder"
inputs:
  - id: query_file
    type: File
    doc: query file
    inputBinding:
      position: 101
      prefix: -q
  - id: reference_file
    type: File
    doc: reference file
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaffold_builder:2.3--pyhdfd78af_0
stdout: scaffold_builder_scaffold_builder.py.out
