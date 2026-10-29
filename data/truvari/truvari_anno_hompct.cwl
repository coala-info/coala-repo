cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - hompct
label: truvari_anno_hompct
doc: "Calculate the Hom / (Het + Hom) of variants in the region of SVs. Requires the VCF to contain SVs beside SNPs/Indels\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .tbi
    doc: Compressed, indexed VCF to annotate
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output
    type:
      - 'null'
      - string
    default: hompct.vcf
    doc: Output filename (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: buffer
    type:
      - 'null'
      - int
    doc: Number of base-pairs up/dn-stream to query (5000)
    inputBinding:
      position: 1
      prefix: "-b"
  - id: minanno
    type:
      - 'null'
      - int
    doc: Minimum size of event to annotate (50)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: maxgt
    type:
      - 'null'
      - int
    doc: Largest event size to count for genotyping (1)
    inputBinding:
      position: 1
      prefix: "-M"
  - id: mincount
    type:
      - 'null'
      - int
    doc: Minimum number of genotyping events to report HOMPCT (0)
    inputBinding:
      position: 1
      prefix: "-c"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
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
