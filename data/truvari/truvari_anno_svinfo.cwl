cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - svinfo
label: truvari_anno_svinfo
doc: "Adds SVTYPE and SVLEN INFO fields\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: output
    type:
      - 'null'
      - string
    default: svinfo.vcf
    doc: Output filename (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: minsize
    type:
      - 'null'
      - int
    doc: Minimum size of entry to annotate (50)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: input
    type: File
    doc: VCF to annotate (stdin in the tool; a file here)
    inputBinding:
      position: 2
outputs:
  - id: output_vcf
    type: File
    doc: Annotated VCF
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
