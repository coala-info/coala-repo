cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhg_genome-to-blast-db
label: mhg_genome-to-blast-db
doc: "Convert genome to BLAST database\n\nTool homepage: https://github.com/NakhlehLab/Maximal-Homologous-Groups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
stdout: mhg_genome-to-blast-db.out
