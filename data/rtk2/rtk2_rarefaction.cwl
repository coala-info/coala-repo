cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtk
label: rtk2_rarefaction
doc: "rarefaction tool kit (rtk)\n\nTool homepage: https://github.com/hildebra/rtk2/"
inputs:
  - id: mode
    type: string
    doc: 'For rarefaction: mode can be either swap or memory. Swap mode creates temporary
      files but uses less memory. The speed of both modes is comparable.'
    inputBinding:
      position: 1
  - id: depth
    type:
      - 'null'
      - string
    doc: Depth or multiple comma seperated depths to rarefy to.
    default: 0.95 times the minimal column sum
    inputBinding:
      position: 102
      prefix: -d
  - id: input_file
    type: File
    doc: path to an .txt file (tab delimited) to rarefy
    inputBinding:
      position: 102
      prefix: -i
  - id: no_temp_files
    type:
      - 'null'
      - boolean
    doc: If set, no temporary files will be used when writing rarefaction tables
      to disk.
    inputBinding:
      position: 102
      prefix: -ns
  - id: num_diversity_measures
    type:
      - 'null'
      - int
    doc: Number of times to create diversity measures.
    default: 10
    inputBinding:
      position: 102
      prefix: -r
  - id: num_rarefied_tables
    type:
      - 'null'
      - int
    doc: Number of rarefied tables to write.
    inputBinding:
      position: 102
      prefix: -w
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output
    type: Directory
    doc: path to a output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtk2:2.11.2--h077b44d_1
