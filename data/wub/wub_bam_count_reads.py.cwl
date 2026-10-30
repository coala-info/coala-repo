cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_count_reads.py
label: wub_bam_count_reads.py
doc: 'Count reads mapping to each reference in a BAM file.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam
    type: File
    doc: 'Input file (default: stdin).'
    inputBinding:
      position: 1
  - id: min_aqual
    type:
      - 'null'
      - int
    doc: Minimum mapping quality (0).
    inputBinding:
      position: 102
      prefix: -a
  - id: in_format
    type:
      - 'null'
      - string
    doc: Input format (BAM).
    inputBinding:
      position: 102
      prefix: -f
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference fasta. GC content and length columns are added if present (None).
    inputBinding:
      position: 102
      prefix: -z
  - id: words
    type:
      - 'null'
      - int
    doc: Include word frequencies of specifed length in output (None).
    inputBinding:
      position: 102
      prefix: -k
  - id: include_gc
    type:
      - 'null'
      - boolean
    doc: Include mean GC content of reads mapped to each reference (False).
    inputBinding:
      position: 102
      prefix: -g
  - id: results_pickle
    type:
      - 'null'
      - string
    doc: Save pickled results in this file (None).
    inputBinding:
      position: 102
      prefix: -p
  - id: tsv_file
    type:
      - 'null'
      - string
    doc: Save results in tsv format in this file (bam_count_reads.tsv).
    default: bam_count_reads.tsv
    inputBinding:
      position: 102
      prefix: -t
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not print progress bar (False).
    inputBinding:
      position: 102
      prefix: -Q
  - id: online_counting
    type:
      - 'null'
      - boolean
    doc: Count reads from SAM stream in stdin. Only read count fields are written.
      Header required! (False).
    inputBinding:
      position: 102
      prefix: -R
  - id: yield_freq
    type:
      - 'null'
      - int
    doc: Yield counts after every -Fth mapped record when doing online counting (100).
    inputBinding:
      position: 102
      prefix: -F
outputs:
  - id: counts_tsv
    type: File
    doc: Tab separated read counts per reference.
    outputBinding:
      glob: $(inputs.tsv_file)
  - id: pickle
    type:
      - 'null'
      - File
    doc: Pickled results.
    outputBinding:
      glob: $(inputs.results_pickle)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
