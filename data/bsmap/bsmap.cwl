cwlVersion: v1.2
class: CommandLineTool
baseCommand: bsmap
label: bsmap
doc: "BSMAP is a short-read alignment program for whole-genome bisulfite sequencing.\n\
  \nTool homepage: https://code.google.com/archive/p/bsmap/"
inputs:
  - id: adapter_sequence
    type:
      - 'null'
      - string
    doc: '3-end adapter sequence, default: none (no trim)'
    inputBinding:
      position: 101
      prefix: -A
  - id: additional_nucleotide_transition
    type:
      - 'null'
      - string
    doc: 'set alignment information for the additional nucleotide transition. <str>
      is in the form of two different nucleotides N1N2, indicating N1 in the reads
      could be mapped to N2 in the reference sequences. default: -M TC, corresponds
      to C=>U(T) transition in bisulfite conversion. example: -M GA could be used
      to detect A=>I(G) transition in RNA editing.'
    default: TC
    inputBinding:
      position: 101
      prefix: -M
  - id: base_quality
    type:
      - 'null'
      - int
    doc: base quality, default=33 [Illumina is using 64, Sanger Institute is 
      using 33]
    default: 33
    inputBinding:
      position: 101
      prefix: -z
  - id: end_at_read_pair
    type:
      - 'null'
      - int
    doc: 'end at the Nth read or read pair, default: 4,294,967,295'
    default: 4,294,967,295
    inputBinding:
      position: 101
      prefix: -E
  - id: filter_low_quality_reads_with_Ns
    type:
      - 'null'
      - int
    doc: filter low-quality reads containing >n Ns, default=5
    default: 5
    inputBinding:
      position: 101
      prefix: -f
  - id: gap_size
    type:
      - 'null'
      - int
    doc: gap size, BSMAP only allow 1 continuous gap (insert or deletion) with 
      up to 3 nucleotides
    default: 0
    inputBinding:
      position: 101
      prefix: -g
  - id: index_interval
    type:
      - 'null'
      - int
    doc: index interval, default=4
    default: 4
    inputBinding:
      position: 101
      prefix: -I
  - id: kmer_cutoff_ratio
    type:
      - 'null'
      - float
    doc: 'set the cut-off ratio for over-represented kmers, default=5e-07 example:
      -k 1e-6 means the top 0.0001% over-represented kmer will be skipped in alignment'
    default: '5e-07'
    inputBinding:
      position: 101
      prefix: -k
  - id: map_first_n_nucleotides
    type:
      - 'null'
      - int
    doc: map the first N nucleotides of the read, default:160 (map the whole 
      read).
    default: 160
    inputBinding:
      position: 101
      prefix: -L
  - id: mapping_strand_info
    type:
      - 'null'
      - string
    doc: 'set mapping strand information. default: 0 -n 0: only map to 2 forward strands,
      i.e. BSW(++) and BSC(-+), for PE sequencing, map read#1 to ++ and -+, read#2
      to +- and --. -n 1: map SE or PE reads to all 4 strands, i.e. ++, +-, -+, --'
    default: 0
    inputBinding:
      position: 101
      prefix: -n
  - id: max_equal_best_hits
    type:
      - 'null'
      - int
    doc: maximum number of equal best hits to count, <=1000
    inputBinding:
      position: 101
      prefix: -w
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: maximal insert size allowed, default=1000
    default: 1000
    inputBinding:
      position: 101
      prefix: -x
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: minimal insert size allowed, default=28
    default: 28
    inputBinding:
      position: 101
      prefix: -m
  - id: mismatch_rate_or_max
    type:
      - 'null'
      - float
    doc: "if this value is between 0 and 1, it's interpreted as the mismatch rate
      w.r.t to the read length. otherwise it's interpreted as the maximum number of
      mismatches allowed on a read, <=15. example: -v 5 (max #mismatches = 5), -v
      0.1 (max #mismatches = read_length * 10%)"
    default: 0.08
    inputBinding:
      position: 101
      prefix: -v
  - id: no_header_info
    type:
      - 'null'
      - boolean
    doc: do not print header information in SAM format output
    inputBinding:
      position: 101
      prefix: -H
  - id: num_processors
    type:
      - 'null'
      - int
    doc: number of processors to use, default=8
    default: 8
    inputBinding:
      position: 101
      prefix: -p
  - id: quality_threshold_trimming
    type:
      - 'null'
      - int
    doc: quality threshold in trimming, 0-40, default=0 (no trim)
    default: 0
    inputBinding:
      position: 101
      prefix: -q
  - id: query_b_file
    type:
      - 'null'
      - File
    doc: query b file
    inputBinding:
      position: 101
      prefix: -b
  - id: query_file
    type: File
    doc: query a file, FASTA/FASTQ/BAM format
    inputBinding:
      position: 101
      prefix: -a
  - id: random_seed
    type:
      - 'null'
      - int
    doc: seed for random number generation used in selecting multiple hits other
      seed values generate pseudo random number based on read index number, to 
      allow reproducible mapping results. default=0. (get seed from system 
      clock, mapping results not resproducible.)
    default: 0
    inputBinding:
      position: 101
      prefix: -S
  - id: reference_sequences
    type: File
    doc: reference sequences file, FASTA format
    inputBinding:
      position: 101
      prefix: -d
  - id: report_reference_sequences
    type:
      - 'null'
      - boolean
    doc: print corresponding reference sequences in SAM output, default=off
    inputBinding:
      position: 101
      prefix: -R
  - id: report_repeat_hits
    type:
      - 'null'
      - string
    doc: how to report repeat hits, 0=none(unique hit/pair); 1=random one; 
      2=all(slow), default:1.
    default: 1
    inputBinding:
      position: 101
      prefix: -r
  - id: report_unmapped_reads
    type:
      - 'null'
      - boolean
    doc: report unmapped reads, default=off
    inputBinding:
      position: 101
      prefix: -u
  - id: rrbs_mode_and_digestion_sites
    type:
      - 'null'
      - string
    doc: "activating RRBS mapping mode and set restriction enzyme digestion sites.
      digestion position marked by '-', example: -D C-CGG for MspI digestion. default:
      none (whole genome shotgun bisulfite mapping mode)"
    inputBinding:
      position: 101
      prefix: -D
  - id: seed_size
    type:
      - 'null'
      - int
    doc: seed size, default=16(WGBS mode), 12(RRBS mode). min=8, max=16.
    default: 16(WGBS mode), 12(RRBS mode)
    inputBinding:
      position: 101
      prefix: -s
  - id: start_from_read_pair
    type:
      - 'null'
      - int
    doc: 'start from the Nth read or read pair, default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: -B
  - id: use_3_nucleotide_mapping
    type:
      - 'null'
      - boolean
    doc: using 3-nucleotide mapping approach
    inputBinding:
      position: 101
      prefix: '-3'
  - id: verbose_level
    type:
      - 'null'
      - string
    doc: 'verbose level: 0=no message displayed (quiet mode); 1=major message (default);
      2=detailed message.'
    default: 1
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output alignment file, BSP/SAM/BAM format, if omitted, the output will 
      be written to STDOUT in SAM format.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bsmap:2.90--py27_0
