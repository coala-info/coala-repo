cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sansa
  - annotate
label: sansa_annotate
doc: "Annotate structural variants\n\nTool homepage: https://github.com/dellytools/sansa"
inputs:
  - id: input_bcf
    type: File
    doc: input.bcf
    inputBinding:
      position: 1
  - id: bpoffset
    type:
      - 'null'
      - int
    doc: max. breakpoint offset
    inputBinding:
      position: 102
      prefix: --bpoffset
  - id: contained
    type:
      - 'null'
      - boolean
    doc: report contained genes (useful for CNVs but potentially long list of 
      genes)
    inputBinding:
      position: 102
      prefix: --contained
  - id: db
    type:
      - 'null'
      - File
    doc: database VCF/BCF file
    inputBinding:
      position: 102
      prefix: --db
  - id: distance
    type:
      - 'null'
      - int
    doc: 'max. distance (0: overlapping features only)'
    inputBinding:
      position: 102
      prefix: --distance
  - id: feature
    type:
      - 'null'
      - string
    doc: gtf/gff3 feature
    inputBinding:
      position: 102
      prefix: --feature
  - id: gtf
    type:
      - 'null'
      - File
    doc: gtf/gff3/bed file
    inputBinding:
      position: 102
      prefix: --gtf
  - id: id
    type:
      - 'null'
      - string
    doc: gtf/gff3 attribute
    inputBinding:
      position: 102
      prefix: --id
  - id: nomatch
    type:
      - 'null'
      - boolean
    doc: report SVs without match in database (ANNOID=None)
    inputBinding:
      position: 102
      prefix: --nomatch
  - id: notype
    type:
      - 'null'
      - boolean
    doc: do not require matching SV types
    inputBinding:
      position: 102
      prefix: --notype
  - id: ratio
    type:
      - 'null'
      - float
    doc: min. reciprocal overlap
    inputBinding:
      position: 102
      prefix: --ratio
  - id: strategy
    type:
      - 'null'
      - string
    doc: matching strategy [best|all]
    inputBinding:
      position: 102
      prefix: --strategy
outputs:
  - id: anno
    type:
      - 'null'
      - File
    doc: output annotation VCF/BCF file
    outputBinding:
      glob: $(inputs.anno)
  - id: output
    type:
      - 'null'
      - File
    doc: gzipped output file for query SVs
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sansa:0.2.5--h4d20210_0
