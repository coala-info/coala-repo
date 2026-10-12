cwlVersion: v1.2
class: CommandLineTool
baseCommand: panfeed-get-clusters
label: panfeed_panfeed-get-clusters
doc: "Indicate which genes clusters have significantly associated patterns\n\nTool
  homepage: https://github.com/microbial-pangenomes-lab/panfeed"
inputs:
  - id: associations
    type: File
    doc: TSV file containing hashes and their significance (e.g. pyseer output; 
      tab-delimited, should have a header, first column contains the hash, and 
      another column - by default 'lrt-pvalue' - contains the association 
      p-value, which can be used to filter the table)
    inputBinding:
      position: 101
      prefix: --associations
  - id: column
    type:
      - 'null'
      - string
    doc: 'P-value column in the associations file (default: lrt-pvalue)'
    inputBinding:
      position: 101
      prefix: --column
  - id: kmers_to_hashes
    type: File
    doc: TSV file relating gene clusters, kmers, and their hashes (i.e. 
      panfeed's kmers_to_hases.tsv file)
    inputBinding:
      position: 101
      prefix: --kmers-to-hashes
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Association p-value threshold (default: 1.00)'
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
  - id: output_path
    type:
      - 'null'
      - string
    doc: Filename to save filtered associations table (not saved by default)
    inputBinding:
      position: 102
      prefix: --output
stdout: gene_clusters.txt
outputs:
  - id: clusters
    type: stdout
    doc: Gene clusters with significantly associated patterns, one per line
  - id: filtered_associations
    type:
      - 'null'
      - File
    doc: Filtered associations table (only when --output is given)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
