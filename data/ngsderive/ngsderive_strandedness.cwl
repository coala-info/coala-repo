cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsderive strandedness
label: ngsderive_strandedness
doc: "Derive strandedness from NGS files.\n\nTool homepage: https://github.com/claymcleod/ngsderive"
inputs:
  - id: ngsfiles
    type:
      type: array
      items: File
    doc: Next-generation sequencing files to process (BAM or FASTQ).
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable DEBUG log level.
    inputBinding:
      position: 102
      prefix: --debug
  - id: gene_model
    type:
      - 'null'
      - File
    doc: Gene model as a GFF/GTF file.
    inputBinding:
      position: 102
      prefix: --gene-model
  - id: max_iterations_per_try
    type:
      - 'null'
      - int
    doc: At most, search this many times for genes that satisfy our search 
      criteria. Default is 10 * n-genes.
    inputBinding:
      position: 102
      prefix: --max-iterations-per-try
  - id: max_tries
    type:
      - 'null'
      - int
    doc: When inconclusive, the test will repeat until this many tries have been
      reached. Evidence of previous attempts is saved and reused, leading to a 
      larger sample size with multiple attempts.
    inputBinding:
      position: 102
      prefix: --max-tries
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ to consider for reads.
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: minimum_reads_per_gene
    type:
      - 'null'
      - int
    doc: Filter any genes that don't have at least `m` reads.
    inputBinding:
      position: 102
      prefix: --minimum-reads-per-gene
  - id: n_genes
    type:
      - 'null'
      - int
    doc: How many genes to sample.
    inputBinding:
      position: 102
      prefix: --n-genes
  - id: no_only_protein_coding_genes
    type:
      - 'null'
      - boolean
    doc: Do not consider protein coding genes
    inputBinding:
      position: 102
      prefix: --no-only-protein-coding-genes
  - id: no_split_by_rg
    type:
      - 'null'
      - boolean
    doc: Do not contain one entry per read group.
    inputBinding:
      position: 102
      prefix: --no-split-by-rg
  - id: only_protein_coding_genes
    type:
      - 'null'
      - boolean
    doc: Only consider protein coding genes
    inputBinding:
      position: 102
      prefix: --only-protein-coding-genes
  - id: split_by_rg
    type:
      - 'null'
      - boolean
    doc: Contain one entry per read group.
    inputBinding:
      position: 102
      prefix: --split-by-rg
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable INFO log level.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write to filename rather than standard out.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
