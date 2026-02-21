cwlVersion: v1.2
class: CommandLineTool
baseCommand: cami-amber_convert_fasta_bins_to_biobox_format.py
label: cami-amber_convert_fasta_bins_to_biobox_format.py
doc: "Convert FASTA bins to biobox format. (Note: The provided help text contains
  system error logs and does not list command-line arguments.)\n\nTool homepage: https://github.com/CAMI-challenge/AMBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
stdout: cami-amber_convert_fasta_bins_to_biobox_format.py.out
