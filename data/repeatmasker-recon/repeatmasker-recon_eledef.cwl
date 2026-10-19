cwlVersion: v1.2
class: CommandLineTool
baseCommand: eledef
label: repeatmasker-recon_eledef
doc: "Define elements from the sorted MSP images (second step of repeatmasker-recon).\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: summary
        writable: true
        entry: $(inputs.summary)
      - entryname: ele_def_res
        writable: true
        entry: '$({"class": "Directory", "listing": []})'
      - entryname: images
        entry: $(inputs.images)
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
  - id: method
    type: string
    doc: Method, choose 'single' or 'double'
    inputBinding:
      position: 3
  - id: cut_off
    type:
      - 'null'
      - int
    doc: Cut-off (optional)
    inputBinding:
      position: 4
  - id: images
    type: Directory
    doc: Folder with the sorted images (images_sorted), made by imagespread and sort
  - id: summary
    type: Directory
    doc: Summary folder from the earlier steps (msp_no, naive_ele_no, ...); staged writable
outputs:
  - id: summary_out
    type: Directory
    doc: Summary folder with the state files of this step added
    outputBinding:
      glob: summary
  - id: ele_def_res
    type: Directory
    doc: Initial element definitions, one file per element
    outputBinding:
      glob: ele_def_res
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
