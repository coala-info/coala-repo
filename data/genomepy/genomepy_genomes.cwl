cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomepy_genomes
label: genomepy_genomes
doc: "List all available genomes.\n\n  Returns the metadata of each found genome,
  including the availability of a\n  gene annotation. For UCSC, up to 4 gene annotation
  styles are available:\n  \"ncbiRefSeq\", \"refGene\", \"ensGene\", \"knownGene\"\
  \ (respectively).\n\nTool homepage: https://github.com/vanheeringen-lab/genomepy"
inputs:
  - id: provider
    type:
      - 'null'
      - string
    doc: provider
    inputBinding:
      position: 101
      prefix: --provider
  - id: show_size
    type:
      - 'null'
      - boolean
    doc: show absolute genome size
    inputBinding:
      position: 101
      prefix: --size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
stdout: genomepy_genomes.out
