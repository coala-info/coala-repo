cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - delly
  - merge
label: delly_merge
doc: "Merge SV BCF files\n\nTool homepage: https://github.com/dellytools/delly"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BCF files or a text file listing BCF files
    inputBinding:
      position: 1
  - id: bp_offset
    type:
      - 'null'
      - int
    doc: max. breakpoint offset
    default: 1000
    inputBinding:
      position: 102
      prefix: --bp-offset
  - id: chunks
    type:
      - 'null'
      - int
    doc: max. chunk size to merge groups of BCF files
    default: 500
    inputBinding:
      position: 102
      prefix: --chunks
  - id: cnvmode
    type:
      - 'null'
      - boolean
    doc: Merge delly CNV files
    inputBinding:
      position: 102
      prefix: --cnvmode
  - id: coverage
    type:
      - 'null'
      - int
    doc: min. coverage
    default: 5
    inputBinding:
      position: 102
      prefix: --coverage
  - id: maxsize
    type:
      - 'null'
      - int
    doc: max. SV size
    default: 1000000
    inputBinding:
      position: 102
      prefix: --maxsize
  - id: minsize
    type:
      - 'null'
      - int
    doc: min. SV size
    default: 0
    inputBinding:
      position: 102
      prefix: --minsize
  - id: pass
    type:
      - 'null'
      - boolean
    doc: Filter sites for PASS
    inputBinding:
      position: 102
      prefix: --pass
  - id: precise
    type:
      - 'null'
      - boolean
    doc: Filter sites for PRECISE
    inputBinding:
      position: 102
      prefix: --precise
  - id: quality
    type:
      - 'null'
      - int
    doc: min. SV site quality
    default: 200
    inputBinding:
      position: 102
      prefix: --quality
  - id: rec_overlap
    type:
      - 'null'
      - float
    doc: min. reciprocal overlap
    default: 0.800000012
    inputBinding:
      position: 102
      prefix: --rec-overlap
  - id: vaf
    type:
      - 'null'
      - float
    doc: min. fractional ALT support
    default: 0.150000006
    inputBinding:
      position: 102
      prefix: --vaf
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Merged SV BCF output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delly:1.7.2--h4d20210_0
