cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - mappingqc
label: microhapulator_mhpl8r_mappingqc
doc: "Calculate number of on target, off target, repetitive, and contaminant reads and create a donut plot\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: csv
    type: string
    doc: "write read counts to FILE in CSV format"
    default: "mapping-qc.csv"
    inputBinding:
      position: 1
      prefix: --csv
  - id: figure
    type: ['null', string]
    doc: "create donut plot to FILE showing porportions of on target, off target, repetitive, and contaminant reads"
    inputBinding:
      position: 1
      prefix: --figure
  - id: title
    type: ['null', string]
    doc: "add a title (such as a sample name) to the donut plot"
    inputBinding:
      position: 1
      prefix: --title
  - id: marker
    type: File
    doc: "path of csv file containing number of reads mapped to marker sequences"
    inputBinding:
      position: 2
  - id: refr
    type: File
    doc: "path of csv file containing number of reads mapped to full reference genome"
    inputBinding:
      position: 3
  - id: rep
    type: File
    doc: "path of csv file containing number of repetitive reads per marker"
    inputBinding:
      position: 4
outputs:
  - id: csv_file
    type: File
    doc: "Read counts (on target, off target, contaminant, repetitive) in CSV format"
    outputBinding:
      glob: $(inputs.csv)
  - id: figure_file
    type: ['null', File]
    doc: "Donut plot (written with --figure)"
    outputBinding:
      glob: $(inputs.figure)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
