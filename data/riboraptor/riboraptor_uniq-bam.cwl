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
outputs:
  - id: outbam
    type: File
    outputBinding:
      glob: $(inputs.outbam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
