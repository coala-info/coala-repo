cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - pca
label: fanc_pca
doc: "Do a PCA on multiple Hi-C objects.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Input Hic files."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output file with PCA results."
    inputBinding:
      position: 2
  - id: plot
    type:
      - 'null'
      - string
    doc: "Output plot. Path to PDF file where the PCA plot will be saved."
    inputBinding:
      position: 20
      prefix: --plot
  - id: sample_size
    type:
      - 'null'
      - int
    doc: "Sample size for contacts to do the PCA on.Default: 50000"
    inputBinding:
      position: 20
      prefix: --sample-size
  - id: inter_chromosomal
    type:
      - 'null'
      - boolean
    doc: "Also include inter-chromosomal contacts in PCA. By default, only intra-schromosomal contacts are considered."
    inputBinding:
      position: 20
      prefix: --inter-chromosomal
  - id: region
    type:
      - 'null'
      - string
    doc: "Region to do PCA on. You could put a specific chromosome here, for example. By default, the whole genome is considered. Comma-separate multiple regions."
    inputBinding:
      position: 20
      prefix: --region
  - id: expected_filter
    type:
      - 'null'
      - float
    doc: "Minimum fold-enrichment over expected value. Contacts with a strength lower than <b>*E(d), where d is the distance between two loci and E is the corresponding expected contact strength, are filtered out before PCA. Default: no filter."
    inputBinding:
      position: 20
      prefix: --expected-filter
  - id: background_filter
    type:
      - 'null'
      - float
    doc: "Minimum fold-enrichment over average inter-chromosomal contacts. Default: no filter."
    inputBinding:
      position: 20
      prefix: --background-filter
  - id: min_distance
    type:
      - 'null'
      - string
    doc: "Minimum distance of matrix bins in base pairs. You can use abbreviated formats such as 1mb, 10k, etc."
    inputBinding:
      position: 20
      prefix: --min-distance
  - id: max_distance
    type:
      - 'null'
      - string
    doc: "Maximum distance of matrix bins in base pairs. You can use abbreviated formats such as 1mb, 10k, etc."
    inputBinding:
      position: 20
      prefix: --max-distance
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample names for plot labelling."
    inputBinding:
      position: 20
      prefix: --names
  - id: strategy
    type:
      - 'null'
      - string
    doc: "Mechanism to select pairs from Hi-C matrix. Default: variance. Possible values are: variance (select contacts with the largest variance in strength across samples first), fold-change (select pairs with the largest fold-change across samples first), and passthrough (no preference on pairs)."
    inputBinding:
      position: 20
      prefix: --strategy
  - id: colors
    type:
      - 'null'
      - type: array
        items: string
    doc: "Colors for plotting."
    inputBinding:
      position: 20
      prefix: --colors
  - id: markers
    type:
      - 'null'
      - type: array
        items: string
    doc: "Markers for plotting. Follows Matplotlib marker definitions: http://matplotlib.org/api/markers_api.html"
    inputBinding:
      position: 20
      prefix: --markers
  - id: eigenvectors
    type:
      - 'null'
      - type: array
        items: int
    doc: "Which eigenvectors to plot. Default: 1 2"
    inputBinding:
      position: 20
      prefix: --eigenvectors
  - id: no_zeros
    type:
      - 'null'
      - boolean
    doc: "Ignore pixels with no contacts in any sample."
    inputBinding:
      position: 20
      prefix: --no-zeros
  - id: no_scaling
    type:
      - 'null'
      - boolean
    doc: "Do not scale input matrices to the same number of valid pairs. Use this only if you are sure matrices are directly comparable."
    inputBinding:
      position: 20
      prefix: --no-scaling
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "If the specified output file exists, it will be overwritten without warning."
    inputBinding:
      position: 20
      prefix: --force-overwrite
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: pca
    type: File
    doc: "PCA results."
    outputBinding:
      glob: $(inputs.output)
  - id: plot_file
    type:
      - 'null'
      - File
    doc: "PCA plot (PDF)."
    outputBinding:
      glob: $(inputs.plot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
