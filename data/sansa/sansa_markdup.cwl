cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sansa
  - markdup
label: sansa_markdup
doc: "Filter sites for PASS\n\nTool homepage: https://github.com/dellytools/sansa"
inputs:
  - id: input_bcf
    type: File
    doc: Input BCF file
    inputBinding:
      position: 1
  - id: bpdiff
    type:
      - 'null'
      - int
    doc: max. SV breakpoint offset
    inputBinding:
      position: 102
      prefix: --bpdiff
  - id: carrier
    type:
      - 'null'
      - float
    doc: min. fraction of shared SV carriers
    inputBinding:
      position: 102
      prefix: --carrier
  - id: divergence
    type:
      - 'null'
      - float
    doc: max. SV allele divergence
    inputBinding:
      position: 102
      prefix: --divergence
  - id: pass
    type:
      - 'null'
      - boolean
    doc: Filter sites for PASS
    inputBinding:
      position: 102
      prefix: --pass
  - id: quality
    type:
      - 'null'
      - int
    doc: min. SV site quality
    inputBinding:
      position: 102
      prefix: --quality
  - id: sizeratio
    type:
      - 'null'
      - float
    doc: min. SV size ratio
    inputBinding:
      position: 102
      prefix: --sizeratio
  - id: tag
    type:
      - 'null'
      - boolean
    doc: Tag duplicate marked sites in the FILTER column instead of removing 
      them
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Filtered SV BCF output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sansa:0.2.5--h4d20210_0
