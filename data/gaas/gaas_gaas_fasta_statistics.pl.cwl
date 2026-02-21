cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaas_gaas_fasta_statistics.pl
label: gaas_gaas_fasta_statistics.pl
doc: "A tool to calculate statistics for FASTA files. (Note: The provided input text
  contains system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/NBISweden/GAAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
stdout: gaas_gaas_fasta_statistics.pl.out
