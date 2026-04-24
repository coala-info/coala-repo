cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwas_summarize
label: pangwas_summarize
doc: "Summarize clusters according to their annotations.\n\nTakes as input the TSV
  table from collect, and the clusters table from \neither cluster or defrag. Outputs
  a TSV table of summarized clusters \nwith their annotations.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type: File
    doc: TSV file of clusters from cluster or defrag.
    inputBinding:
      position: 101
      prefix: --clusters
  - id: max_product_len
    type:
      - 'null'
      - int
    doc: Truncate the product description to this length if used as an 
      identifie.
    inputBinding:
      position: 101
      prefix: --max-product-len
  - id: min_samples
    type:
      - 'null'
      - int
    doc: Cluster must be observed in at least this many samples to be 
      summarized.
    inputBinding:
      position: 101
      prefix: --min-samples
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: regions
    type: File
    doc: TSV file of sequence regions from collect.
    inputBinding:
      position: 101
      prefix: --regions
  - id: threshold
    type:
      - 'null'
      - float
    doc: Required this proportion of samples to have annotations in agreement.
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_summarize.out
