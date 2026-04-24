cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-lavtopsl
label: ucsc-lavtopsl_lavToPsl
doc: "Convert blastz lav to psl format\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_lav
    type: File
    doc: Input lav file
    inputBinding:
      position: 1
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: output bed instead of psl
    inputBinding:
      position: 102
      prefix: -bed
  - id: score_file
    type:
      - 'null'
      - File
    doc: output lav scores to side file, such that each psl line in out.psl is 
      matched by a score line.
    inputBinding:
      position: 102
      prefix: -scoreFile
  - id: target_strand
    type:
      - 'null'
      - string
    doc: set the target strand to c (default is no strand)
    inputBinding:
      position: 102
      prefix: -target-strand
outputs:
  - id: output_psl
    type: File
    doc: Output psl file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-lavtopsl:482--h0b57e2e_0
