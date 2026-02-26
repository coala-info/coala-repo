cwlVersion: v1.2
class: CommandLineTool
baseCommand: cage
label: cage
doc: "Changepoint detection for efficient variant calling\n\nTool homepage: https://github.com/docker/cagent"
inputs:
  - id: contig
    type: string
    doc: contig name
    inputBinding:
      position: 1
  - id: start
    type: int
    doc: start position
    inputBinding:
      position: 2
  - id: end
    type: int
    doc: end position
    inputBinding:
      position: 3
  - id: stepsize
    type: int
    doc: step size
    inputBinding:
      position: 4
  - id: beta
    type: float
    doc: beta parameter for PELT
    inputBinding:
      position: 5
  - id: input_snp_db
    type:
      - 'null'
      - File
    doc: Filename of sqlite3 SNP database
    inputBinding:
      position: 106
      prefix: --input_SNP_db
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output of CAGe
    inputBinding:
      position: 106
      prefix: --verbose
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: File to output variants called when running CAGe
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: cage_output_file
    type: File
    doc: File to output the changepoints determined by CAGe
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cage:2016.05.13--he8c0b07_8
