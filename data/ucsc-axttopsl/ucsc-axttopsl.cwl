cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtToPsl
label: ucsc-axttopsl
doc: "Convert axt to psl format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: axt_in
    type: File
    doc: Input axt file
    inputBinding:
      position: 1
  - id: t_sizes
    type: File
    doc: Target sizes file (typically a .chrom.sizes file)
    inputBinding:
      position: 2
  - id: q_sizes
    type: File
    doc: Query sizes file (typically a .chrom.sizes file)
    inputBinding:
      position: 3
outputs:
  - id: psl_out
    type: File
    doc: Output psl file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttopsl:482--h0b57e2e_0
