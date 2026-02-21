cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_barcode_splitter.pl
label: fastx_toolkit_fastx_barcode_splitter.pl
doc: "A tool from the FASTX-toolkit for splitting FASTX files into multiple files
  based on barcode sequences.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx_toolkit_fastx_barcode_splitter.pl.out
