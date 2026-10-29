cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - consistency
label: truvari_consistency
doc: "Over multiple vcfs, calculate their intersection/consistency. Calls will match between VCFs if they have a matching key of `CHROM POS ID REF ALT`\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: no_dups
    type:
      - 'null'
      - boolean
    doc: Disallow duplicate SVs
    inputBinding:
      position: 1
      prefix: "-d"
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output report in json format
    inputBinding:
      position: 1
      prefix: "-j"
  - id: output
    type:
      - 'null'
      - string
    doc: Write tsv of variant keys, flag, vcf_count
    inputBinding:
      position: 1
      prefix: "-o"
  - id: vcfs
    type:
      type: array
      items: File
    doc: VCFs to intersect
    inputBinding:
      position: 2
stdout: consistency_report.txt
outputs:
  - id: report
    type: stdout
    doc: Consistency report (text, or json with --json)
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Tsv of variant keys, flag and vcf_count (with --output)
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
