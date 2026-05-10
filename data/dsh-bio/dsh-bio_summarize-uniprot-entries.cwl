cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_summarize-uniprot-entries
label: dsh-bio_summarize-uniprot-entries
doc: "Summarizes UniProt entries from XML files.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: uniprot_xml_files
    type:
      type: array
      items: File
    doc: One or more UniProt XML files to process.
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The file to write the summary to. Defaults to standard output.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
