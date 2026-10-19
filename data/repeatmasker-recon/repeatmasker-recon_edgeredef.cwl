cwlVersion: v1.2
class: CommandLineTool
baseCommand: edgeredef
label: repeatmasker-recon_edgeredef
doc: "Re-define edges (fourth step of repeatmasker-recon). Reads the re-defined elements as folder tmp and writes folder tmp2.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: summary
        writable: true
        entry: $(inputs.summary)
      - entryname: tmp
        entry: $(inputs.ele_redef_res)
      - entryname: tmp2
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
  - id: start
    type:
      - 'null'
      - int
    doc: Index of the element to start defining families (optional)
    inputBinding:
      position: 2
  - id: ele_redef_res
    type: Directory
    doc: Folder with the re-defined elements (eleredef output); staged as tmp
  - id: images
    type: Directory
    doc: Folder with the sorted images (images_sorted)
  - id: summary
    type: Directory
    doc: Summary folder from the earlier steps (msp_no, naive_ele_no, ...); staged writable
outputs:
  - id: summary_out
    type: Directory
    doc: Summary folder with the state files of this step added
    outputBinding:
      glob: summary
  - id: edge_redef_res
    type: Directory
    doc: Re-defined edges, one file per element
    outputBinding:
      glob: tmp2
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
