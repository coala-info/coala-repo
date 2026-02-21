cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_windows_fw_group
label: fasta_windows_fw_group
doc: "A tool for calculating statistics (like GC content) in sliding windows over
  FASTA files. (Note: The provided help text contains only system error messages and
  does not list specific arguments).\n\nTool homepage: https://github.com/tolkit/fasta_windows"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta_windows:0.2.4--hec16e2b_0
stdout: fasta_windows_fw_group.out
