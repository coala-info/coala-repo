cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - compare
  - concat
label: capcruncher_interactions_compare_concat
doc: "Concatenate viewpoint interactions from bedgraphs or CapCruncher cooler files into one table.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: infiles
    type:
      type: array
      items: File
    doc: "Input bedgraph or cooler files"
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: "Input file format (auto, bedgraph or cooler)"
    inputBinding:
      position: 2
      prefix: -f
  - id: output
    type: string
    default: concatenated.tsv
    doc: "Output file name"
    inputBinding:
      position: 2
      prefix: -o
  - id: viewpoint
    type:
      - 'null'
      - string
    doc: "Viewpoint to extract"
    inputBinding:
      position: 2
      prefix: -v
  - id: resolution
    type:
      - 'null'
      - string
    doc: "Resolution to extract"
    inputBinding:
      position: 2
      prefix: -r
  - id: region
    type:
      - 'null'
      - string
    doc: "Limit to specific coordinates in the format chrom:start-end"
    inputBinding:
      position: 2
      prefix: --region
  - id: normalisation
    type:
      - 'null'
      - string
    doc: "Method to use interaction normalisation (raw, n_cis or region)"
    inputBinding:
      position: 2
      prefix: --normalisation
  - id: normalisation_regions
    type:
      - 'null'
      - File
    doc: "Regions to use for interaction normalisation. The --normalisation method MUST be 'region'"
    inputBinding:
      position: 2
      prefix: --normalisation-regions
  - id: scale_factor
    type:
      - 'null'
      - int
    doc: "Scale factor to use for bedgraph normalisation"
    inputBinding:
      position: 2
      prefix: --scale_factor
  - id: n_cores
    type:
      - 'null'
      - int
    doc: "Number of cores to use for extracting bedgraphs"
    inputBinding:
      position: 2
      prefix: -p
outputs:
  - id: concatenated
    type: File
    doc: "Concatenated interactions table"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
