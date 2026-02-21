cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_reverse_complement
label: fastx-toolkit_fastx_reverse_complement
doc: "Part of the FASTX-Toolkit; used to reverse-complement sequences in FASTA/FASTQ
  files. (Note: The provided help text contains only system error messages and no
  tool-specific argument information).\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastx_reverse_complement.out
