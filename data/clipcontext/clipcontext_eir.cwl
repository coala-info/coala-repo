cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext eir
label: clipcontext_eir
doc: "Extracts exon and intron regions from genomic annotations based on transcript
  sequences.\n\nTool homepage: https://github.com/BackofenLab/CLIPcontext"
inputs:
  - id: gtf
    type: File
    doc: Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: tr
    type: string
    doc: Transcript sequence IDs list file for which to extract exon + intron 
      regions
    inputBinding:
      position: 101
      prefix: --tr
  - id: exon_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `exon_out_path`
    inputBinding:
      position: 102
      prefix: --exon-out
  - id: intron_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `intron_out_path`
    inputBinding:
      position: 103
      prefix: --intron-out
outputs:
  - id: exon_out
    type: File
    doc: Exon regions BED output file
    outputBinding:
      glob: $(inputs.exon_out_path)
  - id: intron_out
    type: File
    doc: Intron regions BED output file
    outputBinding:
      glob: $(inputs.intron_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
