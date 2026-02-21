cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_barcode_splitter.pl
label: fastx-toolkit_fastx_barcode_splitter.pl
doc: "FASTX Barcode Splitter (Note: The provided help text contains a system error
  and does not list tool arguments.)\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastx_barcode_splitter.pl.out
