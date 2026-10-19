cwlVersion: v1.2
class: CommandLineTool
baseCommand: famdef
label: repeatmasker-recon_famdef
doc: "Define families (last step of repeatmasker-recon). Reads the re-defined edges as folder tmp and writes the summary folder.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: tmp
        writable: true
        entry: $(inputs.edge_redef_res)
      - entryname: summary
        writable: true
        entry: $(inputs.summary)
      - entryname: images
        entry: $(inputs.images)
inputs:
  - id: seq_list
    type: File
    doc: List of sequence names (first line is the number of names)
    inputBinding:
      position: 1
  - id: edge_redef_res
    type: Directory
    doc: Folder with the re-defined edges (edgeredef output); staged writable as tmp, famdef writes log2 into it
  - id: images
    type: Directory
    doc: Folder with the sorted images (images_sorted)
  - id: summary
    type: Directory
    doc: Summary folder from the earlier steps (msp_no, naive_ele_no, redef_ele_no); staged writable
outputs:
  - id: summary_out
    type: Directory
    doc: Final results (eles, fams and related summary files)
    outputBinding:
      glob: summary
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
