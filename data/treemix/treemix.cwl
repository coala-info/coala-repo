cwlVersion: v1.2
class: CommandLineTool
baseCommand: treemix
label: treemix
doc: "TreeMix is a method for inferring the patterns of population splitting and mixing
  from genome-wide allele frequency data.\n\nTool homepage: http://pritchardlab.stanford.edu/software.html"
inputs:
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of SNPs per block for jackknifing
    inputBinding:
      position: 101
      prefix: -k
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: Perform a bootstrap analysis
    inputBinding:
      position: 101
      prefix: -bootstrap
  - id: global_optimization
    type:
      - 'null'
      - boolean
    doc: Perform a global search for the best tree
    inputBinding:
      position: 101
      prefix: -global
  - id: input_file
    type: File
    doc: Input file (typically a gzip-compressed file containing allele counts)
    inputBinding:
      position: 101
      prefix: -i
  - id: input_graph
    type:
      - 'null'
      - type: array
        items: File
    doc: Input graph (vertices and edges files) to use as a starting point
    inputBinding:
      position: 101
      prefix: -g
  - id: migration_edges
    type:
      - 'null'
      - int
    doc: Number of migration edges to add to the tree
    inputBinding:
      position: 101
      prefix: -m
  - id: no_sample_size_correction
    type:
      - 'null'
      - boolean
    doc: Turn off sample size correction
    inputBinding:
      position: 101
      prefix: -noss
  - id: root_population
    type:
      - 'null'
      - string
    doc: Comma-separated list of populations to use as the outgroup
    inputBinding:
      position: 101
      prefix: -root
  - id: standard_errors
    type:
      - 'null'
      - boolean
    doc: Calculate standard errors of migration weights
    inputBinding:
      position: 101
      prefix: -se
  - id: tfam_file
    type:
      - 'null'
      - File
    doc: Provide a PLINK tfam file to specify population assignments
    inputBinding:
      position: 101
      prefix: -tfam
outputs:
  - id: output_stem
    type: File
    doc: Stem for output files
    outputBinding:
      glob: $(inputs.output_stem)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treemix:1.13--h63c0f18_10
