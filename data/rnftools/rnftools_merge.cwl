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
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type: File
    doc: output prefix
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
