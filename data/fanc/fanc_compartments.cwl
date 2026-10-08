cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - compartments
label: fanc_compartments
doc: "Calculate the AB compartment matrix, eigenvector, AB domains and enrichment profile.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: matrix
    type: File
    doc: "Input matrix (Hi-C, fold-change map, ...) or existing AB compartment matrix."
    inputBinding:
      position: 1
  - id: ab_compartments
    type:
      - 'null'
      - string
    doc: "Output AB compartment matrix file."
    inputBinding:
      position: 2
  - id: domains
    type:
      - 'null'
      - string
    doc: "Write AB domains to this file. AB domains are output in BED format, and include the domains type (A/B) in the name field, and the eigenvector values (averaged across all bins in the domain) in the score field"
    inputBinding:
      position: 20
      prefix: --domains
  - id: eigenvector
    type:
      - 'null'
      - string
    doc: "Write eigenvector values to this file.Output format is BED, containing of each matrix bin. The score field contains the eigenvector value of the bin."
    inputBinding:
      position: 20
      prefix: --eigenvector
  - id: enrichment_profile
    type:
      - 'null'
      - string
    doc: "Plot AB enrichment profile to this file."
    inputBinding:
      position: 20
      prefix: --enrichment-profile
  - id: enrichment_matrix
    type:
      - 'null'
      - string
    doc: "Path to save enrichment profile matrix (numpy txt format)"
    inputBinding:
      position: 20
      prefix: --enrichment-matrix
  - id: genome
    type:
      - 'null'
      - File
    doc: "Genome file. Used to \"orient\" the eigenvector values (change sign) using the average GC content of domains. Possible input files are FASTA, folder with FASTA, comma-separated list of FASTA) used to change sign of eigenvector based on GC content."
    inputBinding:
      position: 20
      prefix: --genome
  - id: whole_genome
    type:
      - 'null'
      - boolean
    doc: "Calculate AB compartments on the whole genome matrix, instead of individual chromosomes. Only enable if you are sure your use-case requires it. This is likely to introduce artefacts when working with matrices that have been normalised per-chromosome."
    inputBinding:
      position: 20
      prefix: --whole-genome
  - id: region
    type:
      - 'null'
      - string
    doc: "Only outputs domains / eigenvector values in this region. Only works with the -d and -e arguments. Compartmentalisation is always calculated on the whole genome."
    inputBinding:
      position: 20
      prefix: --region
  - id: eigenvector_index
    type:
      - 'null'
      - int
    doc: "Eigenvector index. By default, the first eigenvector is output for eigenvector and domain analysis. Sometimes, it is useful to choose a higher eigenvector. E.g. for second eigenvector,specify \"-i 2\"."
    inputBinding:
      position: 20
      prefix: --eigenvector-index
  - id: enrichment_percentiles
    type:
      - 'null'
      - type: array
        items: float
    doc: "Percentiles to use for calculation of the enrichment profile. By default uses 20, 40, 60, 80, 100. The 0 percentile is included by default."
    inputBinding:
      position: 20
      prefix: --enrichment-percentiles
  - id: enrichment_colormap
    type:
      - 'null'
      - string
    doc: "Matplotlib colormap to use for plotting the enrichment profile."
    inputBinding:
      position: 20
      prefix: --enrichment-colormap
  - id: enrichment_symmetric_at
    type:
      - 'null'
      - float
    doc: "Make enrichment profile plot symmetric around this value (e.g. use 0 to ensure that 0 is in the center of the plot)."
    inputBinding:
      position: 20
      prefix: --enrichment-symmetric-at
  - id: enrichment_min
    type:
      - 'null'
      - float
    doc: "Minimum saturation value in enrichment profile. Default -1"
    inputBinding:
      position: 20
      prefix: --enrichment-min
  - id: enrichment_max
    type:
      - 'null'
      - float
    doc: "Maximum saturation value in enrichment profile. Default: 1"
    inputBinding:
      position: 20
      prefix: --enrichment-max
  - id: only_gc
    type:
      - 'null'
      - boolean
    doc: "Only use GC content for enrichment profile calculation, not the correlation matrix eigenvector."
    inputBinding:
      position: 20
      prefix: --only-gc
  - id: enrichment_exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "Chromosome names to exclude from enrichment profile calculation"
    inputBinding:
      position: 20
      prefix: --enrichment-exclude
  - id: compartment_strength
    type:
      - 'null'
      - string
    doc: "File for saving the compartment strength."
    inputBinding:
      position: 20
      prefix: --compartment-strength
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force overwriting of output files."
    inputBinding:
      position: 20
      prefix: --force
  - id: recalculate
    type:
      - 'null'
      - boolean
    doc: "Force recalculation of eigenvector even if a vector with the same parameters has previously been calculated."
    inputBinding:
      position: 20
      prefix: --recalculate
outputs:
  - id: ab_matrix
    type:
      - 'null'
      - File
    doc: "AB compartment matrix."
    outputBinding:
      glob: $(inputs.ab_compartments)
  - id: domains_file
    type:
      - 'null'
      - File
    doc: "AB domains (BED)."
    outputBinding:
      glob: $(inputs.domains)
  - id: eigenvector_file
    type:
      - 'null'
      - File
    doc: "Eigenvector values per bin (BED)."
    outputBinding:
      glob: $(inputs.eigenvector)
  - id: enrichment_profile_file
    type:
      - 'null'
      - File
    doc: "AB enrichment profile plot."
    outputBinding:
      glob: $(inputs.enrichment_profile)
  - id: enrichment_matrix_file
    type:
      - 'null'
      - File
    doc: "Enrichment profile matrix (numpy txt)."
    outputBinding:
      glob: $(inputs.enrichment_matrix)
  - id: compartment_strength_file
    type:
      - 'null'
      - File
    doc: "Compartment strength."
    outputBinding:
      glob: $(inputs.compartment_strength)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.matrix)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
