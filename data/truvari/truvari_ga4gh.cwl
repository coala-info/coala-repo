cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - ga4gh
label: truvari_ga4gh
doc: "Consolidate truvari by truth/query and annotate with GA4GH intermediates tags\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: input
    type: Directory
    doc: Truvari result directory
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output
    type: string
    doc: Output prefix
    inputBinding:
      position: 1
      prefix: "-o"
  - id: no_refine
    type:
      - 'null'
      - boolean
    doc: Don't pull from refined results
    inputBinding:
      position: 1
      prefix: "-r"
  - id: write_phab
    type:
      - 'null'
      - boolean
    doc: Count/Write the phab variant representations
    inputBinding:
      position: 1
      prefix: "-w"
  - id: buffer
    type:
      - 'null'
      - int
    doc: Amount of buffer used around refined regions (0)
    inputBinding:
      position: 1
      prefix: "-b"
outputs:
  - id: base_vcf
    type: File
    doc: GA4GH-tagged truth VCF (bgzipped)
    secondaryFiles: &id001
      - .tbi
    outputBinding:
      glob: "$(inputs.output).base.vcf.gz"
  - id: comp_vcf
    type: File
    doc: GA4GH-tagged query VCF (bgzipped)
    secondaryFiles: *id001
    outputBinding:
      glob: "$(inputs.output).comp.vcf.gz"
  - id: summary_json
    type: File
    doc: GA4GH summary statistics
    outputBinding:
      glob: "$(inputs.output).summary.json"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
