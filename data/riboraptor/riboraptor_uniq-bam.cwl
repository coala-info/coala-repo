cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - uniq-bam
label: riboraptor_uniq-bam
doc: "Create a new bam with unique mapping reads only\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: inbam
    type: File
    inputBinding:
      position: 101
      prefix: --inbam
  - id: outbam_path
    type: string
    doc: Output or path parameter `outbam_path`
    inputBinding:
      position: 102
      prefix: --outbam
outputs:
  - id: outbam
    type: File
    outputBinding:
      glob: $(inputs.outbam_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
