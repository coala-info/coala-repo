cwlVersion: v1.2
class: CommandLineTool
baseCommand: subsample_outputs.pl
label: pirate_subsample_outputs.pl
doc: "Subsamples PIRATE gene family files based on GFFs and isolates.\n\nTool homepage:
  https://github.com/SionBayliss/PIRATE"
inputs:
  - id: feature
    type:
      - 'null'
      - string
    doc: feature type to include
    inputBinding:
      position: 101
      prefix: --feature
  - id: field
    type:
      - 'null'
      - string
    doc: replace locus tag with value from field
    inputBinding:
      position: 101
      prefix: --field
  - id: gff_directory
    type: Directory
    doc: path to gff directory
    inputBinding:
      position: 101
      prefix: --gffs
  - id: input_file
    type: File
    doc: input PIRATE.gene_families.tsv file
    inputBinding:
      position: 101
      prefix: --input
  - id: list
    type:
      - 'null'
      - string
    doc: list of isolates to include in output
    inputBinding:
      position: 101
      prefix: --list
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: path to output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirate:1.0.5--hdfd78af_3
