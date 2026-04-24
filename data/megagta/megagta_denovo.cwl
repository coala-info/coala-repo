cwlVersion: v1.2
class: CommandLineTool
baseCommand: denovo
label: megagta_denovo
doc: "no succinct de Bruijn graph name!\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: max_tip_len
    type:
      - 'null'
      - int
    doc: max length for tips to be removed. -1 for 2k
    inputBinding:
      position: 101
      prefix: --max_tip_len
  - id: min_contig
    type:
      - 'null'
      - int
    doc: min length of contig to output
    inputBinding:
      position: 101
      prefix: --min_contig
  - id: min_standalone
    type:
      - 'null'
      - int
    doc: min length of a standalone contig to output to final.contigs.fa
    inputBinding:
      position: 101
      prefix: --min_standalone
  - id: no_bubble
    type:
      - 'null'
      - boolean
    doc: do not remove bubbles
    inputBinding:
      position: 101
      prefix: --no_bubble
  - id: num_cpu_threads
    type:
      - 'null'
      - int
    doc: number of cpu threads
    inputBinding:
      position: 101
      prefix: --num_cpu_threads
  - id: output_prefix
    type: string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: sdbg_name
    type: string
    doc: succinct de Bruijn graph name
    inputBinding:
      position: 101
      prefix: --sdbg_name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_denovo.out
