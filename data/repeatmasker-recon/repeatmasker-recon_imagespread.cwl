cwlVersion: v1.2
class: CommandLineTool
baseCommand: imagespread
label: repeatmasker-recon_imagespread
doc: "Spread the MSPs into images (first step of repeatmasker-recon).\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: summary
        writable: true
        entry: '$({"class": "Directory", "listing": []})'
      - entryname: images
        writable: true
        entry: '$({"class": "Directory", "listing": []})'
inputs:
  - id: seq_list
    type: File
    doc: List of sequence names (first line is the number of names)
    inputBinding:
      position: 1
  - id: msp_file
    type: File
    doc: MSP file (score %iden start end query_name start end subject_name)
    inputBinding:
      position: 2
  - id: number_of_output_files
    type:
      - 'null'
      - int
    doc: Number of output files (default 1)
    inputBinding:
      position: 3
outputs:
  - id: images
    type: Directory
    doc: Folder with the spread files (spread1, spread2, ...)
    outputBinding:
      glob: images
  - id: summary
    type: Directory
    doc: Summary folder (msp_no)
    outputBinding:
      glob: summary
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
