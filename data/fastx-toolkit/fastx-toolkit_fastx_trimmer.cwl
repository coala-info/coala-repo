cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_trimmer
label: fastx-toolkit_fastx_trimmer
doc: "FASTX Trimmer: Trims sequences in a FASTA/FASTQ file.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastx_trimmer.out
