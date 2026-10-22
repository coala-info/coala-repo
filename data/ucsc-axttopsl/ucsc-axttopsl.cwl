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
    doc: Target sizes file (tab-delimited seqName and size, typically a .chrom.sizes
      file)
    inputBinding:
      position: 2
  - id: q_sizes
    type: File
    doc: Query sizes file (tab-delimited seqName and size, typically a .chrom.sizes
      file)
    inputBinding:
      position: 3
  - id: psl_out_path
    type: string
    doc: Name of the output psl file
    inputBinding:
      position: 4
outputs:
  - id: psl_out
    type: File
    doc: Output psl file
    outputBinding:
      glob: $(inputs.psl_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttopsl:482--h0b57e2e_0
