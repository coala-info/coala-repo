cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - common_errors_from_bam
label: pomoxis_common_errors_from_bam
doc: "Get errors common to multiple assemblies aligned to a reference.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: Input bam file containing assemblies trimmed to a common alignment window.
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    doc: Reference fasta file of the reference over that alignment window (with its .fai index next to it).
    inputBinding:
      position: 2
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: output_prefix
    type:
      - 'null'
      - string
    default: common_errors
    doc: Prefix for outputs.
    inputBinding:
      position: 102
      prefix: --output_prefix
outputs:
  - id: common_errors_fasta
    type: File
    doc: Reference with only the common errors.
    outputBinding:
      glob: $(inputs.output_prefix).fasta
  - id: common_errors_txt
    type: File
    doc: Q scores of each assembly and of the common errors.
    outputBinding:
      glob: $(inputs.output_prefix).txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
