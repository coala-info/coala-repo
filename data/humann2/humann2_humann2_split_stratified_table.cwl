cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_split_stratified_table
label: humann2_humann2_split_stratified_table
doc: "Split stratified table\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "the stratified input table (tsv, tsv.gzip, tsv.bzip2, or biom format)"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_path
    type: string
    doc: "the output folder"
    inputBinding:
      position: 102
      prefix: "--output"
outputs:
  - id: output
    type: Directory
    doc: "folder with the stratified and unstratified tables"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
