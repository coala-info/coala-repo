cwlVersion: v1.2
class: CommandLineTool
baseCommand: RnaChipIntegrator
label: rnachipintegrator_RnaChipIntegrator
doc: "Analyse GENES (any set of genes or genomic features) against PEAKS (a set of
  regions) and report nearest genes to each peak (and vice versa)\n\nTool homepage:
  https://github.com/fls-bioinformatics-core/RnaChipIntegrator"
inputs:
  - id: genes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genes or genomic features to analyze
    inputBinding:
      position: 1
  - id: peaks
    type:
      - 'null'
      - type: array
        items: File
    doc: Set of regions to analyze
    inputBinding:
      position: 2
  - id: analyses
    type:
      - 'null'
      - string
    doc: "Select which analyses to run: can be one of 'all' (default, runs all available
      analyses), 'peak_centric' or 'gene_centric'"
    inputBinding:
      position: 103
      prefix: --analyses
  - id: compact
    type:
      - 'null'
      - boolean
    doc: Output all hits for each peak or gene on a single line (cannot be used 
      with --summary)
    inputBinding:
      position: 103
      prefix: --compact
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Maximum distance allowed between peaks and genes before being omitted 
      from the analyses (default 1000000bp; set to zero for no cutoff, use 
      --cutoffs instead to specify multiple distances)
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: cutoffs
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of one or more maximum distances allowed between 
      peaks and genes (bp). An analysis will be performed for each GENES-PEAKS 
      pair at each cutoff distance (default 1000000bp; set to zero for no cutoff
      NB cannot be used in conjunction with the --cutoff option)
    inputBinding:
      position: 103
      prefix: --cutoffs
  - id: edge
    type:
      - 'null'
      - string
    doc: "Gene edges to consider when calculating distances between genes and peaks,
      either: 'tss' (default: only use gene TSS), 'tes' (only use gene TES), or 'both'
      (use whichever of TSS or TES gives shortest distance)"
    inputBinding:
      position: 103
      prefix: --edge
  - id: feature
    type:
      - 'null'
      - string
    doc: Rename 'gene' to FEATURE_TYPE in output (e.g. 'transcript' etc)
    inputBinding:
      position: 103
      prefix: --feature
  - id: genes_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify multiple genes files (if used then peaks file(s) must be 
      specified using --peaks option)
    inputBinding:
      position: 103
      prefix: --genes
  - id: name
    type:
      - 'null'
      - string
    doc: Set basename for output files
    inputBinding:
      position: 103
      prefix: --name
  - id: nprocessors
    type:
      - 'null'
      - int
    doc: 'Number of processors/cores to run the program using (default: 1)'
    inputBinding:
      position: 103
      prefix: --nprocessors
  - id: number_closest
    type:
      - 'null'
      - int
    doc: Filter results after applying --cutoff[s] to report only the nearest 
      MAX_CLOSEST number of pairs for each gene/peak from the analyses (default 
      is to report all results)
    inputBinding:
      position: 103
      prefix: --number
  - id: only_de
    type:
      - 'null'
      - boolean
    doc: Only use genes flagged as differentially expressed in analyses (input 
      gene data must include DE flags)
    inputBinding:
      position: 103
      prefix: --only-DE
  - id: pad
    type:
      - 'null'
      - boolean
    doc: Where less than MAX_CLOSEST hits are found, pad output with blanks to 
      ensure that MAX_CLOSEST hits are still reported (nb --pad is implied for 
      --compact)
    inputBinding:
      position: 103
      prefix: --pad
  - id: peak_cols
    type:
      - 'null'
      - string
    doc: List of 3 column indices (e.g. '1,4,5') indicating columns to use for 
      chromosome, start and end from the input peak file (if not first three 
      columns)
    inputBinding:
      position: 103
      prefix: --peak_cols
  - id: peak_id
    type:
      - 'null'
      - string
    doc: Column to use as an ID for each peak from the input peak file (first 
      column is column 1). If specified then IDs will be transferred to the 
      output files when peaks are reported
    inputBinding:
      position: 103
      prefix: --peak_id
  - id: peaks_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify multiple peaks files (if used then genes file(s) must be 
      specified using --genes option)
    inputBinding:
      position: 103
      prefix: --peaks
  - id: promoter_region
    type:
      - 'null'
      - string
    doc: Define promoter region with respect to gene TSS in the form 
      UPSTREAM,DOWNSTREAM (default -1000 to 100bp of TSS)
    inputBinding:
      position: 103
      prefix: --promoter_region
  - id: split_outputs
    type:
      - 'null'
      - boolean
    doc: In batch mode write results of each analysis to separate file (default 
      is to write all results to single file)
    inputBinding:
      position: 103
      prefix: --split-outputs
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Output 'summary' for each analysis, consisting of only the top hit for 
      each peak or gene (cannot be used with --compact)
    inputBinding:
      position: 103
      prefix: --summary
  - id: xlsx
    type:
      - 'null'
      - boolean
    doc: Output XLSX spreadsheet with results
    inputBinding:
      position: 103
      prefix: --xlsx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnachipintegrator:3.0.0--pyh7cba7a3_0
stdout: rnachipintegrator_RnaChipIntegrator.out
