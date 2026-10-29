cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - dpcnt
label: truvari_anno_dpcnt
doc: "Quick utility to count how many samples have >= Nx coverage per-variant\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: bins
    type:
      - 'null'
      - string
    doc: Coverage bins to bisect left the counts (0,5,10,15)
    inputBinding:
      position: 1
      prefix: "-b"
  - id: no_ad
    type:
      - 'null'
      - boolean
    doc: Skip adding ADCNT bins
    inputBinding:
      position: 1
      prefix: "--no-ad"
  - id: present
    type:
      - 'null'
      - boolean
    doc: Only count sites with present (non ./.) genotypes
    inputBinding:
      position: 1
      prefix: "-p"
  - id: output
    type:
      - 'null'
      - string
    default: dpcnt.vcf
    doc: Output filename (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
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
