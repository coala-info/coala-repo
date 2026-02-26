cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooltools expected-trans
label: cooltools_expected-trans
doc: "Calculate expected Hi-C signal for trans regions of chromosomal interaction
  map: average of interactions in a rectangular block defined by a pair of regions,
  e.g. inter-chromosomal blocks.\n\nWhen balancing weights are not applied to the
  data, there is no masking of bad bins performed.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: The paths to a .cool file with a balanced Hi-C map.
    inputBinding:
      position: 1
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Control the number of pixels handled by each worker process at a time.
    default: 10000000
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Use balancing weight with this name stored in cooler.Provide empty 
      argument to calculate cis-expected on raw data
    default: weight
    inputBinding:
      position: 102
      prefix: --clr-weight-name
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to split the work between.
    default: 1
    inputBinding:
      position: 102
      prefix: --nproc
  - id: regions
    type:
      - 'null'
      - File
    doc: Path to a 3 or 4-column BED file with genomic regions. Trans-expected 
      is calculated on all pairwise combinations of these regions. When region 
      names are not provided (no 4th column), UCSC-style region names are 
      generated. Trans-expected is calculated  for all inter-chromosomal pairs, 
      when view is not specified. Note that '--regions' is the deprecated name 
      of the option. Use '--view' instead.
    inputBinding:
      position: 102
      prefix: --regions
  - id: view
    type:
      - 'null'
      - File
    doc: Path to a 3 or 4-column BED file with genomic regions. Trans-expected 
      is calculated on all pairwise combinations of these regions. When region 
      names are not provided (no 4th column), UCSC-style region names are 
      generated. Trans-expected is calculated  for all inter-chromosomal pairs, 
      when view is not specified. Note that '--regions' is the deprecated name 
      of the option. Use '--view' instead.
    inputBinding:
      position: 102
      prefix: --view
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Specify output file name to store the expected in a tsv format.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
