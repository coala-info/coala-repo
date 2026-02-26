cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnftools validate
label: rnftools_validate
doc: "Validate RNF names in a FASTQ file.\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: all_occurrences
    type:
      - 'null'
      - boolean
    doc: Report all occurrences of warnings and errors.
    inputBinding:
      position: 101
      prefix: --all-occurrences
  - id: fastq_file
    type: File
    doc: FASTQ file to be validated.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: warnings_as_errors
    type:
      - 'null'
      - boolean
    doc: Treat warnings as errors.
    inputBinding:
      position: 101
      prefix: --warnings-as-errors
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
stdout: rnftools_validate.out
