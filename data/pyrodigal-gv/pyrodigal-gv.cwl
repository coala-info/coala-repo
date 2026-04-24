cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrodigal-gv
label: pyrodigal-gv
doc: "Find genes in nucleotide sequences.\n\nTool homepage: https://github.com/althonos/pyrodigal-gv"
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
    doc: Bypass Shine-Dalgarno trainer and force a full motif scan.
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
    doc: The number of threads to use if input contains multiple sequences.
    inputBinding:
      position: 101
      prefix: --jobs
  - id: masked_sequence
    type:
      - 'null'
      - boolean
    doc: Treat runs of N as masked sequence; don't build genes across them.
    inputBinding:
      position: 101
      prefix: -m
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: The maximum number of nucleotides that can overlap between two genes on
      the same strand. This must be lower or equal to the minimum gene length.
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
    doc: Disables translation of stop codons into star characters (*) for 
      complete genes.
    inputBinding:
      position: 101
      prefix: --no-stop-codon
  - id: nuc_file
    type:
      - 'null'
      - File
    doc: Write nucleotide sequences of genes to the selected file.
    inputBinding:
      position: 101
      prefix: -d
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
    doc: The sort of pool to use to process genomes in parallel. Processes may 
      be faster than threads on some machines, refer to documentation.
    inputBinding:
      position: 101
      prefix: --pool
  - id: start_file
    type:
      - 'null'
      - File
    doc: Write all potential genes (with scores) to the selected file.
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
    doc: Write a training file (if none exists); otherwise, read and use the 
      specified training file.
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
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrodigal-gv:0.3.2--pyh7e72e81_0
