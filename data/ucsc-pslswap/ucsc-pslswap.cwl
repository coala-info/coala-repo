cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSwap
label: ucsc-pslswap
doc: "Swap target and query in a PSL file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 10
  - id: out_psl
    type: string
    doc: Output PSL file name.
    inputBinding:
      position: 11
  - id: no_rc
    type:
      - 'null'
      - boolean
    doc: Do not reverse complement untranslated alignments to keep the target on the
      positive strand. This makes the target strand explicit.
    inputBinding:
      position: 1
      prefix: -noRc
outputs:
  - id: out_psl_file
    type: File
    doc: Output PSL file with target and query swapped.
    outputBinding:
      glob: $(inputs.out_psl)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslswap:482--h0b57e2e_0
