cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep_detect
label: tadrep_detect
doc: "Detects plasmids in a draft genome.\n\nTool homepage: https://github.com/oschwengers/tadrep"
inputs:
  - id: gap_sequence_length
    type:
      - 'null'
      - int
    doc: Gap sequence N length
    default: 10
    inputBinding:
      position: 101
      prefix: --gap-sequence-length
  - id: genome
    type:
      - 'null'
      - type: array
        items: File
    doc: Draft genome path
    inputBinding:
      position: 101
      prefix: --genome
  - id: min_contig_coverage
    type:
      - 'null'
      - int
    doc: Minimal contig coverage
    default: 90
    inputBinding:
      position: 101
      prefix: --min-contig-coverage
  - id: min_contig_identity
    type:
      - 'null'
      - int
    doc: Maximal contig identity
    default: 90
    inputBinding:
      position: 101
      prefix: --min-contig-identity
  - id: min_plasmid_coverage
    type:
      - 'null'
      - int
    doc: Minimal plasmid coverage
    default: 80
    inputBinding:
      position: 101
      prefix: --min-plasmid-coverage
  - id: min_plasmid_identity
    type:
      - 'null'
      - int
    doc: Minimal plasmid identity
    default: 90
    inputBinding:
      position: 101
      prefix: --min-plasmid-identity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_detect.out
