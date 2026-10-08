cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - export
  - igv
label: transit_export_igv
doc: "Export wig files to the IGV format (.igv).\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type: File[]
    doc: "Comma-separated .wig files"
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
outputs:
  - id: output_file
    type: File
    doc: "IGV file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
