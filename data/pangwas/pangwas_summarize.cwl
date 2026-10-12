cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - summarize
label: pangwas_summarize
doc: "Summarize clusters according to their annotations.\n\nTakes as input the TSV table from collect, and the clusters table from \neither cluster or defrag. Outputs a TSV table of summarized clusters \nwith their annotations.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type: File
    doc: "TSV file of clusters from cluster or defrag."
    inputBinding:
      position: 101
      prefix: --clusters
  - id: regions
    type: File
    doc: "TSV file of sequence regions from collect."
    inputBinding:
      position: 101
      prefix: --regions
  - id: max_product_len
    type:
      - 'null'
      - int
    doc: "Truncate the product description to this length if used as an identifie. (default: 50)"
    inputBinding:
      position: 101
      prefix: --max-product-len
  - id: min_samples
    type:
      - 'null'
      - int
    doc: "Cluster must be observed in at least this many samples to be summarized."
    inputBinding:
      position: 101
      prefix: --min-samples
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: .)"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Required this proportion of samples to have annotations in agreement. (default: 0.5)"
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: clusters_out
    type: File
    doc: "TSV table of summarized clusters with their annotations"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'clusters.tsv')"
  - id: phandango
    type:
      - 'null'
      - File
    doc: "Phandango metadata table"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'phandango.csv')"
  - id: synteny_full_gfa
    type:
      - 'null'
      - File
    doc: "Full synteny graph (GFA)"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'synteny.full.gfa')"
  - id: synteny_full_graphml
    type:
      - 'null'
      - File
    doc: "Full synteny graph (GraphML)"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'synteny.full.graphml')"
  - id: synteny_linear_gfa
    type:
      - 'null'
      - File
    doc: "Linear synteny graph (GFA)"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'synteny.linear.gfa')"
  - id: synteny_linear_graphml
    type:
      - 'null'
      - File
    doc: "Linear synteny graph (GraphML)"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'synteny.linear.graphml')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
