cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrodigal-rv
label: pyrodigal-rv
doc: "pyrodigal-rv [-a trans_file] [-c] [-d nuc_file] [-f output_type]\n         \
  \           [-g tr_table] [-i input_file] [-m] [-n] [-o output_file]\n         \
  \           [-p mode] [-s start_file] [-t training_file] [-j jobs]\n           \
  \         [-h] [-V] [--min-gene MIN_GENE]\n                    [--min-edge-gene
  MIN_EDGE_GENE]\n                    [--max-overlap MAX_OVERLAP] [--no-stop-codon]\n\
  \                    [--pool {thread,process}]\n\nTool homepage: https://github.com/LanderDC/pyrodigal-rv"
inputs:
  - id: closed_ends
    type:
      - 'null'
      - boolean
    doc: Closed ends. Do not allow genes to run off edges.
    inputBinding:
      position: 101
      prefix: -c
  - id: force_motif_scan
    type:
      - 'null'
      - boolean
    doc: "Bypass Shine-Dalgarno trainer and force a full motif\n                 \
      \       scan."
    inputBinding:
      position: 101
      prefix: -n
  - id: input_file
    type:
      - 'null'
      - File
    doc: Specify FASTA input file.
    inputBinding:
      position: 101
      prefix: -i
  - id: jobs
    type:
      - 'null'
      - int
    doc: "The number of threads to use if input contains\n                       \
      \ multiple sequences."
    inputBinding:
      position: 101
      prefix: --jobs
  - id: masked_sequence
    type:
      - 'null'
      - boolean
    doc: "Treat runs of N as masked sequence; don't build genes\n                \
      \        across them."
    inputBinding:
      position: 101
      prefix: -m
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: "The maximum number of nucleotides that can overlap\n                   \
      \     between two genes on the same strand. This must be\n                 \
      \       lower or equal to the minimum gene length."
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: min_edge_gene
    type:
      - 'null'
      - int
    doc: The minimum edge gene length.
    inputBinding:
      position: 101
      prefix: --min-edge-gene
  - id: min_gene
    type:
      - 'null'
      - int
    doc: The minimum gene length.
    inputBinding:
      position: 101
      prefix: --min-gene
  - id: mode
    type:
      - 'null'
      - string
    doc: Select procedure.
    inputBinding:
      position: 101
      prefix: -p
  - id: no_stop_codon
    type:
      - 'null'
      - boolean
    doc: "Disables translation of stop codons into star\n                        characters
      (*) for complete genes."
    inputBinding:
      position: 101
      prefix: --no-stop-codon
  - id: nuc_file
    type:
      - 'null'
      - File
    doc: "Write nucleotide sequences of genes to the selected\n                  \
      \      file."
    inputBinding:
      position: 101
      prefix: -d
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file.
    inputBinding:
      position: 101
      prefix: -o
  - id: output_type
    type:
      - 'null'
      - string
    doc: Select output format.
    inputBinding:
      position: 101
      prefix: -f
  - id: pool
    type:
      - 'null'
      - string
    doc: "The sort of pool to use to process genomes in\n                        parallel.
      Processes may be faster than threads on some\n                        machines,
      refer to documentation."
    inputBinding:
      position: 101
      prefix: --pool
  - id: start_file
    type:
      - 'null'
      - File
    doc: "Write all potential genes (with scores) to the\n                       \
      \ selected file."
    inputBinding:
      position: 101
      prefix: -s
  - id: tr_table
    type:
      - 'null'
      - string
    doc: Specify a translation table to use.
    inputBinding:
      position: 101
      prefix: -g
  - id: training_file
    type:
      - 'null'
      - File
    doc: "Write a training file (if none exists); otherwise,\n                   \
      \     read and use the specified training file."
    inputBinding:
      position: 101
      prefix: -t
  - id: trans_file
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file.
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrodigal-rv:0.1.0--pyh7e72e81_0
stdout: pyrodigal-rv.out
