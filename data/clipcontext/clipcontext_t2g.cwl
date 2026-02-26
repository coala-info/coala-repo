cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext_t2g
label: clipcontext_t2g
doc: "Processes transcript regions BED file with genomic annotations and sequences
  to extract context sequences and generate reports.\n\nTool homepage: https://github.com/BackofenLab/CLIPcontext"
inputs:
  - id: generate_unique_ids
    type:
      - 'null'
      - boolean
    doc: Generate unique column 4 IDs for --in BED file entries
    default: false
    inputBinding:
      position: 101
      prefix: --gen-uniq-ids
  - id: genomic_sequences_file
    type: File
    doc: Genomic sequences (hg38) .2bit file
    inputBinding:
      position: 101
      prefix: --gen
  - id: gtf_file
    type: File
    doc: Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_bed_file
    type: File
    doc: Transcript regions BED file (6-column format) (transcript IDs need to 
      be in --gtf)
    inputBinding:
      position: 101
      prefix: --in
  - id: max_input_site_length
    type:
      - 'null'
      - int
    doc: Maximum input site length for filtering --in BED file
    default: false
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_input_site_length
    type:
      - 'null'
      - int
    doc: Minimum input site length for filtering --in BED file
    default: false
    inputBinding:
      position: 101
      prefix: --min-len
  - id: output_folder
    type: Directory
    doc: Output results folder
    inputBinding:
      position: 101
      prefix: --out
  - id: output_report
    type:
      - 'null'
      - boolean
    doc: Output an .html report with statistics and plots comparing transcript 
      and genomic sequences
    default: false
    inputBinding:
      position: 101
      prefix: --report
  - id: reverse_filter
    type:
      - 'null'
      - boolean
    doc: Reverse filtering (keep values <= threshold and prefer sites with 
      smaller values)
    default: false
    inputBinding:
      position: 101
      prefix: --rev-filter
  - id: sequence_extension
    type:
      - 'null'
      - int
    doc: Up- and downstream extension of centered sites for context sequence 
      extraction
    default: 30
    inputBinding:
      position: 101
      prefix: --seq-ext
  - id: site_score_threshold
    type:
      - 'null'
      - float
    doc: Site score threshold for filtering --in BED file
    default: None
    inputBinding:
      position: 101
      prefix: --thr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
stdout: clipcontext_t2g.out
