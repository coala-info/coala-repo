cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - export
  - mean_counts
label: transit_export_mean_counts
doc: "Export the mean insertion counts of each gene from wig files or a combined wig file.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type: File[]
    doc: "Comma-separated .wig files, or one combined_wig file when combined_wig_input is set"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: annotation_prot_table
    type: File
    doc: "Annotation .prot_table file"
    inputBinding:
      position: 2
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 3
  - id: combined_wig_input
    type: ['null', boolean]
    doc: "Set if the input is a combined_wig file"
    inputBinding:
      position: 20
      prefix: -c
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
