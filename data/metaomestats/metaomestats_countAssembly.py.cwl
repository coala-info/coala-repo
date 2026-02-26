cwlVersion: v1.2
class: CommandLineTool
baseCommand: countAssembly.py
label: metaomestats_countAssembly.py
doc: "Count assembly statistics\n\nTool homepage: https://github.com/raw-lab/metaome_stats"
inputs:
  - id: fasta
    type: File
    doc: fasta file or folder
    inputBinding:
      position: 101
      prefix: --fasta
  - id: interval
    type: int
    doc: 'interval size in # of residues'
    inputBinding:
      position: 101
      prefix: --interval
  - id: ref
    type:
      - 'null'
      - string
    doc: reference genome
    inputBinding:
      position: 101
      prefix: --ref
  - id: size
    type:
      - 'null'
      - string
    doc: reference genome size
    inputBinding:
      position: 101
      prefix: --size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaomestats:0.4--pyh5e36f6f_0
stdout: metaomestats_countAssembly.py.out
