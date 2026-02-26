cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimme
label: gimmemotifs-minimal_gimme
doc: "GimmeMotifs v0.18.1\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: motifs, scan, maelstrom, match,
      logo, cluster, background, threshold, location, diff, prediction, motif2factors'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the chosen subcommand
    inputBinding:
      position: 2
  - id: background
    type:
      - 'null'
      - boolean
    doc: create a background file
    inputBinding:
      position: 103
      prefix: background
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: cluster similar motifs
    inputBinding:
      position: 103
      prefix: cluster
  - id: diff
    type:
      - 'null'
      - boolean
    doc: compare motif frequency and enrichment between fasta files
    inputBinding:
      position: 103
      prefix: diff
  - id: location
    type:
      - 'null'
      - boolean
    doc: motif location histograms
    inputBinding:
      position: 103
      prefix: location
  - id: logo
    type:
      - 'null'
      - boolean
    doc: create sequence logo(s)
    inputBinding:
      position: 103
      prefix: logo
  - id: maelstrom
    type:
      - 'null'
      - boolean
    doc: find differential motifs
    inputBinding:
      position: 103
      prefix: maelstrom
  - id: match
    type:
      - 'null'
      - boolean
    doc: find motif matches in database
    inputBinding:
      position: 103
      prefix: match
  - id: motif2factors
    type:
      - 'null'
      - boolean
    doc: generate a motif database based on orthology for any species
    inputBinding:
      position: 103
      prefix: motif2factors
  - id: motifs
    type:
      - 'null'
      - boolean
    doc: identify enriched motifs (known and/or de novo)
    inputBinding:
      position: 103
      prefix: motifs
  - id: prediction
    type:
      - 'null'
      - boolean
    doc: predict motif function
    inputBinding:
      position: 103
      prefix: prediction
  - id: scan
    type:
      - 'null'
      - boolean
    doc: scan for known motifs
    inputBinding:
      position: 103
      prefix: scan
  - id: threshold
    type:
      - 'null'
      - boolean
    doc: calculate motif scan threshold
    inputBinding:
      position: 103
      prefix: threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
stdout: gimmemotifs-minimal_gimme.out
