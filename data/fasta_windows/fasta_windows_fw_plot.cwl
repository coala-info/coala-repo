cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_windows_fw_plot
label: fasta_windows_fw_plot
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding container image building and disk space issues.\n
  \nTool homepage: https://github.com/tolkit/fasta_windows"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta_windows:0.2.4--hec16e2b_0
stdout: fasta_windows_fw_plot.out
