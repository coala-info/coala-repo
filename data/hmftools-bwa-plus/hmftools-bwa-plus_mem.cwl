cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-plus
  - mem
label: hmftools-bwa-plus_mem
doc: "Align single-end or paired-end reads to a reference with bwa-plus (an
  optimised bwa-mem2).\n\nTool homepage: https://github.com/hartwigmedical/bwa-plus"
inputs:
  - id: idxbase
    type: string
    doc: Index prefix of the reference (the name of the FASTA file that was indexed)
    inputBinding:
      position: 2
  - id: index_files
    type:
      type: array
      items: File
    doc: bwa-plus index files, staged in the working directory so that idxbase resolves
  - id: reads_1
    type: File
    doc: Reads (FASTQ, optionally gzipped); first mate for paired-end reads
    inputBinding:
      position: 3
  - id: reads_2
    type:
      - 'null'
      - File
    doc: Second mate reads (FASTQ, optionally gzipped)
    inputBinding:
      position: 4
  - id: output_sam
    type: string
    doc: Output SAM file name
    inputBinding:
      position: 1
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads [1]'
    inputBinding:
      position: 1
      prefix: -t
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: 'Minimum seed length [19]'
    inputBinding:
      position: 1
      prefix: -k
  - id: band_width
    type:
      - 'null'
      - int
    doc: 'Band width for banded alignment [100]'
    inputBinding:
      position: 1
      prefix: -w
  - id: off_diagonal_xdropoff
    type:
      - 'null'
      - int
    doc: 'Off-diagonal X-dropoff [100]'
    inputBinding:
      position: 1
      prefix: -d
  - id: internal_seed_ratio
    type:
      - 'null'
      - float
    doc: 'Look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]'
    inputBinding:
      position: 1
      prefix: -r
  - id: seed_occurrence_3rd
    type:
      - 'null'
      - int
    doc: 'Seed occurrence for the 3rd round seeding [20]'
    inputBinding:
      position: 1
      prefix: -y
  - id: skip_seed_occurrence
    type:
      - 'null'
      - int
    doc: 'Skip seeds with more than INT occurrences [500]'
    inputBinding:
      position: 1
      prefix: -c
  - id: drop_chain_fraction
    type:
      - 'null'
      - float
    doc: 'Drop chains shorter than FLOAT fraction of the longest overlapping chain [0.50]'
    inputBinding:
      position: 1
      prefix: -D
  - id: discard_chain_bases
    type:
      - 'null'
      - int
    doc: 'Discard a chain if seeded bases shorter than INT [0]'
    inputBinding:
      position: 1
      prefix: -W
  - id: mate_rescue_rounds
    type:
      - 'null'
      - int
    doc: 'Perform at most INT rounds of mate rescues for each read [50]'
    inputBinding:
      position: 1
      prefix: -m
  - id: skip_mate_rescue
    type:
      - 'null'
      - boolean
    doc: 'Skip mate rescue'
    inputBinding:
      position: 1
      prefix: -S
  - id: skip_pairing
    type:
      - 'null'
      - boolean
    doc: 'Skip pairing; mate rescue performed unless -S also in use'
    inputBinding:
      position: 1
      prefix: -P
  - id: match_score
    type:
      - 'null'
      - int
    doc: 'Score for a sequence match, which scales options -TdBOELU unless overridden [1]'
    inputBinding:
      position: 1
      prefix: -A
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: 'Penalty for a mismatch [4]'
    inputBinding:
      position: 1
      prefix: -B
  - id: gap_open_penalties
    type:
      - 'null'
      - string
    doc: 'Gap open penalties for deletions and insertions, INT[,INT] [6,6]'
    inputBinding:
      position: 1
      prefix: -O
  - id: gap_extension_penalties
    type:
      - 'null'
      - string
    doc: 'Gap extension penalty; a gap of size k cost ''{-O} + {-E}*k'', INT[,INT] [1,1]'
    inputBinding:
      position: 1
      prefix: -E
  - id: clipping_penalties
    type:
      - 'null'
      - string
    doc: 'Penalty for 5''- and 3''-end clipping, INT[,INT] [5,5]'
    inputBinding:
      position: 1
      prefix: -L
  - id: unpaired_penalty
    type:
      - 'null'
      - int
    doc: 'Penalty for an unpaired read pair [17]'
    inputBinding:
      position: 1
      prefix: -U
  - id: smart_pairing
    type:
      - 'null'
      - boolean
    doc: 'Smart pairing (ignoring in2.fq)'
    inputBinding:
      position: 1
      prefix: -p
  - id: read_group
    type:
      - 'null'
      - string
    doc: 'Read group header line such as ''@RG\\tID:foo\\tSM:bar'''
    inputBinding:
      position: 1
      prefix: -R
  - id: header_insert
    type:
      - 'null'
      - string
    doc: 'Insert STR to header if it starts with @; or insert lines in FILE'
    inputBinding:
      position: 1
      prefix: -H
  - id: alt_as_primary
    type:
      - 'null'
      - boolean
    doc: 'Treat ALT contigs as part of the primary assembly (ignore <idxbase>.alt file)'
    inputBinding:
      position: 1
      prefix: -j
  - id: smallest_coordinate_primary
    type:
      - 'null'
      - boolean
    doc: 'For split alignment, take the alignment with the smallest coordinate as primary'
    inputBinding:
      position: 1
      prefix: '-5'
  - id: keep_supplementary_mapq
    type:
      - 'null'
      - boolean
    doc: 'Don''t modify mapQ of supplementary alignments'
    inputBinding:
      position: 1
      prefix: -q
  - id: batch_bases
    type:
      - 'null'
      - int
    doc: 'Process INT input bases in each batch regardless of nThreads (for reproducibility)'
    inputBinding:
      position: 1
      prefix: -K
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
    inputBinding:
      position: 1
      prefix: -v
  - id: min_score
    type:
      - 'null'
      - int
    doc: 'Minimum score to output [30]'
    inputBinding:
      position: 1
      prefix: -T
  - id: xa_hits
    type:
      - 'null'
      - string
    doc: 'If there are <INT hits with score >80% of the max score, output all in XA, INT[,INT] [5,200]'
    inputBinding:
      position: 1
      prefix: -h
  - id: output_all
    type:
      - 'null'
      - boolean
    doc: 'Output all alignments for SE or unpaired PE'
    inputBinding:
      position: 1
      prefix: -a
  - id: append_comment
    type:
      - 'null'
      - boolean
    doc: 'Append FASTA/FASTQ comment to SAM output'
    inputBinding:
      position: 1
      prefix: -C
  - id: reference_header_tag
    type:
      - 'null'
      - boolean
    doc: 'Output the reference FASTA header in the XR tag'
    inputBinding:
      position: 1
      prefix: -V
  - id: soft_clip_supplementary
    type:
      - 'null'
      - boolean
    doc: 'Use soft clipping for supplementary alignments'
    inputBinding:
      position: 1
      prefix: -Y
  - id: mark_shorter_secondary
    type:
      - 'null'
      - boolean
    doc: 'Mark shorter split hits as secondary'
    inputBinding:
      position: 1
      prefix: -M
  - id: insert_size
    type:
      - 'null'
      - string
    doc: 'Mean, standard deviation, max and min of the insert size distribution, FLOAT[,FLOAT[,INT[,INT]]] (FR orientation only) [inferred]'
    inputBinding:
      position: 1
      prefix: -I
outputs:
  - id: sam
    type: File
    doc: Alignments in SAM format
    outputBinding:
      glob: $(inputs.output_sam)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0
stdout: hmftools-bwa-plus_mem.out
