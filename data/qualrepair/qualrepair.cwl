cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualrepair
label: qualrepair
doc: "Update the FASTQ quality scores from a subsequence FASTQ.\n\nTool homepage:
  https://github.com/clintval/qualrepair"
inputs:
  - id: in_source
    type: File
    doc: Source FASTQ file.
    inputBinding:
      position: 101
      prefix: --in-source
  - id: in_subseq
    type: File
    doc: Subsequence FASTQ file.
    inputBinding:
      position: 101
      prefix: --in-subseq
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output repaired FASTQ file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualrepair:1.0.0--pyhdfd78af_0
