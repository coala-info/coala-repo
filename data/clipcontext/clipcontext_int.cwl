cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext_int
label: clipcontext_int
doc: "CLIP peak regions overlapping with introns output BED file\n\nTool homepage:
  https://github.com/BackofenLab/CLIPcontext"
inputs:
  - id: gtf_file
    type: File
    doc: Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_bed_file
    type: File
    doc: CLIP peak regions input BED file (6-column format)
    inputBinding:
      position: 101
      prefix: --in
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum input site length for filtering --in BED file
    default: 'False'
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_intron_overlap
    type:
      - 'null'
      - float
    doc: Minimum intron overlap of a site to be reported as intron overlapping 
      (intersectBed -f parameter)
    default: 0.9
    inputBinding:
      position: 101
      prefix: --min-intron-ol
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum input site length for filtering --in BED file
    default: 'False'
    inputBinding:
      position: 101
      prefix: --min-len
  - id: reverse_filter
    type:
      - 'null'
      - boolean
    doc: Reverse filtering (keep values <= --thr and prefer sites with smaller 
      values)
    default: false
    inputBinding:
      position: 101
      prefix: --rev-filter
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: Filter out --in BED regions < --thr column 5 score
    default: no filtering
    inputBinding:
      position: 101
      prefix: --thr
  - id: transcript_ids_file
    type: File
    doc: Transcript sequence IDs list file to define intron regions
    inputBinding:
      position: 101
      prefix: --tr
outputs:
  - id: output_bed_file
    type: File
    doc: CLIP peak regions overlapping with introns output BED file
    outputBinding:
      glob: $(inputs.output_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
