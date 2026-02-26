cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - octopusv
  - svcf2vcf
label: octopusv_svcf2vcf
doc: "Convert SVCF file to VCF format.\n\nTool homepage: https://github.com/ylab-hi/octopusV"
inputs:
  - id: input_file
    type: File
    doc: Input SVCF file to convert.
    inputBinding:
      position: 101
      prefix: --input-file
outputs:
  - id: output_file
    type: File
    doc: Output VCF file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
