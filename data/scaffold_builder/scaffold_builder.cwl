cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaffold_builder
label: scaffold_builder
doc: "A tool for scaffolding contigs using a reference genome.\n\nTool homepage: http://edwards.sdsu.edu/scaffold_builder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaffold_builder:2.3--pyhdfd78af_0
stdout: scaffold_builder.out
