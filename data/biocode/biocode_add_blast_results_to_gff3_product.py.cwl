cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_blast_results_to_gff3_product.py
label: biocode_add_blast_results_to_gff3_product.py
doc: "Updates GFF3 files with gene products from BLAST\n\nTool homepage: http://github.com/jorvis/biocode"
inputs:
  - id: blast
    type: File
    doc: Path to an input BLAST tab file to be read
    inputBinding:
      position: 101
      prefix: --blast
  - id: input_file
    type: File
    doc: Path to an input GFF3 file to be read
    inputBinding:
      position: 101
      prefix: --input_file
  - id: source
    type: string
    doc: Becomes the source (2nd) column of the GFF output
    inputBinding:
      position: 101
      prefix: --source
outputs:
  - id: output_file
    type: File
    doc: Path to an output GFF3 file to be created
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
