cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - gcpct
label: truvari_anno_gcpct
doc: "Annotates GC content of SVs\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: output
    type:
      - 'null'
      - string
    default: gcpct.vcf
    doc: Output filename (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Reference fasta
    inputBinding:
      position: 1
      prefix: "-r"
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
