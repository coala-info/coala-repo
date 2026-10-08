cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - convert
  - gff_to_prot_table
label: transit_convert_gff_to_prot_table
doc: "Convert an annotation in GFF format to the .prot_table format used by Transit.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: annotation_gff
    type: File
    doc: "Annotation in GFF format"
    inputBinding:
      position: 1
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: "Output .prot_table file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
