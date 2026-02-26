cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl /usr/local/bin/gaas_create_annotation_project.pl
label: gaas_gaas_create_annotation_project.pl
doc: "A fasta file for genome assembly must be provided (-g)\n\nTool homepage: https://github.com/NBISweden/GAAS"
inputs:
  - id: assembly_version
    type:
      - 'null'
      - string
    doc: assembly version
    inputBinding:
      position: 101
      prefix: -v
  - id: genome_fa
    type: File
    doc: genome.fa
    inputBinding:
      position: 101
      prefix: -g
  - id: species_name
    type:
      - 'null'
      - string
    doc: species name
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
stdout: gaas_gaas_create_annotation_project.pl.out
