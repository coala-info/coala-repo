cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsd_to_kegg
label: hsdfinder_hsd_to_kegg
doc: "Annotate HSDs (highly similar duplicates) found by hsdfinder with KEGG KO categories\n\nTool homepage: https://github.com/zx0223winner/HSDFinder"
inputs:
  - id: input_file
    type: File
    doc: HSD file
    inputBinding:
      position: 101
      prefix: --input_file=
      separate: false
  - id: ko_file
    type: File
    doc: gene list file with KO annotation
    inputBinding:
      position: 101
      prefix: --ko_file=
      separate: false
  - id: species_name
    type: string
    doc: species name
    inputBinding:
      position: 101
      prefix: --species_name=
      separate: false
  - id: output_file_path
    type: string
    doc: output file name
    inputBinding:
      position: 102
      prefix: --output_file=
      separate: false
outputs:
  - id: output_file
    type: File
    doc: HSDs annotated with KEGG KO categories
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdfinder:1.1.1--hdfd78af_0
