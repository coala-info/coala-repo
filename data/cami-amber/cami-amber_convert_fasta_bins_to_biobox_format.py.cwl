cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_fasta_bins_to_biobox_format.py
label: cami-amber_convert_fasta_bins_to_biobox_format.py
doc: "Convert bins in FASTA files to CAMI tsv format\n\nTool homepage: https://github.com/CAMI-challenge/AMBER"
inputs:
  - id: paths
    type:
      type: array
      items: File
    doc: FASTA files including full paths
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
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
