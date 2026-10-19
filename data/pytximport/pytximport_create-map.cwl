cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pytximport
  - create-map
label: pytximport_create-map
doc: "Create a transcript-to-gene mapping file via the command line.\n\nTool homepage:
  https://pytximport.readthedocs.io/en/latest/start.html"
inputs:
  - id: input_file
    type: File
    doc: The path to the annotation GTF file.
    inputBinding:
      position: 1
      prefix: --input
  - id: output_file_path
    type: string
    doc: The output path to save the resulting transcript-to-gene mapping file 
      to.
    inputBinding:
      position: 1
      prefix: --output
  - id: output_path_overwrite
    type:
      - 'null'
      - boolean
    doc: Provide this flag to overwrite an existing file at the output path.
    inputBinding:
      position: 1
      prefix: --save-path-overwrite
  - id: source_field
    type:
      - 'null'
      - string
    doc: The annotation field to use as the source in the mapping file.
    inputBinding:
      position: 1
      prefix: --source-field
  - id: target_field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --target-field
    doc: The annotation field(s) to use as the target in the mapping file.
    inputBinding:
      position: 1
  - id: keep_biotype
    type:
      - 'null'
      - boolean
    doc: Provide this flag to keep the gene_biotype column as an additional 
      column in the mapping file.
    inputBinding:
      position: 1
      prefix: --keep-biotype
outputs:
  - id: output_file
    type: File
    doc: The transcript-to-gene mapping file.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytximport:0.12.0--pyhdfd78af_0
