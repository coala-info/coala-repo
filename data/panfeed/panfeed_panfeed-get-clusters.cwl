cwlVersion: v1.2
class: CommandLineTool
baseCommand: panfeed-get-clusters
label: panfeed_panfeed-get-clusters
doc: "Indicate which genes clusters have significantly associated patterns\n\nTool
  homepage: https://github.com/microbial-pangenomes-lab/panfeed"
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
  - id: column
    type:
      - 'null'
      - string
    doc: P-value column in the associations file
    inputBinding:
      position: 101
      prefix: --column
  - id: kmers_to_hashes
    type: File
    doc: TSV file relating gene clusters, kmers, and their hashes (i.e. panfeed's
      kmers_to_hases.tsv file)
    inputBinding:
      position: 101
      prefix: --kmers-to-hashes
  - id: threshold
    type:
      - 'null'
      - float
    doc: Association p-value threshold
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbosity
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
