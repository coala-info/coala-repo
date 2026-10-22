cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SHAPEIT5_switch]
label: shapeit5_switch
doc: "Compute switch error rates and calibration of a phased dataset against a validation dataset (SHAPEIT5 switch).\n\nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs:
  - id: validation
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Validation dataset in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --validation
  - id: estimation
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Phased dataset in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --estimation
  - id: frequency
    type: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: Variant frequency in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --frequency
  - id: pedigree
    type: ['null', File]
    doc: Pedigree file in PED format
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: region
    type: ['null', string]
    doc: Target region
    inputBinding:
      position: 101
      prefix: --region
  - id: nbins
    type: ['null', int]
    doc: Number of bins used for calibration
    inputBinding:
      position: 101
      prefix: --nbins
  - id: min_pp
    type: ['null', float]
    doc: Minimal PP value for entering computations
    inputBinding:
      position: 101
      prefix: --min-pp
  - id: singleton
    type: ['null', boolean]
    doc: Trick to phase singleton
    inputBinding:
      position: 101
      prefix: --singleton
  - id: dupid
    type: ['null', boolean]
    doc: Duplicate ID for UKB matching IDs
    inputBinding:
      position: 101
      prefix: --dupid
  - id: thread
    type: ['null', int]
    doc: Number of thread used
    inputBinding:
      position: 101
      prefix: --thread
  - id: output_prefix
    type: string
    doc: Prefix for all report files
    inputBinding:
      position: 102
      prefix: --output
  - id: log_path
    type: ['null', string]
    doc: Log file
    inputBinding:
      position: 103
      prefix: --log
outputs:
  - id: reports
    type: File[]
    doc: Report files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix).*
  - id: log
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
