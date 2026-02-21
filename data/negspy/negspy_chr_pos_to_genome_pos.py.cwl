cwlVersion: v1.2
class: CommandLineTool
baseCommand: negspy_chr_pos_to_genome_pos.py
label: negspy_chr_pos_to_genome_pos.py
doc: "A tool to convert chromosome positions to genome-wide positions using the negspy
  library. Note: The provided help text contains only system error messages regarding
  container execution and disk space; no specific arguments could be extracted from
  the input.\n\nTool homepage: https://github.com/pkerpedjiev/negspy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
stdout: negspy_chr_pos_to_genome_pos.py.out
