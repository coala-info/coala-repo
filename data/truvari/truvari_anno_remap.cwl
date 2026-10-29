cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - remap
label: truvari_anno_remap
doc: "Remap VCF's alleles sequence to the reference to annotate REMAP (novel, tandem, interspersed, partial)\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    doc: BWA indexed reference
    inputBinding:
      position: 1
      prefix: "-r"
  - id: output
    type:
      - 'null'
      - string
    default: remap.vcf
    doc: Output VCF (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: minlength
    type:
      - 'null'
      - int
    doc: Smallest length of allele to remap (50)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for pct of allele covered to consider hit (0.8)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: dist
    type:
      - 'null'
      - int
    doc: Minimum distance an alignment must be from a DEL's position to be considered (10)
    inputBinding:
      position: 1
      prefix: "-d"
  - id: hits
    type:
      - 'null'
      - int
    doc: Report top hits as chr:start-end.pct (max 0)
    inputBinding:
      position: 1
      prefix: "-H"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: input
    type: File
    doc: Input VCF
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
