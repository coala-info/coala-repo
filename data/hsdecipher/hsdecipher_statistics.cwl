cwlVersion: v1.2
class: CommandLineTool
baseCommand: HSD_statistics.py
label: hsdecipher_statistics
doc: "Calculate statistics of highly similar duplicates (HSDs) found with a variety of HSDFinder thresholds\n\nTool homepage: https://github.com/zx0223winner/HSDecipher"
inputs:
  - id: hsd_folder
    type: Directory
    doc: path to HSD species folder
    inputBinding:
      position: 1
  - id: file_format
    type: string
    doc: format of HSD file, e.g. 'txt' or 'tsv'
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: output file name, e.g. species_stat.tsv
    inputBinding:
      position: 3
outputs:
  - id: result_table
    type: File
    doc: result table
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
