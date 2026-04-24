cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangene
label: pangene
doc: "A tool for gene-based pangenome graph construction from PAF alignments\n\nTool
  homepage: https://github.com/lh3/pangene"
inputs:
  - id: input_paf
    type:
      type: array
      items: File
    doc: Input PAF file(s)
    inputBinding:
      position: 1
  - id: branch_cutting_iterations
    type:
      - 'null'
      - int
    doc: apply branch cutting for INT times
    inputBinding:
      position: 102
      prefix: -T
  - id: cut_branch_threshold
    type:
      - 'null'
      - float
    doc: cut a branching arc if weaker by FLOAT
    inputBinding:
      position: 102
      prefix: -B
  - id: cut_distant_branch_threshold
    type:
      - 'null'
      - float
    doc: cut a distant branching arc if weaker by FLOAT
    inputBinding:
      position: 102
      prefix: -y
  - id: demote_branch_threshold
    type:
      - 'null'
      - float
    doc: demote a branching arc if weaker than the best by FLOAT
    inputBinding:
      position: 102
      prefix: -b
  - id: dominant_gene_fraction
    type:
      - 'null'
      - float
    doc: gene considered if dominant in FLOAT fraction of genes
    inputBinding:
      position: 102
      prefix: -p
  - id: exclude_genes
    type:
      - 'null'
      - string
    doc: exclude genes in STR list or in @FILE
    inputBinding:
      position: 102
      prefix: -X
  - id: gene_protein_delimiter
    type:
      - 'null'
      - string
    doc: gene-protein delimiter
    inputBinding:
      position: 102
      prefix: -d
  - id: ignore_single_exon_genes
    type:
      - 'null'
      - boolean
    doc: ignore genes that are single-exon in all genomes
    inputBinding:
      position: 102
      prefix: -E
  - id: include_genes
    type:
      - 'null'
      - string
    doc: include genes in the output graph
    inputBinding:
      position: 102
      prefix: -I
  - id: max_degree
    type:
      - 'null'
      - int
    doc: drop a gene if its in- or out-degree >INT
    inputBinding:
      position: 102
      prefix: -g
  - id: max_distant_loci
    type:
      - 'null'
      - int
    doc: drop a gene if it connects >INT distant loci
    inputBinding:
      position: 102
      prefix: -r
  - id: max_occurrence
    type:
      - 'null'
      - int
    doc: drop a gene if average occurrence is >INT
    inputBinding:
      position: 102
      prefix: -c
  - id: min_genome_support
    type:
      - 'null'
      - int
    doc: prune an arc if it is supported by <INT genomes
    inputBinding:
      position: 102
      prefix: -a
  - id: min_identity
    type:
      - 'null'
      - float
    doc: drop an alignment if its identity <FLOAT
    inputBinding:
      position: 102
      prefix: -e
  - id: min_overlap_fraction
    type:
      - 'null'
      - float
    doc: min overlap fraction
    inputBinding:
      position: 102
      prefix: -f
  - id: min_protein_fraction
    type:
      - 'null'
      - float
    doc: drop an alignment if <FLOAT fraction of the protein aligned
    inputBinding:
      position: 102
      prefix: -l
  - id: no_distant_contigs
    type:
      - 'null'
      - boolean
    doc: don't consider genes on different contigs as distant
    inputBinding:
      position: 102
      prefix: -F
  - id: no_filter_pseudogenes
    type:
      - 'null'
      - boolean
    doc: don't filter pseudogenes across samples
    inputBinding:
      position: 102
      prefix: -J
  - id: prioritize_genes
    type:
      - 'null'
      - string
    doc: prioritize genes in the output graph
    inputBinding:
      position: 102
      prefix: -P
  - id: score_adjustment
    type:
      - 'null'
      - float
    doc: score adjustment coefficient
    inputBinding:
      position: 102
      prefix: -m
  - id: suppress_walks
    type:
      - 'null'
      - boolean
    doc: Suppress walk lines (W-lines)
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_bed
    type:
      - 'null'
      - File
    doc: output 12-column BED where STR is walk, raw or flag
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangene:r231--h5ca1c30_0
