cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vg
  - map
label: vg_map
doc: "Align reads to a graph.\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: input1
    type: File
    doc: First input FASTQ file
    inputBinding:
      position: 1
  - id: input2
    type:
      - 'null'
      - File
    doc: Second input FASTQ file for paired-end reads
    inputBinding:
      position: 2
  - id: alignment_model
    type:
      - 'null'
      - string
    doc: use a preset alignment scoring model, either "short" (default) or 
      "long" (ONT/PacBio) "long" is equivalent to -u 2 -L 63 -q 1 -z 2 -o 2 -y 1
      -w 128 -O 32
    default: short
    inputBinding:
      position: 103
      prefix: --alignment-model
  - id: approx_mq_cap
    type:
      - 'null'
      - int
    doc: weight MQ by suffix tree based estimate when estimate less than FLOAT
    default: 0
    inputBinding:
      position: 103
      prefix: --approx-mq-cap
  - id: band_jump
    type:
      - 'null'
      - int
    doc: the maximum number of bands of insertion we consider in the alignment 
      chain model
    default: 128
    inputBinding:
      position: 103
      prefix: --band-jump
  - id: band_min_mq
    type:
      - 'null'
      - int
    doc: treat bands with < INT MQ as unaligned
    default: 0
    inputBinding:
      position: 103
      prefix: --band-min-mq
  - id: band_multi
    type:
      - 'null'
      - int
    doc: consider this many alignments of each band in banded alignment
    default: 16
    inputBinding:
      position: 103
      prefix: --band-multi
  - id: band_overlap
    type:
      - 'null'
      - int
    doc: band overlap for long read alignment
    default: '{-w}/8'
    inputBinding:
      position: 103
      prefix: --band-overlap
  - id: band_width
    type:
      - 'null'
      - int
    doc: band width for long read alignment
    default: 256
    inputBinding:
      position: 103
      prefix: --band-width
  - id: base_name
    type:
      - 'null'
      - string
    doc: use indexes BASE.xg, BASE.gcsa, and BASE.gbwt (overrides all other 
      inputs)
    inputBinding:
      position: 103
      prefix: --base-name
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: buffer this many alignments together before outputting in GAM
    default: 512
    inputBinding:
      position: 103
      prefix: --buffer-size
  - id: comments_as_tags
    type:
      - 'null'
      - boolean
    doc: intepret comments in name lines as SAM-style tags and annotate 
      alignments with them
    inputBinding:
      position: 103
      prefix: --comments-as-tags
  - id: compare
    type:
      - 'null'
      - boolean
    doc: realign -G GAM input, writing alignment with "correct" field set to 
      overlap with input
    inputBinding:
      position: 103
      prefix: --compare
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debugging information to stderr
    inputBinding:
      position: 103
      prefix: --debug
  - id: drop_chain
    type:
      - 'null'
      - float
    doc: drop chains shorter than FLOAT fraction of the longest overlapping 
      chain
    default: 0.45
    inputBinding:
      position: 103
      prefix: --drop-chain
  - id: drop_full_l_bonus
    type:
      - 'null'
      - boolean
    doc: remove the full length bonus from the score before sorting and MQ 
      calculation
    inputBinding:
      position: 103
      prefix: --drop-full-l-bonus
  - id: exclude_unaligned
    type:
      - 'null'
      - boolean
    doc: exclude reads with no alignment
    inputBinding:
      position: 103
      prefix: --exclude-unaligned
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: align the sequences in a FASTA file that may have multiple lines per 
      reference sequence
    inputBinding:
      position: 103
      prefix: --fasta
  - id: fastq_file
    type:
      - 'null'
      - type: array
        items: File
    doc: input FASTQ or (2-line format) FASTA, maybe compressed; two allowed, 
      one for each mate
    inputBinding:
      position: 103
      prefix: --fastq
  - id: fixed_frag_model
    type:
      - 'null'
      - boolean
    doc: don't learn the pair fragment model online, use -I without update
    inputBinding:
      position: 103
      prefix: --fixed-frag-model
  - id: frag_calc
    type:
      - 'null'
      - int
    doc: update the fragment model every INT perfect pairs
    inputBinding:
      position: 103
      prefix: --frag-calc
  - id: fragment
    type:
      - 'null'
      - string
    doc: fragment length distribution specification STR=m:μ:σ:o:d 
      max:mean:stdev:orientation (1=same/0=flip):direction (1=forward, 
      0=backward)
    default: 5000:0:0:0:1
    inputBinding:
      position: 103
      prefix: --fragment
  - id: fragment_x
    type:
      - 'null'
      - float
    doc: calculate max fragment size as frag_mean+frag_sd*FLOAT
    inputBinding:
      position: 103
      prefix: --fragment-x
  - id: full_l_bonus
    type:
      - 'null'
      - int
    doc: the full-length alignment bonus
    default: 5
    inputBinding:
      position: 103
      prefix: --full-l-bonus
  - id: gaf
    type:
      - 'null'
      - boolean
    doc: output alignments in GAF format
    inputBinding:
      position: 103
      prefix: --gaf
  - id: gam_input
    type:
      - 'null'
      - File
    doc: realign GAM input
    inputBinding:
      position: 103
      prefix: --gam-input
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: use this gap extension penalty
    default: 1
    inputBinding:
      position: 103
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: use this gap open penalty
    default: 6
    inputBinding:
      position: 103
      prefix: --gap-open
  - id: gbwt_name
    type:
      - 'null'
      - File
    doc: use this GBWT haplotype index [<graph>.gbwt]
    inputBinding:
      position: 103
      prefix: --gbwt-name
  - id: gcsa_name
    type:
      - 'null'
      - File
    doc: use this GCSA2 index [<graph>.gcsa]
    inputBinding:
      position: 103
      prefix: --gcsa-name
  - id: hap_exp
    type:
      - 'null'
      - float
    doc: the exponent for haplotype consistency likelihood in alignment score
    default: 1
    inputBinding:
      position: 103
      prefix: --hap-exp
  - id: hit_max
    type:
      - 'null'
      - int
    doc: ignore MEMs who have >N hits in our index (0 for no limit)
    default: 2048
    inputBinding:
      position: 103
      prefix: --hit-max
  - id: hts_input
    type:
      - 'null'
      - File
    doc: align reads from stdin htslib-compatible FILE (BAM/CRAM/SAM), 
      alignments to stdout
    inputBinding:
      position: 103
      prefix: --hts-input
  - id: id_mq_weight
    type:
      - 'null'
      - int
    doc: scale mapping quality by the alignment score identity to this power
    inputBinding:
      position: 103
      prefix: --id-mq-weight
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: FASTQ or GAM is interleaved paired-ended
    inputBinding:
      position: 103
      prefix: --interleaved
  - id: keep_secondary
    type:
      - 'null'
      - boolean
    doc: produce alignments for secondary input alignments in addition to 
      primary ones
    inputBinding:
      position: 103
      prefix: --keep-secondary
  - id: log_time
    type:
      - 'null'
      - boolean
    doc: print runtime to stderr
    inputBinding:
      position: 103
      prefix: --log-time
  - id: match
    type:
      - 'null'
      - int
    doc: use this match score
    default: 1
    inputBinding:
      position: 103
      prefix: --match
  - id: mate_rescues
    type:
      - 'null'
      - int
    doc: attempt up to INT mate rescues per pair
    default: 64
    inputBinding:
      position: 103
      prefix: --mate-rescues
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: maximum gap length allowed in each contiguous alignment (for X-drop 
      alignment)
    default: 40
    inputBinding:
      position: 103
      prefix: --max-gap-length
  - id: max_mem
    type:
      - 'null'
      - int
    doc: ignore MEMs longer than INT (unset if 0)
    default: 0
    inputBinding:
      position: 103
      prefix: --max-mem
  - id: max_multimaps
    type:
      - 'null'
      - int
    doc: produce up to INT alignments per read
    default: 1
    inputBinding:
      position: 103
      prefix: --max-multimaps
  - id: max_target_x
    type:
      - 'null'
      - int
    doc: skip cluster subgraphs with length > N*read_length
    default: 100
    inputBinding:
      position: 103
      prefix: --max-target-x
  - id: mem_chance
    type:
      - 'null'
      - float
    doc: this fraction of -k length hits will be by chance
    default: '5e-4'
    inputBinding:
      position: 103
      prefix: --mem-chance
  - id: min_chain
    type:
      - 'null'
      - int
    doc: discard a chain if seeded bases are shorter than INT
    default: 0
    inputBinding:
      position: 103
      prefix: --min-chain
  - id: min_ident
    type:
      - 'null'
      - float
    doc: accept alignment only if the alignment identity is >= FLOAT
    default: 0
    inputBinding:
      position: 103
      prefix: --min-ident
  - id: min_mem
    type:
      - 'null'
      - int
    doc: minimum MEM length (if 0 estimate via -e)
    default: 0
    inputBinding:
      position: 103
      prefix: --min-mem
  - id: mismatch
    type:
      - 'null'
      - int
    doc: use this mismatch penalty
    default: 4
    inputBinding:
      position: 103
      prefix: --mismatch
  - id: mq_max
    type:
      - 'null'
      - int
    doc: cap the mapping quality at INT
    default: 60
    inputBinding:
      position: 103
      prefix: --mq-max
  - id: mq_overlap
    type:
      - 'null'
      - float
    doc: scale MQ by count of alignments with FLOAT overlap in the query with 
      the primary
    default: 0
    inputBinding:
      position: 103
      prefix: --mq-overlap
  - id: no_patch_aln
    type:
      - 'null'
      - boolean
    doc: do not patch banded alignments by locally aligning unaligned regions
    inputBinding:
      position: 103
      prefix: --no-patch-aln
  - id: output_json
    type:
      - 'null'
      - boolean
    doc: output JSON rather than an alignment stream (helpful for debugging)
    inputBinding:
      position: 103
      prefix: --output-json
  - id: print_frag_model
    type:
      - 'null'
      - boolean
    doc: suppress alignment output and print the fragment model on stdout as per
      -I format
    inputBinding:
      position: 103
      prefix: --print-frag-model
  - id: qual_adjust
    type:
      - 'null'
      - boolean
    doc: perform base quality adjusted alignments (requires base quality input)
    inputBinding:
      position: 103
      prefix: --qual-adjust
  - id: read_group
    type:
      - 'null'
      - string
    doc: for --reads input, add this read group
    inputBinding:
      position: 103
      prefix: --read-group
  - id: reads_file
    type:
      - 'null'
      - File
    doc: take reads (one per line) from FILE, write alignments to stdout
    inputBinding:
      position: 103
      prefix: --reads
  - id: recombination_penalty
    type:
      - 'null'
      - float
    doc: use this log recombination penalty for GBWT haplotype scoring
    default: 20.7
    inputBinding:
      position: 103
      prefix: --recombination-penalty
  - id: ref_name
    type:
      - 'null'
      - string
    doc: reference assembly in graph for HTSlib output
    inputBinding:
      position: 103
      prefix: --ref-name
  - id: ref_paths
    type:
      - 'null'
      - File
    doc: ordered list of paths in graph, one per line or HTSlib .dict, for 
      HTSlib @SQ headers
    inputBinding:
      position: 103
      prefix: --ref-paths
  - id: refpos_table
    type:
      - 'null'
      - boolean
    doc: for efficient testing output a table of name, chr, pos, mq, score
    inputBinding:
      position: 103
      prefix: --refpos-table
  - id: reseed_x
    type:
      - 'null'
      - float
    doc: look for internal seeds inside a seed longer than FLOAT*--min-seed
    default: 1.5
    inputBinding:
      position: 103
      prefix: --reseed-x
  - id: sample
    type:
      - 'null'
      - string
    doc: for --reads input, add this sample
    inputBinding:
      position: 103
      prefix: --sample
  - id: score_matrix
    type:
      - 'null'
      - File
    doc: use this 4x4 integer substitution scoring matrix (in the order ACGT)
    inputBinding:
      position: 103
      prefix: --score-matrix
  - id: seq_name
    type:
      - 'null'
      - string
    doc: name the sequence STR (for graph modification with new named paths)
    inputBinding:
      position: 103
      prefix: --seq-name
  - id: sequence
    type:
      - 'null'
      - string
    doc: align a string to the graph in graph.vg using partial order alignment
    inputBinding:
      position: 103
      prefix: --sequence
  - id: surject_to
    type:
      - 'null'
      - string
    doc: surject the output into the graph's paths, writing TYPE {bam, sam, 
      cram}
    inputBinding:
      position: 103
      prefix: --surject-to
  - id: threads
    type:
      - 'null'
      - int
    doc: number of compute threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: try_at_least
    type:
      - 'null'
      - int
    doc: attempt to align at least the INT best candidate chains of seeds
    default: 1
    inputBinding:
      position: 103
      prefix: --try-at-least
  - id: try_up_to
    type:
      - 'null'
      - int
    doc: attempt to align up to the INT best candidate chains of seeds (1/2 for 
      paired)
    default: 128
    inputBinding:
      position: 103
      prefix: --try-up-to
  - id: unpaired_cost
    type:
      - 'null'
      - int
    doc: penalty for an unpaired read pair
    default: 17
    inputBinding:
      position: 103
      prefix: --unpaired-cost
  - id: xdrop_alignment
    type:
      - 'null'
      - boolean
    doc: use X-drop heuristic (much faster for long-read alignment)
    inputBinding:
      position: 103
      prefix: --xdrop-alignment
  - id: xg_name
    type:
      - 'null'
      - File
    doc: use this XG index or graph [<graph>.vg.xg]
    inputBinding:
      position: 103
      prefix: --xg-name
outputs:
  - id: output_gam
    type:
      - 'null'
      - File
    doc: Output GAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
