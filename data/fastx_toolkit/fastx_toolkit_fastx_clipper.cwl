cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_clipper
label: fastx_toolkit_fastx_clipper
doc: "FASTX Clipper: Removes adapter sequences from FASTQ/FASTA files.\n\nTool homepage:
  https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx_toolkit_fastx_clipper.out
