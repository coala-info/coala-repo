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
outputs:
  - id: exon_out
    type: File
    doc: Exon regions BED output file
    outputBinding:
      glob: $(inputs.exon_out)
  - id: intron_out
    type: File
    doc: Intron regions BED output file
    outputBinding:
      glob: $(inputs.intron_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
