cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext g2t
label: clipcontext_g2t
doc: "Map genomic regions to transcripts and extract context sequences.\n\nTool homepage:
  https://github.com/BackofenLab/CLIPcontext"
inputs:
  - id: add_output
    type:
      - 'null'
      - boolean
    doc: Output centered and extended sites and sequences for all transcript 
      matches (unique + non-unique)
    inputBinding:
      position: 101
      prefix: --add-out
  - id: all_genomic_output
    type:
      - 'null'
      - boolean
    doc: Output all centered and extended genomic regions, instead of only the 
      ones with unique transcript matches
    inputBinding:
      position: 101
      prefix: --all-gen-out
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Output an .html report with statistics and plots comparing transcript 
      and genomic sequences
    inputBinding:
      position: 101
      prefix: --report
  - id: generate_unique_ids
    type:
      - 'null'
      - boolean
    doc: Generate unique column 4 IDs for --in BED file entries
    inputBinding:
      position: 101
      prefix: --gen-uniq-ids
  - id: genomic_sequences
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
  - id: input_bed
    type: File
    doc: Genomic regions (hg38) BED file (6-column format)
    inputBinding:
      position: 101
      prefix: --in
  - id: max_input_len
    type:
      - 'null'
      - int
    doc: Maximum input site length for filtering --in BED file
    inputBinding:
      position: 101
      prefix: --max-len
  - id: merge_extension
    type:
      - 'null'
      - int
    doc: Extend regions mapped to transcripts by --merge-ext before running 
      mergeBed to merge overlapping regions
    inputBinding:
      position: 101
      prefix: --merge-ext
  - id: merge_mode
    type:
      - 'null'
      - int
    doc: Defines how to merge overlapping transcript sites (overlap controlled 
      by --merge-ext). (1) only merge sites overlapping at exon borders, (2) 
      merge all overlapping sites, (3) do NOT merge overlapping sites
    inputBinding:
      position: 101
      prefix: --merge-mode
  - id: min_exon_overlap
    type:
      - 'null'
      - float
    doc: Minimum exon overlap of a site to be reported as transcript hit 
      (intersectBed -f parameter)
    inputBinding:
      position: 101
      prefix: --min-exon-ol
  - id: min_input_len
    type:
      - 'null'
      - int
    doc: Minimum input site length for filtering --in BED file
    inputBinding:
      position: 101
      prefix: --min-len
  - id: reverse_filter
    type:
      - 'null'
      - boolean
    doc: Reverse filtering (keep values <= threshold and prefer sites with 
      smaller values)
    inputBinding:
      position: 101
      prefix: --rev-filter
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: Site score threshold for filtering --in BED file
    inputBinding:
      position: 101
      prefix: --thr
  - id: sequence_extension
    type:
      - 'null'
      - int
    doc: Up- and downstream extension of centered sites for context sequence 
      extraction
    inputBinding:
      position: 101
      prefix: --seq-ext
  - id: transcript_ids
    type: File
    doc: Transcript sequence IDs list file to define transcripts to map on
    inputBinding:
      position: 101
      prefix: --tr
outputs:
  - id: output_folder
    type: Directory
    doc: Output results folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
