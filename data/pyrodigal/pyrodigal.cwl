cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrodigal
label: pyrodigal
doc: "Python port of Prodigal, an ORF finder for genomes and metagenomes.\n\nTool
  homepage: https://github.com/althonos/pyrodigal"
inputs:
  - id: closed_ends
    type:
      - 'null'
      - boolean
    doc: Closed ends. Do not allow genes to run off edges
    inputBinding:
      position: 101
      prefix: --closed-ends
  - id: format
    type:
      - 'null'
      - string
    doc: Select output format (gbk, gff, or sco)
    default: gbk
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type:
      - 'null'
      - File
    doc: 'Input file (default: stdin)'
    inputBinding:
      position: 101
      prefix: --input
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Treat runs of N as masked sequence
    inputBinding:
      position: 101
      prefix: --mask
  - id: nosd
    type:
      - 'null'
      - boolean
    doc: Bypass Shine-Dalgarno trainer and force a scan
    inputBinding:
      position: 101
      prefix: --nosd
  - id: procedure
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta)
    default: single
    inputBinding:
      position: 101
      prefix: --procedure
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in quiet mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: training_file
    type:
      - 'null'
      - File
    doc: Specify a training file to use (single mode only)
    inputBinding:
      position: 101
      prefix: --train
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Specify a translation table to use
    default: 11
    inputBinding:
      position: 101
      prefix: --translation-table
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output)
  - id: translation_output
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file
    outputBinding:
      glob: $(inputs.translation_output)
  - id: nucleotide_output
    type:
      - 'null'
      - File
    doc: Write nucleotide sequences of genes to the selected file
    outputBinding:
      glob: $(inputs.nucleotide_output)
  - id: potential_genes
    type:
      - 'null'
      - File
    doc: Write all potential genes (with scores) to the selected file
    outputBinding:
      glob: $(inputs.potential_genes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrodigal:3.7.0--py311haab0aaa_0
