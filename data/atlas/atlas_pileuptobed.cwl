cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - pileupToBed
label: atlas_pileuptobed
doc: "Creating a BED file of regions whose depth in a pileup file is inside a depth range.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: pileup
    type: File
    doc: "Pileup file (from ATLAS pileup)."
    inputBinding:
      position: 1
      prefix: --pileup
  - id: depth
    type: string
    doc: "Depth range of positions to keep, e.g. \"7,30\". Required by ATLAS 2.0.1."
    inputBinding:
      position: 1
      prefix: --depth
  - id: hetero
    type:
      - 'null'
      - File
    doc: "Optional pileup file with only heterogametic samples."
    inputBinding:
      position: 1
      prefix: --hetero
  - id: fit_section
    type:
      - 'null'
      - float
    doc: "Window around the depth mode used to fit the depth distribution."
    inputBinding:
      position: 1
      prefix: --fitSection
  - id: quantile
    type:
      - 'null'
      - float
    doc: "Quantile of the fitted depth distribution to keep."
    inputBinding:
      position: 1
      prefix: --quantile
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_pileupToBed"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: bed
    type: File
    doc: "0-based BED file with the regions whose depth is inside the range."
    outputBinding:
      glob: $(inputs.out_prefix).bed
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_pileuptobed.log
