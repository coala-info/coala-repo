cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapog
label: hapog
doc: "Haplotype-Aware Polishing of Genomes\n\nTool homepage: https://github.com/institut-de-genomique/HAPO-G"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapog:1.3.8--py39hb49fbdb_3
stdout: hapog.out
