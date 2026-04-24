cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja boot
label: freyja_boot
doc: "Perform bootstrapping method for freyja using VARIANTS and DEPTHS\n\nTool homepage:
  https://github.com/andersen-lab/Freyja"
inputs:
  - id: variants
    type: File
    doc: VARIANTS
    inputBinding:
      position: 1
  - id: depths
    type: File
    doc: DEPTHS
    inputBinding:
      position: 2
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
    doc: custom barcode file
    inputBinding:
      position: 103
      prefix: --barcodes
  - id: bootseed
    type:
      - 'null'
      - int
    doc: set seed for bootstrap generation
    inputBinding:
      position: 103
      prefix: --bootseed
  - id: boxplot
    type:
      - 'null'
      - string
    doc: file format of boxplot output (e.g. pdf or png)
    inputBinding:
      position: 103
      prefix: --boxplot
  - id: confirmedonly
    type:
      - 'null'
      - boolean
    doc: exclude unconfirmed lineages
    inputBinding:
      position: 103
      prefix: --confirmedonly
  - id: depthcutoff
    type:
      - 'null'
      - int
    doc: exclude sites with coverage depth below this value andgroup identical 
      barcodes
    inputBinding:
      position: 103
      prefix: --depthcutoff
  - id: eps
    type:
      - 'null'
      - float
    doc: minimum abundance to include
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
    doc: lineage hierarchy file in yaml format
    inputBinding:
      position: 103
      prefix: --lineageyml
  - id: meta
    type:
      - 'null'
      - string
    doc: custom lineage to variant metadata file
    inputBinding:
      position: 103
      prefix: --meta
  - id: nb
    type:
      - 'null'
      - int
    doc: number of times bootstrapping is performed
    inputBinding:
      position: 103
      prefix: --nb
  - id: nt
    type:
      - 'null'
      - int
    doc: max number of cpus to use
    inputBinding:
      position: 103
      prefix: --nt
  - id: output_base
    type:
      - 'null'
      - File
    doc: Output file basename
    inputBinding:
      position: 103
      prefix: --output_base
  - id: pathogen
    type:
      - 'null'
      - string
    doc: Pathogen of interest.Not used if using --barcodes option.
    inputBinding:
      position: 103
      prefix: --pathogen
  - id: rawboots
    type:
      - 'null'
      - boolean
    doc: return raw bootstraps
    inputBinding:
      position: 103
      prefix: --rawboots
  - id: relaxedmrca
    type:
      - 'null'
      - boolean
    doc: for use with depth cutoff,clusters are assigned robust mrca to handle 
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
stdout: freyja_boot.out
