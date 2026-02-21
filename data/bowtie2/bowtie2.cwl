cwlVersion: v1.2
class: CommandLineTool
baseCommand: bowtie2
label: bowtie2
doc: "An ultrafast and memory-efficient tool for aligning sequencing reads to long
  reference sequences.\n\nTool homepage: https://bowtie-bio.sourceforge.net/bowtie2/index.shtml"
inputs:
  - id: bam_input
    type:
      - 'null'
      - File
    doc: Files are unaligned BAM sorted by read name
    inputBinding:
      position: 101
      prefix: -b
  - id: end_to_end
    type:
      - 'null'
      - boolean
    doc: entire read must align; no clipping (on)
    inputBinding:
      position: 101
      prefix: --end-to-end
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: query input files are (multi-)FASTA .fa/.mfa
    inputBinding:
      position: 101
      prefix: -f
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: query input files are FASTQ .fq/.fastq (default)
    inputBinding:
      position: 101
      prefix: -q
  - id: index_prefix
    type: string
    doc: Index filename prefix (minus trailing .X.bt2)
    inputBinding:
      position: 101
      prefix: -x
  - id: interleaved
    type:
      - 'null'
      - File
    doc: Files with interleaved paired-end FASTQ/FASTA reads
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: local
    type:
      - 'null'
      - boolean
    doc: local alignment; ends might be soft clipped (off)
    inputBinding:
      position: 101
      prefix: --local
  - id: mates_1
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files with #1 mates, paired with files in <m2>'
    inputBinding:
      position: 101
      prefix: '-1'
  - id: mates_2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files with #2 mates, paired with files in <m1>'
    inputBinding:
      position: 101
      prefix: '-2'
  - id: max_ins
    type:
      - 'null'
      - int
    doc: maximum fragment length
    default: 500
    inputBinding:
      position: 101
      prefix: --maxins
  - id: min_ins
    type:
      - 'null'
      - int
    doc: minimum fragment length
    default: 0
    inputBinding:
      position: 101
      prefix: --minins
  - id: no_discordant
    type:
      - 'null'
      - boolean
    doc: suppress discordant alignments for paired reads
    inputBinding:
      position: 101
      prefix: --no-discordant
  - id: no_mixed
    type:
      - 'null'
      - boolean
    doc: suppress unpaired alignments for paired reads
    inputBinding:
      position: 101
      prefix: --no-mixed
  - id: no_unal
    type:
      - 'null'
      - boolean
    doc: suppress SAM records for unaligned reads
    inputBinding:
      position: 101
      prefix: --no-unal
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+33 (default)
    inputBinding:
      position: 101
      prefix: --phred33
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+64
    inputBinding:
      position: 101
      prefix: --phred64
  - id: qseq_input
    type:
      - 'null'
      - boolean
    doc: query input files are in Illumina's qseq format
    inputBinding:
      position: 101
      prefix: --qseq
  - id: raw_input
    type:
      - 'null'
      - boolean
    doc: query input files are raw one-sequence-per-line
    inputBinding:
      position: 101
      prefix: -r
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: force SAM output order to match order of input reads
    inputBinding:
      position: 101
      prefix: --reorder
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: report all alignments; very slow, MAPQ not meaningful
    inputBinding:
      position: 101
      prefix: --all
  - id: rg_id
    type:
      - 'null'
      - string
    doc: 'set read group id, reflected in @RG line and RG:Z: opt field'
    inputBinding:
      position: 101
      prefix: --rg-id
  - id: seed_length
    type:
      - 'null'
      - int
    doc: length of seed substrings; must be >3, <32
    default: 22
    inputBinding:
      position: 101
      prefix: -L
  - id: seed_mismatches
    type:
      - 'null'
      - int
    doc: 'max # mismatches in seed alignment; can be 0 or 1'
    default: 0
    inputBinding:
      position: 101
      prefix: -N
  - id: sequences_as_args
    type:
      - 'null'
      - boolean
    doc: <m1>, <m2>, <r> are sequences themselves, not files
    inputBinding:
      position: 101
      prefix: -c
  - id: skip
    type:
      - 'null'
      - int
    doc: skip the first <int> reads/pairs in the input
    inputBinding:
      position: 101
      prefix: --skip
  - id: tab5_input
    type:
      - 'null'
      - boolean
    doc: query input files are TAB5 .tab5
    inputBinding:
      position: 101
      prefix: --tab5
  - id: tab6_input
    type:
      - 'null'
      - boolean
    doc: query input files are TAB6 .tab6
    inputBinding:
      position: 101
      prefix: --tab6
  - id: threads
    type:
      - 'null'
      - int
    doc: number of alignment threads to launch
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim3
    type:
      - 'null'
      - int
    doc: trim <int> bases from 3'/right end of reads
    default: 0
    inputBinding:
      position: 101
      prefix: --trim3
  - id: trim5
    type:
      - 'null'
      - int
    doc: trim <int> bases from 5'/left end of reads
    default: 0
    inputBinding:
      position: 101
      prefix: --trim5
  - id: unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Files with unpaired reads
    inputBinding:
      position: 101
      prefix: -U
  - id: upto
    type:
      - 'null'
      - int
    doc: stop after first <int> reads/pairs
    inputBinding:
      position: 101
      prefix: --upto
  - id: very_fast
    type:
      - 'null'
      - boolean
    doc: 'Preset for end-to-end: -D 5 -R 1 -N 0 -L 22 -i S,0,2.50'
    inputBinding:
      position: 101
      prefix: --very-fast
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: 'Preset for end-to-end: -D 20 -R 3 -N 0 -L 20 -i S,1,0.50'
    inputBinding:
      position: 101
      prefix: --very-sensitive
outputs:
  - id: sam_output
    type:
      - 'null'
      - File
    doc: 'File for SAM output (default: stdout)'
    outputBinding:
      glob: $(inputs.sam_output)
  - id: unaligned_unpaired_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path>
    outputBinding:
      glob: $(inputs.unaligned_unpaired_output)
  - id: aligned_unpaired_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path>
    outputBinding:
      glob: $(inputs.aligned_unpaired_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bowtie2:2.5.4--he96a11b_7
