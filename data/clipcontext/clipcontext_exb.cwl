cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext exb
label: clipcontext_exb
doc: "CLIP peak regions near exon borders output BED file\n\nTool homepage: https://github.com/BackofenLab/CLIPcontext"
inputs:
  - id: gtf_file
    type: File
    doc: Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: in_file
    type: File
    doc: CLIP peak regions input BED file (6-column format)
    inputBinding:
      position: 101
      prefix: --in
  - id: max_dist
    type:
      - 'null'
      - int
    doc: "Maximum distance of CLIP peak region end to nearest exon end\n         \
      \         for CLIP region to still be output"
    inputBinding:
      position: 101
      prefix: --max-dist
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum input site length for filtering --in BED file
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum input site length for filtering --in BED file
    inputBinding:
      position: 101
      prefix: --min-len
  - id: rev_filter
    type:
      - 'null'
      - boolean
    doc: "Reverse filtering (keep values <= --thr and prefer sites\n             \
      \     with smaller values)"
    inputBinding:
      position: 101
      prefix: --rev-filter
  - id: thr
    type:
      - 'null'
      - float
    doc: Filter out --in BED regions < --thr column 5 score
    inputBinding:
      position: 101
      prefix: --thr
  - id: tr_file
    type: File
    doc: Transcript sequence IDs list file to define exon regions
    inputBinding:
      position: 101
      prefix: --tr
outputs:
  - id: out_file
    type: File
    doc: CLIP peak regions near exon borders output BED file
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
