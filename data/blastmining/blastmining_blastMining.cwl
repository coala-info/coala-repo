cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastMining
label: blastmining_blastMining
doc: "BLAST outfmt 6 only:\n(\"qseqid\",\"sseqid\",\"pident\",\"length\",\"mismatch\"\
  ,\"gapopen\",\"evalue\",\"bitscore\",\"staxid\")\n\nTool homepage: https://github.com/NuruddinKhoiry/blastMining"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run: vote, voteSpecies, lca, besthit, full_pipeline'
    inputBinding:
      position: 1
  - id: besthit
    type:
      - 'null'
      - boolean
    doc: 'blastMining: besthit method'
    inputBinding:
      position: 102
  - id: full_pipeline
    type:
      - 'null'
      - boolean
    doc: 'blastMining: Running BLAST + mining the output'
    inputBinding:
      position: 102
  - id: lca
    type:
      - 'null'
      - boolean
    doc: 'blastMining: lca method'
    inputBinding:
      position: 102
  - id: vote
    type:
      - 'null'
      - boolean
    doc: 'blastMining: voting method with pident cut-off'
    inputBinding:
      position: 102
  - id: voteSpecies
    type:
      - 'null'
      - boolean
    doc: 'blastMining: vote at species level for all'
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
stdout: blastmining_blastMining.out
