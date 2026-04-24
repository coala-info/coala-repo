cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - demix
label: freyja_demix
doc: "Generate relative lineage abundances from VARIANTS and DEPTHS\n\nTool homepage:
  https://github.com/andersen-lab/Freyja"
inputs:
  - id: variants
    type: File
    doc: Input variants file
    inputBinding:
      position: 1
  - id: depths
    type: File
    doc: Input depths file
    inputBinding:
      position: 2
  - id: a_eps
    type:
      - 'null'
      - float
    doc: adaptive lasso parameter, hard threshold
    inputBinding:
      position: 103
      prefix: --a_eps
  - id: adapt
    type:
      - 'null'
      - float
    doc: adaptive lasso penalty parameter
    inputBinding:
      position: 103
      prefix: --adapt
  - id: autoadapt
    type:
      - 'null'
      - boolean
    doc: use error profile to set adapt
    inputBinding:
      position: 103
      prefix: --autoadapt
  - id: barcodes
    type:
      - 'null'
      - string
    doc: Path to custom barcode file
    inputBinding:
      position: 103
      prefix: --barcodes
  - id: confirmedonly
    type:
      - 'null'
      - boolean
    doc: exclude unconfirmed lineages
    inputBinding:
      position: 103
      prefix: --confirmedonly
  - id: covcut
    type:
      - 'null'
      - int
    doc: calculate percent of sites with n or greater reads
    inputBinding:
      position: 103
      prefix: --covcut
  - id: depthcutoff
    type:
      - 'null'
      - int
    doc: exclude sites with coverage depth below this value and group identical 
      barcodes
    inputBinding:
      position: 103
      prefix: --depthcutoff
  - id: eps
    type:
      - 'null'
      - float
    doc: minimum abundance to include for each lineage
    inputBinding:
      position: 103
      prefix: --eps
  - id: freqcol
    type:
      - 'null'
      - string
    doc: Frequency column name in the vcf file
    inputBinding:
      position: 103
      prefix: --freqcol
  - id: lineageyml
    type:
      - 'null'
      - string
    doc: lineage hierarchy file in a yaml format
    inputBinding:
      position: 103
      prefix: --lineageyml
  - id: max_solver_threads
    type:
      - 'null'
      - int
    doc: maximum number of threads for multithreaded demix solvers (0 to choose 
      automatically)
    inputBinding:
      position: 103
      prefix: --max-solver-threads
  - id: meta
    type:
      - 'null'
      - string
    doc: custom lineage to variant metadata file
    inputBinding:
      position: 103
      prefix: --meta
  - id: pathogen
    type:
      - 'null'
      - string
    doc: Pathogen of interest. Not used if using --barcodes option.
    inputBinding:
      position: 103
      prefix: --pathogen
  - id: region_of_interest
    type:
      - 'null'
      - string
    doc: JSON file containing region(s) of interest for which to compute 
      additional coverage estimates
    inputBinding:
      position: 103
      prefix: --region_of_interest
  - id: relaxedmrca
    type:
      - 'null'
      - boolean
    doc: for use with depth cutoff, clusters are assigned robust mrca to handle 
      outliers
    inputBinding:
      position: 103
      prefix: --relaxedmrca
  - id: relaxedthresh
    type:
      - 'null'
      - float
    doc: associated threshold for robust mrca function
    inputBinding:
      position: 103
      prefix: --relaxedthresh
  - id: solver
    type:
      - 'null'
      - string
    doc: solver used for estimating lineage prevalence
    inputBinding:
      position: 103
      prefix: --solver
  - id: verbose_solver
    type:
      - 'null'
      - boolean
    doc: enable solver verbosity
    inputBinding:
      position: 103
      prefix: --verbose-solver
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
