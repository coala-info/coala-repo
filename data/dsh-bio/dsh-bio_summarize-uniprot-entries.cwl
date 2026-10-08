cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dsh-summarize-uniprot-entries
label: dsh-bio_summarize-uniprot-entries
doc: "summarize UniProt entries in XML format\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_uniprot_xml_path
    type: File
    doc: "input UniProt XML path, default stdin"
    inputBinding:
      position: 101
      prefix: --input-uniprot-xml-path
  - id: output_summary_file_path
    type: string
    doc: "output summary file, default stdout"
    inputBinding:
      position: 101
      prefix: --output-summary-file
outputs:
  - id: output_summary_file
    type:
      - 'null'
      - File
    doc: "output summary file, default stdout"
    outputBinding:
      glob: $(inputs.output_summary_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
