cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylopypruner
label: phylopypruner
doc: "A tree-based orthology inference program with additional functionality for reducing
  contamination.\n\nTool homepage: https://github.com/fethalen/phylopypruner"
inputs:
  - id: exclude_otus
    type:
      - 'null'
      - type: array
        items: string
    doc: exclude these OTUs
    inputBinding:
      position: 101
      prefix: --exclude
  - id: force_inclusion
    type:
      - 'null'
      - type: array
        items: string
    doc: discard output alignments where these OTUs are missing
    inputBinding:
      position: 101
      prefix: --force-inclusion
  - id: include_otus
    type:
      - 'null'
      - type: array
        items: string
    doc: include these OTUs, even if deemed problematic by '--trim-freq-paralogs'
      or '--trim-divergent'
    inputBinding:
      position: 101
      prefix: --include
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: a <directory> containing 1+ alignment and tree files
    inputBinding:
      position: 101
      prefix: --dir
  - id: jackknife
    type:
      - 'null'
      - boolean
    doc: exclude each OTU one by one, rerun the whole analysis and generate statistics
      for each subsample
    inputBinding:
      position: 101
      prefix: --jackknife
  - id: mask
    type:
      - 'null'
      - string
    doc: if 2+ sequences from a single OTU forms a clade, choose which sequence to
      keep using this method (longest or pdist)
    inputBinding:
      position: 101
      prefix: --mask
  - id: min_gene_occupancy
    type:
      - 'null'
      - float
    doc: discard output alignments with less occupancy than <percentage>
    inputBinding:
      position: 101
      prefix: --min-gene-occupancy
  - id: min_len
    type:
      - 'null'
      - int
    doc: remove sequences which are shorter than <number> bases
    inputBinding:
      position: 101
      prefix: --min-len
  - id: min_otu_occupancy
    type:
      - 'null'
      - float
    doc: do not include OTUs with less occupancy than <percentage>
    inputBinding:
      position: 101
      prefix: --min-otu-occupancy
  - id: min_pdist
    type:
      - 'null'
      - float
    doc: remove sequence pairs with less tip-to-tip distance than <distance>
    inputBinding:
      position: 101
      prefix: --min-pdist
  - id: min_support
    type:
      - 'null'
      - float
    doc: collapse nodes with less support than <percentage> into polytomies
    inputBinding:
      position: 101
      prefix: --min-support
  - id: min_taxa
    type:
      - 'null'
      - int
    doc: discard output alignments with fewer OTUs than <number>
    default: 4
    inputBinding:
      position: 101
      prefix: --min-taxa
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: do not generate any plots (faster)
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: no_supermatrix
    type:
      - 'null'
      - boolean
    doc: do not concatenate output into a supermatrix (faster)
    inputBinding:
      position: 101
      prefix: --no-supermatrix
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: root trees using these OTUs if at least one OTU is present and if all present
      OTUs are non-repetetive and form a clade
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite pre-existing output files without asking
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: prune_method
    type:
      - 'null'
      - string
    doc: select the paralogy pruning method (LS, MI, MO, RT, 1to1, OTO)
    default: LS
    inputBinding:
      position: 101
      prefix: --prune
  - id: root_method
    type:
      - 'null'
      - string
    doc: root trees using this method when outgroup rooting was not performed
    inputBinding:
      position: 101
      prefix: --root
  - id: subclades_file
    type:
      - 'null'
      - File
    doc: specify a set of subclades within this file and analyse their overall stability
    inputBinding:
      position: 101
      prefix: --subclades
  - id: threads
    type:
      - 'null'
      - int
    doc: use <number> threads instead of up to 10 threads
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim_divergent
    type:
      - 'null'
      - float
    doc: "for each alignment: discard all sequences from an OTU on a per-alignment-basis,
      if the ratio between the largest pairwise distance of sequences from this OTU
      and the average pairwise distance of sequences from this OTU to other's exceed
      this <percentage>"
    inputBinding:
      position: 101
      prefix: --trim-divergent
  - id: trim_freq_paralogs
    type:
      - 'null'
      - float
    doc: exclude OTUs with more paralogy frequency (PF) than <factor> standard deviations
      of all PFs
    inputBinding:
      position: 101
      prefix: --trim-freq-paralogs
  - id: trim_lb
    type:
      - 'null'
      - float
    doc: remove branches longer than <factor> standard deviations of all branches
    inputBinding:
      position: 101
      prefix: --trim-lb
  - id: wrap
    type:
      - 'null'
      - int
    doc: wrap output sequences at column <number>, instead of writing each sequence
      to a single line
    inputBinding:
      position: 101
      prefix: --wrap
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: save output files to <directory>, instead of the input directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylopypruner:1.2.6--pyhdfd78af_0
