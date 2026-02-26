cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnftools merge
label: rnftools_merge
doc: "todo\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input FASTQ files
    inputBinding:
      position: 101
      prefix: -i
  - id: mode
    type: string
    doc: mode for mergeing files (single-end / paired-end-bwa / 
      paired-end-bfast)
    inputBinding:
      position: 101
      prefix: -m
outputs:
  - id: output_prefix
    type: File
    doc: output prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
