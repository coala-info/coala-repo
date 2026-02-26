cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - hapcut2vcf
label: whatshap_hapcut2vcf
doc: "Convert hapCUT output format to VCF\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF file
    inputBinding:
      position: 1
  - id: hapcut_result
    type: File
    doc: hapCUT result file
    inputBinding:
      position: 2
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file. If omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
