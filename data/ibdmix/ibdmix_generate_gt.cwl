cwlVersion: v1.2
class: CommandLineTool
baseCommand: generate_gt
label: ibdmix_generate_gt
doc: "Produce genotype files from vcfs (archaic and modern sample VCFs, both
  uncompressed text)\n\nTool homepage: https://github.com/PrincetonUniversity/IBDmix"
inputs:
  - id: archaic
    type: File
    doc: The archaic sample vcf (uncompressed text)
    inputBinding:
      position: 1
      prefix: --archaic
  - id: modern
    type: File
    doc: The modern sample vcf (uncompressed text)
    inputBinding:
      position: 2
      prefix: --modern
  - id: output_name
    type: string
    doc: The output file location
    inputBinding:
      position: 3
      prefix: --output
outputs:
  - id: genotype
    type: File
    doc: Merged genotype file, written as uncompressed text
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
