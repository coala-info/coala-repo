cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - modify
label: checkm-genome_modify
doc: "[Experimental] Modify sequences in a bin.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: seq_file
    type: File
    doc: 'sequences used to generate bins (fasta format)'
    inputBinding:
      position: 1
  - id: bin_file
    type: File
    doc: 'bin to be modified'
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: 'modified bin'
    inputBinding:
      position: 3
  - id: add
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --add
    doc: 'ID of sequence to add to bin (may specify multiple times)'
    inputBinding:
      position: 101
  - id: remove
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove
    doc: 'ID of sequence to remove from bin (may specify multiple times)'
    inputBinding:
      position: 101
  - id: outlier_file
    type:
      - 'null'
      - File
    doc: 'remove all sequences marked as outliers in the bin (see outlier command)'
    inputBinding:
      position: 101
      prefix: --outlier_file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_file_out
    type: File
    doc: 'modified bin'
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
