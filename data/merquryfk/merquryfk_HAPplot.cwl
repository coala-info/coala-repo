cwlVersion: v1.2
class: CommandLineTool
baseCommand: HAPplot
label: merquryfk_HAPplot
doc: "Plots HAP data\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs:
  - id: mat_hap_ktab
    type: File
    doc: mat[.hap[.ktab]]
    inputBinding:
      position: 1
  - id: pat_hap_ktab
    type: File
    doc: pat[.hap[.ktab]]
    inputBinding:
      position: 2
  - id: asm1_dna
    type: string
    doc: asm1:dna
    inputBinding:
      position: 3
  - id: asm2_dna
    type:
      - 'null'
      - string
    doc: asm2:dna
    inputBinding:
      position: 4
  - id: height
    type:
      - 'null'
      - float
    doc: height in inches of plots
    inputBinding:
      position: 105
      prefix: -h
  - id: keep_plotting_data
    type:
      - 'null'
      - boolean
    doc: keep plotting data as <out>.hpi for a later go
    inputBinding:
      position: 105
      prefix: -k
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: output .pdf (default is .png)
    inputBinding:
      position: 105
      prefix: -pdf
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Place all temporary files in directory -P.
    inputBinding:
      position: 105
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 105
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output to stderr
    inputBinding:
      position: 105
      prefix: -v
  - id: width
    type:
      - 'null'
      - float
    doc: width in inches of plots
    inputBinding:
      position: 105
      prefix: -w
outputs:
  - id: out_hpi
    type: File
    doc: out[.hpi]
    outputBinding:
      glob: '*.out'
  - id: output_hpi_alt
    type: File
    doc: out[.hpi] (alternative usage)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
