cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - numneigh
label: truvari_anno_numneigh
doc: "For every call within size boundaries, add NumNeighbors info field of how many calls are within the distance and NeighId clustering field in the same chained neighborhood\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: output
    type:
      - 'null'
      - string
    default: numneigh.vcf
    doc: Output vcf (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: refdist
    type:
      - 'null'
      - int
    doc: Max reference location distance (1000)
    inputBinding:
      position: 1
      prefix: "-r"
  - id: sizemin
    type:
      - 'null'
      - int
    doc: Minimum variant size to consider for annotation (50)
    inputBinding:
      position: 1
      prefix: "-s"
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Only count calls with FILTER == PASS
    inputBinding:
      position: 1
      prefix: "--passonly"
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
