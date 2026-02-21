cwlVersion: v1.2
class: CommandLineTool
baseCommand: afwdist
label: afwdist
doc: "allele frequency-weighted distances\n\nTool homepage: https://github.com/PathoGenOmics-Lab/afwdist"
inputs:
  - id: include_reference
    type:
      - 'null'
      - boolean
    doc: Include reference as a sample with 100% fixed alleles
    inputBinding:
      position: 101
      prefix: --include-reference
  - id: input
    type: File
    doc: Input tree in CSV format (mandatory CSV columns are 'sample', 'position',
      'sequence' and 'frequency')
    inputBinding:
      position: 101
      prefix: --input
  - id: reference
    type: File
    doc: Reference sequence in FASTA format
    inputBinding:
      position: 101
      prefix: --reference
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable debug messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output CSV file with distances between each pair of samples
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afwdist:1.0.0--h4349ce8_0
