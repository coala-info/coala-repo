cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - dpdiff
label: viral-ngs_assembly_dpdiff
doc: "Take input VCF files (all with only one sample each) and report on the discrepancies between the two DP fields (one in INFO and one in the sample's genotype column).\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_vcfs
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Input VCF file"
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: "Output flat file"
    inputBinding:
      position: 2
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: out_file_file
    type: File
    doc: "Output file written to out_file"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
