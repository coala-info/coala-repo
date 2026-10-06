cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - from-uc
label: biom-format_from_uc
doc: "Create a BIOM table from a vsearch/uclust/usearch BIOM file.\n\nTool homepage: http://www.biom-format.org"
inputs:
  - id: input_fp
    type: File
    doc: The input uc filepath.
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: output_fp
    type: string
    doc: The output BIOM filepath
    inputBinding:
      position: 101
      prefix: --output-fp
  - id: rep_set_fp
    type:
      - 'null'
      - File
    doc: Fasta file containing representative sequences labeled with OTU identifiers, whose
      description fields contain original sequence identifiers.
    inputBinding:
      position: 101
      prefix: --rep-set-fp
outputs:
  - id: output_table
    type: File
    doc: The output BIOM table
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
