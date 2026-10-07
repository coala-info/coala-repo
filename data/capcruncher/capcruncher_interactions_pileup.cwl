cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - pileup
label: capcruncher_interactions_pileup
doc: "Extracts reporters from a capture experiment and generates a bedgraph file, optionally normalised and binned into even genomic windows.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: uri
    type: File
    doc: "CapCruncher HDF5 (cooler) file"
    inputBinding:
      position: 1
  - id: viewpoint_names
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -n
    doc: "Viewpoint to extract and convert to bedgraph, if not provided will transform all."
    inputBinding:
      position: 2
  - id: output_prefix
    type: string
    default: pileup
    doc: "Output prefix for bedgraphs"
    inputBinding:
      position: 2
      prefix: -o
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
  - id: binsize
    type:
      - 'null'
      - int
    doc: "Binsize to use for converting bedgraph to evenly sized genomic bins"
    inputBinding:
      position: 2
      prefix: --binsize
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "Compress output using gzip"
    inputBinding:
      position: 2
      prefix: --gzip
  - id: scale_factor
    type:
      - 'null'
      - int
    doc: "Scale factor to use for bedgraph normalisation"
    inputBinding:
      position: 2
      prefix: --scale-factor
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: "Produce bedgraph containing just positive bins (default)"
    inputBinding:
      position: 2
      prefix: --sparse
  - id: dense
    type:
      - 'null'
      - boolean
    doc: "Produce bedgraph containing all bins"
    inputBinding:
      position: 2
      prefix: --dense
  - id: format
    type:
      - 'null'
      - string
    doc: "Output file format (bedgraph or bigwig)"
    inputBinding:
      position: 2
      prefix: -f
outputs:
  - id: pileups
    type:
      type: array
      items: File
    doc: "Bedgraph or bigWig files, one per viewpoint"
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
