cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplocheck
label: haplocheck
doc: "haplocheck 1.3.3\n\nTool homepage: https://github.com/genepi/haplocheck"
inputs:
  - id: vcf_file
    type: File
    doc: VCF File
    inputBinding:
      position: 1
  - id: raw_report
    type:
      - 'null'
      - boolean
    doc: Write raw report
    inputBinding:
      position: 102
      prefix: --raw
  - id: output_report_path
    type: string
    doc: Output or path parameter `output_report_path`
    inputBinding:
      position: 103
      prefix: --output-report
outputs:
  - id: output_report
    type: File
    doc: Output report
    outputBinding:
      glob: $(inputs.output_report_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplocheck:1.3.3--h2a3209d_2
