cwlVersion: v1.2
class: CommandLineTool
baseCommand: [python, /usr/local/bin/prepare-SV-breakpoints.py]
label: neoloop_prepare-SV-breakpoints
doc: "Convert a table of SV calls (id, chrom1, start1, end1, strand1, chrom2, start2,
  end2, strand2, ..., resolution) into the 6-column break point list (chrA, chrB,
  orientation, b1, b2, type) used by assemble-complexSVs. Only rows whose last column
  is 10kb are kept.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: input_sv_table
    type: File
    doc: Whitespace-separated SV table.
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output break point list.
    inputBinding:
      position: 2
outputs:
  - id: break_points
    type: File
    doc: Break point list for assemble-complexSVs.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
