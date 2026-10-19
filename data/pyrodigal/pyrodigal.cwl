cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrodigal
label: pyrodigal
doc: "Python port of Prodigal, an ORF finder for genomes and metagenomes.\n\nTool
  homepage: https://github.com/althonos/pyrodigal"
inputs:
  - id: translation_output_path
    type:
      - 'null'
      - string
    doc: Write protein translations to the selected file.
    inputBinding:
      position: 101
      prefix: -a
  - id: closed_ends
    type:
      - 'null'
      - boolean
    doc: Closed ends. Do not allow genes to run off edges.
    inputBinding:
      position: 101
      prefix: -c
  - id: nucleotide_output_path
    type:
      - 'null'
      - string
    doc: Write nucleotide sequences of genes to the selected file.
    inputBinding:
      position: 101
      prefix: -d
  - id: format
    type:
      - 'null'
      - string
    doc: Select output format (gbk or gff).
    inputBinding:
      position: 101
      prefix: -f
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Specify a translation table to use.
    inputBinding:
      position: 101
      prefix: -g
  - id: input
    type:
      - 'null'
      - File
    doc: Specify FASTA input file (plain or gzipped).
    inputBinding:
      position: 101
      prefix: -i
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Treat runs of N as masked sequence; don't build genes across them.
    inputBinding:
      position: 101
      prefix: -m
  - id: nosd
    type:
      - 'null'
      - boolean
    doc: Bypass Shine-Dalgarno trainer and force a full motif scan.
    inputBinding:
      position: 101
      prefix: -n
  - id: output_path
    type:
      - 'null'
      - string
    doc: Specify output file.
    inputBinding:
      position: 101
      prefix: -o
  - id: procedure
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta).
    inputBinding:
      position: 101
      prefix: -p
  - id: potential_genes_path
    type:
      - 'null'
      - string
    doc: Write all potential genes (with scores) to the selected file.
    inputBinding:
      position: 101
      prefix: -s
  - id: training_file
    type:
      - 'null'
      - File
    doc: Read and use the specified training file.
    inputBinding:
      position: 101
      prefix: -t
  - id: training_output_path
    type:
      - 'null'
      - string
    doc: Write a training file to this path (a training file is written when none exists).
    inputBinding:
      position: 101
      prefix: -t
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of threads to use if input contains multiple sequences.
    inputBinding:
      position: 101
      prefix: -j
  - id: min_gene
    type:
      - 'null'
      - int
    doc: The minimum gene length.
    inputBinding:
      position: 101
      prefix: --min-gene
  - id: min_edge_gene
    type:
      - 'null'
      - int
    doc: The minimum edge gene length.
    inputBinding:
      position: 101
      prefix: --min-edge-gene
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: The maximum number of nucleotides that can overlap between two genes on the same strand. This must be lower or equal to the minimum gene length.
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: no_stop_codon
    type:
      - 'null'
      - boolean
    doc: Disables translation of stop codons into star characters (*) for complete genes.
    inputBinding:
      position: 101
      prefix: --no-stop-codon
  - id: pool
    type:
      - 'null'
      - string
    doc: The sort of pool to use to process genomes in parallel (thread or process).
    inputBinding:
      position: 101
      prefix: --pool
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (gene predictions when no output file is given)
  - id: output
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output_path)
  - id: translation_output
    type:
      - 'null'
      - File
    doc: Protein translations.
    outputBinding:
      glob: $(inputs.translation_output_path)
  - id: nucleotide_output
    type:
      - 'null'
      - File
    doc: Nucleotide sequences of genes.
    outputBinding:
      glob: $(inputs.nucleotide_output_path)
  - id: potential_genes
    type:
      - 'null'
      - File
    doc: All potential genes with scores.
    outputBinding:
      glob: $(inputs.potential_genes_path)
  - id: training_output
    type:
      - 'null'
      - File
    doc: Training file.
    outputBinding:
      glob: $(inputs.training_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrodigal:3.7.0--py311haab0aaa_0
stdout: pyrodigal.out
