cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - align
label: paladin_align
doc: "Protein alignment tool for functional profiling of metagenomes\n\nTool homepage:
  https://github.com/ToniWestbrook/paladin"
inputs:
  - id: idxbase
    type: string
    doc: Index base name
    inputBinding:
      position: 1
  - id: input_reads
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 2
  - id: append_comment
    type:
      - 'null'
      - boolean
    doc: append FASTA/FASTQ comment to SAM output
    inputBinding:
      position: 103
      prefix: -C
  - id: clipping_penalty
    type:
      - 'null'
      - string
    doc: penalty for 5'- and 3'-end clipping
    default: 0,0
    inputBinding:
      position: 103
      prefix: -L
  - id: disable_brute_force
    type:
      - 'null'
      - boolean
    doc: disable brute force detection
    inputBinding:
      position: 103
      prefix: -b
  - id: disable_orf_detection_protein
    type:
      - 'null'
      - boolean
    doc: disable ORF detection and treat input as protein sequence
    inputBinding:
      position: 103
      prefix: -p
  - id: disable_orf_detection_transcript
    type:
      - 'null'
      - boolean
    doc: disable ORF detection and treat input as transcript sequence
    inputBinding:
      position: 103
      prefix: -q
  - id: discard_chain_seeded_bases
    type:
      - 'null'
      - int
    doc: discard a chain if seeded bases shorter than INT
    default: 0
    inputBinding:
      position: 103
      prefix: -W
  - id: discard_exact_matches
    type:
      - 'null'
      - boolean
    doc: discard full-length exact matches
    inputBinding:
      position: 103
      prefix: -e
  - id: drop_chain_fraction
    type:
      - 'null'
      - float
    doc: drop chains shorter than FLOAT fraction of the longest overlapping chain
    default: 0.5
    inputBinding:
      position: 103
      prefix: -D
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: gap extension penalty; a gap of size k cost '{-O} + {-E}*k'
    default: 1,1
    inputBinding:
      position: 103
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: gap open penalties for deletions and insertions
    default: 0,0
    inputBinding:
      position: 103
      prefix: -O
  - id: generate_orf_fasta
    type:
      - 'null'
      - boolean
    doc: generate detected ORF nucleotide sequence FASTA
    inputBinding:
      position: 103
      prefix: -g
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: Genetic code used for translation (-z ? for full list)
    default: '1'
    inputBinding:
      position: 103
      prefix: -z
  - id: header_insert
    type:
      - 'null'
      - string
    doc: insert STR to header if it starts with @; or insert lines in FILE
    inputBinding:
      position: 103
      prefix: -H
  - id: ignore_alt_file
    type:
      - 'null'
      - boolean
    doc: treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt
      file)
    inputBinding:
      position: 103
      prefix: -j
  - id: insert_size_distribution
    type:
      - 'null'
      - string
    doc: specify the mean, standard deviation, max and min of the insert size distribution
    inputBinding:
      position: 103
      prefix: -I
  - id: internal_seed_ratio
    type:
      - 'null'
      - float
    doc: look for internal seeds inside a seed longer than {-k} * FLOAT
    default: 1.5
    inputBinding:
      position: 103
      prefix: -r
  - id: keep_protein_sequence
    type:
      - 'null'
      - boolean
    doc: keep protein sequence after alignment
    inputBinding:
      position: 103
      prefix: -n
  - id: mark_split_hits_secondary
    type:
      - 'null'
      - boolean
    doc: mark shorter split hits as secondary
    inputBinding:
      position: 103
      prefix: -M
  - id: match_score
    type:
      - 'null'
      - int
    doc: score for a sequence match, which scales options -TdBOELU unless overridden
    default: 1
    inputBinding:
      position: 103
      prefix: -A
  - id: mate_rescues
    type:
      - 'null'
      - int
    doc: perform at most INT rounds of mate rescues for each read
    default: 50
    inputBinding:
      position: 103
      prefix: -m
  - id: min_orf_length_constant
    type:
      - 'null'
      - int
    doc: minimum ORF length accepted (as constant value)
    default: 250
    inputBinding:
      position: 103
      prefix: -f
  - id: min_orf_length_percentage
    type:
      - 'null'
      - float
    doc: minimum ORF length accepted (as percentage of read length)
    default: 0.0
    inputBinding:
      position: 103
      prefix: -F
  - id: min_output_score
    type:
      - 'null'
      - int
    doc: minimum score to output
    default: 15
    inputBinding:
      position: 103
      prefix: -T
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: minimum seed length
    default: 11
    inputBinding:
      position: 103
      prefix: -k
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: penalty for a mismatch
    default: 3
    inputBinding:
      position: 103
      prefix: -B
  - id: no_adjust_orf_length
    type:
      - 'null'
      - boolean
    doc: do not adjust minimum ORF length (constant value) for shorter read lengths
    inputBinding:
      position: 103
      prefix: -J
  - id: off_diagonal_dropoff
    type:
      - 'null'
      - int
    doc: off-diagonal X-dropoff
    default: 100
    inputBinding:
      position: 103
      prefix: -d
  - id: output_all_alignments
    type:
      - 'null'
      - boolean
    doc: output all alignments for SE or unpaired PE
    inputBinding:
      position: 103
      prefix: -a
  - id: output_ref_header_xr
    type:
      - 'null'
      - boolean
    doc: output the reference FASTA header in the XR tag
    inputBinding:
      position: 103
      prefix: -V
  - id: proxy
    type:
      - 'null'
      - string
    doc: HTTP or SOCKS proxy address
    inputBinding:
      position: 103
      prefix: -P
  - id: read_group_header
    type:
      - 'null'
      - string
    doc: read group header line such as '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 103
      prefix: -R
  - id: read_type
    type:
      - 'null'
      - string
    doc: read type (pacbio, ont2d, or intractg). Setting -x changes multiple parameters
      unless overriden
    inputBinding:
      position: 103
      prefix: -x
  - id: report_type
    type:
      - 'null'
      - int
    doc: 'report type generated when using reporting and a UniProt reference (0: Simple,
      1: Detailed)'
    default: 1
    inputBinding:
      position: 103
      prefix: -u
  - id: seed_occurrence_3rd_round
    type:
      - 'null'
      - int
    doc: seed occurrence for the 3rd round seeding
    default: 20
    inputBinding:
      position: 103
      prefix: -y
  - id: skip_seed_occurrence
    type:
      - 'null'
      - int
    doc: skip seeds with more than INT occurrences
    default: 500
    inputBinding:
      position: 103
      prefix: -c
  - id: soft_clipping_supplementary
    type:
      - 'null'
      - boolean
    doc: use soft clipping for supplementary alignments
    inputBinding:
      position: 103
      prefix: -Y
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -t
  - id: unpaired_penalty
    type:
      - 'null'
      - int
    doc: penalty for an unpaired read pair
    default: 17
    inputBinding:
      position: 103
      prefix: -U
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging'
    default: 3
    inputBinding:
      position: 103
      prefix: -v
  - id: xa_output_control
    type:
      - 'null'
      - string
    doc: if there are <INT hits with score >80% of the max score, output all in XA
    default: 5,200
    inputBinding:
      position: 103
      prefix: -h
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: activate PALADIN reporting using STR as an output file prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
