cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools kcf2tsv
label: kcftools_kcf2tsv
doc: "Convert KCF file to TSV file (IBSpy like)\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: input_kcf_file
    type: File
    doc: KCF file name
    inputBinding:
      position: 101
      prefix: --input
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
outputs:
  - id: output_file_prefix
    type: File
    doc: Output file name Prefix
    outputBinding:
      glob: $(inputs.output_file_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
