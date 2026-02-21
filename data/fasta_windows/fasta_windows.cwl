cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_windows
label: fasta_windows
doc: "A tool for calculating statistics (like GC content) over windows of a FASTA
  file. (Note: The provided help text contains only container execution errors and
  does not list specific arguments.)\n\nTool homepage: https://github.com/tolkit/fasta_windows"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta_windows:0.2.4--hec16e2b_0
stdout: fasta_windows.out
