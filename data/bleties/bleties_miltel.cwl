cwlVersion: v1.2
class: CommandLineTool
baseCommand: bleties miltel
label: bleties_miltel
doc: "MILTEL - Method of Long-read Telomere detection\n\nTool homepage: https://github.com/Swart-lab/bleties"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file containing mapping, must be sorted and indexed
    default: None
    inputBinding:
      position: 101
      prefix: --bam
  - id: contig
    type:
      - 'null'
      - string
    doc: Only process alignments from this contig
    default: None
    inputBinding:
      position: 101
      prefix: --contig
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Dump internal data for troubleshooting
    default: false
    inputBinding:
      position: 101
      prefix: --dump
  - id: min_clip_length
    type:
      - 'null'
      - int
    doc: Minimum length of other clipped sequences (non-telomeric) to count
    default: 50
    inputBinding:
      position: 101
      prefix: --min_clip_length
  - id: min_telomere_length
    type:
      - 'null'
      - int
    doc: Minimum length of telomere to call
    default: 24
    inputBinding:
      position: 101
      prefix: --min_telomere_length
  - id: other_clips
    type:
      - 'null'
      - boolean
    doc: Count other clipped sequences (non-telomeric) and get consensus of 
      clipped segments
    default: false
    inputBinding:
      position: 101
      prefix: --other_clips
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output filename prefix
    default: miltel.test
    inputBinding:
      position: 101
      prefix: --out
  - id: ref_file
    type:
      - 'null'
      - File
    doc: FASTA file containing genomic contigs used as reference for the mapping
    default: None
    inputBinding:
      position: 101
      prefix: --ref
  - id: start
    type:
      - 'null'
      - int
    doc: Start coordinate (1-based, inclusive) from contig to process
    default: None
    inputBinding:
      position: 101
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: Stop coordinate (1-based, inclusive) from contig to process
    default: None
    inputBinding:
      position: 101
      prefix: --stop
  - id: telomere
    type:
      - 'null'
      - string
    doc: Telomere sequence to search for
    default: ACACCCTA
    inputBinding:
      position: 101
      prefix: --telomere
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
stdout: bleties_miltel.out
