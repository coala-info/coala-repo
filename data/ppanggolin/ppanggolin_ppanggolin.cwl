cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin
label: ppanggolin_ppanggolin
doc: "ppanggolin: error: argument : invalid choice: 'ppanggolin' (choose from 'annotate',
  'cluster', 'graph', 'partition', 'rarefaction', 'workflow', 'panrgp', 'panmodule',
  'all', 'draw', 'write_pangenome', 'write_genomes', 'write_metadata', 'fasta', 'msa',
  'metrics', 'align', 'rgp', 'spot', 'module', 'context', 'projection', 'rgp_cluster',
  'metadata', 'info', 'utils')\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
stdout: ppanggolin_ppanggolin.out
