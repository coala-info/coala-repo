cwlVersion: v1.2
class: CommandLineTool
baseCommand: panfeed-get-kmers
label: panfeed_panfeed-get-kmers
doc: "Annotate association results with positional information\n\nTool homepage: https://github.com/microbial-pangenomes-lab/panfeed"
inputs:
  - id: associations
    type: File
    doc: TSV file containing hashes and their significance (e.g. pyseer output; tab-delimited,
      should have a header, first column contains the hash, and another column - by
      default 'lrt-pvalue' - contains the association p-value, which can be used to
      filter the table)
    inputBinding:
      position: 101
      prefix: --associations
  - id: clusters_per_iteration
    type:
      - 'null'
      - int
    doc: Number of clusters to be considered in each iteration, a higher number means
      faster execution but higher memory usage
    inputBinding:
      position: 101
      prefix: --clusters-per-iteration
  - id: column
    type:
      - 'null'
      - string
    doc: P-value column in the associations file
    inputBinding:
      position: 101
      prefix: --column
  - id: kmers
    type: File
    doc: TSV file with positional information of individual k-mers (i.e. panfeed's
      kmers.tsv file)
    inputBinding:
      position: 101
      prefix: --kmers
  - id: kmers_to_hashes
    type: File
    doc: TSV file relating gene clusters, kmers, and their hashes (i.e. panfeed's
      kmers_to_hases.tsv file)
    inputBinding:
      position: 101
      prefix: --kmers-to-hashes
  - id: only_passing
    type:
      - 'null'
      - boolean
    doc: Only output passing k-mers (default is all)
    inputBinding:
      position: 101
      prefix: --only-passing
  - id: threshold
    type:
      - 'null'
      - float
    doc: Association p-value threshold
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity level
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Filename to save filtered associations table (not saved by default)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
