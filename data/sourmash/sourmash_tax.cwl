cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash_tax
label: sourmash_tax
doc: "Integrate taxonomy information based on 'gather' results\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: annotate gather results with taxonomy information
    inputBinding:
      position: 101
      prefix: sourmash tax annotate
  - id: genome
    type:
      - 'null'
      - boolean
    doc: classify genomes from gather results
    inputBinding:
      position: 101
      prefix: sourmash tax genome
  - id: grep
    type:
      - 'null'
      - boolean
    doc: search taxonomies and output picklists.
    inputBinding:
      position: 101
      prefix: sourmash tax grep
  - id: metagenome
    type:
      - 'null'
      - boolean
    doc: summarize metagenome gather results
    inputBinding:
      position: 101
      prefix: sourmash tax metagenome
  - id: prepare
    type:
      - 'null'
      - boolean
    doc: combine multiple taxonomy databases into one.
    inputBinding:
      position: 101
      prefix: sourmash tax prepare
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: summarize taxonomy/lineage information
    inputBinding:
      position: 101
      prefix: sourmash tax summarize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
stdout: sourmash_tax.out
