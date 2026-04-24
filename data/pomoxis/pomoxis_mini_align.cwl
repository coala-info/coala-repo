cwlVersion: v1.2
class: CommandLineTool
baseCommand: mini_align
label: pomoxis_mini_align
doc: "Align fastq/a or bam formatted reads to a genome using minimap2.\n\nTool homepage:
  https://github.com/nanoporetech/pomoxis"
inputs:
  - id: aggressively_extend_gaps
    type:
      - 'null'
      - boolean
    doc: aggressively extend gaps (sets -A1 -B2 -O2 -E1 for minimap2).
    inputBinding:
      position: 101
      prefix: -a
  - id: alignment_threads
    type:
      - 'null'
      - int
    doc: 'alignment threads (default: 1).'
    inputBinding:
      position: 101
      prefix: -t
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: "chunk size. Input reads/contigs will be broken into chunks\nprior to alignment."
    inputBinding:
      position: 101
      prefix: -c
  - id: copy_comments
    type:
      - 'null'
      - boolean
    doc: copy comments from fastx info lines to bam tags.
    inputBinding:
      position: 101
      prefix: -C
  - id: extend_gap_penalty
    type:
      - 'null'
      - string
    doc: extend gap penalty.
    inputBinding:
      position: 101
      prefix: -E
  - id: fill_cs_tag
    type:
      - 'null'
      - boolean
    doc: fill cs(=long) tag.
    inputBinding:
      position: 101
      prefix: -s
  - id: fill_md_tag
    type:
      - 'null'
      - boolean
    doc: fill MD tag.
    inputBinding:
      position: 101
      prefix: -m
  - id: filter_primary_alignments
    type:
      - 'null'
      - boolean
    doc: "filter to only primary alignments (i.e. run samtools view -F 2308).\n  \
      \      Deprecated: this filter is now default and can be disabled with -A."
    inputBinding:
      position: 101
      prefix: -P
  - id: filter_primary_and_supplementary
    type:
      - 'null'
      - boolean
    doc: filter to primary and supplementary alignments (i.e. run samtools view 
      -F 260)
    inputBinding:
      position: 101
      prefix: -y
  - id: force_recreate_index
    type:
      - 'null'
      - boolean
    doc: force recreation of index file.
    inputBinding:
      position: 101
      prefix: -f
  - id: input_reads
    type: File
    doc: fastq/a or bam input reads
    inputBinding:
      position: 101
      prefix: -i
  - id: log_commands
    type:
      - 'null'
      - boolean
    doc: log all commands before running.
    inputBinding:
      position: 101
      prefix: -x
  - id: match_score
    type:
      - 'null'
      - string
    doc: match score.
    inputBinding:
      position: 101
      prefix: -M
  - id: minimap2_preset
    type:
      - 'null'
      - string
    doc: 'set the minimap2 preset, e.g. map-ont, asm5, asm10, asm20 [default: map-ont]'
    inputBinding:
      position: 101
      prefix: -d
  - id: mismatch_score
    type:
      - 'null'
      - string
    doc: mismatch score.
    inputBinding:
      position: 101
      prefix: -S
  - id: only_create_reference_index
    type:
      - 'null'
      - boolean
    doc: only create reference index files.
    inputBinding:
      position: 101
      prefix: -X
  - id: open_gap_penalty
    type:
      - 'null'
      - string
    doc: open gap penalty.
    inputBinding:
      position: 101
      prefix: -O
  - id: output_all_alignments
    type:
      - 'null'
      - boolean
    doc: do not filter alignments, output all.
    inputBinding:
      position: 101
      prefix: -A
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'output file prefix (default: reads).'
    inputBinding:
      position: 101
      prefix: -p
  - id: reference
    type: File
    doc: "reference, should be a fasta file. If correspondng minimap indices\ndo not
      exist they will be created."
    inputBinding:
      position: 101
      prefix: -r
  - id: retain_bam_tags
    type:
      - 'null'
      - string
    doc: "which input bam tags to retain if input is in bam format (implies -C, default:
      '*')."
    inputBinding:
      position: 101
      prefix: -T
  - id: sort_by_read_name
    type:
      - 'null'
      - boolean
    doc: sort bam by read name.
    inputBinding:
      position: 101
      prefix: -n
  - id: split_index
    type:
      - 'null'
      - string
    doc: "split index every ~NUM input bases (default: 16G, this is larger\nthan the
      usual minimap2 default)."
    inputBinding:
      position: 101
      prefix: -I
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_mini_align.out
