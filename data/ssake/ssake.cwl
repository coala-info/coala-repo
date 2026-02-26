cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssake
label: ssake
doc: "SSAKE (A Short Read Sequence Assembly Program)\n\nTool homepage: https://github.com/warrenlr/SSAKE"
inputs:
  - id: apply_read_space_restriction
    type:
      - 'null'
      - boolean
    doc: Apply read space restriction to seeds while -s option in use (-u 1 = 
      yes, default = no, optional)
    default: false
    inputBinding:
      position: 101
      prefix: -u
  - id: break_tie_random_base
    type:
      - 'null'
      - boolean
    doc: Break tie when no consensus base at position, pick random base (-q 1 = 
      yes, default = no, optional)
    default: false
    inputBinding:
      position: 101
      prefix: -q
  - id: error_percent_mean_distance
    type:
      - 'null'
      - float
    doc: Error (%) allowed on mean distance e.g. -e 0.75 == distance +/- 75% 
      (default -e 0.75, optional)
    default: 0.75
    inputBinding:
      position: 101
      prefix: -e
  - id: ignore_read_mapping
    type:
      - 'null'
      - boolean
    doc: Ignore read mapping to consensus (-y 1 = yes, default = no, optional)
    default: false
    inputBinding:
      position: 101
      prefix: -y
  - id: ignore_read_name_header
    type:
      - 'null'
      - boolean
    doc: Ignore read name/header *will use less RAM if set to -h 1* (-h 1 = yes,
      default = no, optional)
    default: false
    inputBinding:
      position: 101
      prefix: -h
  - id: independent_assembly
    type:
      - 'null'
      - boolean
    doc: Independent (de novo) assembly i.e Targets used to recruit reads for de
      novo assembly, not guide/seed reference-based assemblies (-i 1 = yes 
      (default), 0 = no, optional)
    default: true
    inputBinding:
      position: 101
      prefix: -i
  - id: max_link_ratio_contig_pairs
    type:
      - 'null'
      - float
    doc: Maximum link ratio between two best contig pairs *higher values lead to
      least accurate scaffolding* (default -a 0.3, optional)
    default: 0.3
    inputBinding:
      position: 101
      prefix: -a
  - id: min_contig_size_for_coverage_tracking
    type:
      - 'null'
      - int
    doc: Minimum contig size to track base coverage and read position (default 
      -z 100, optional)
    default: 100
    inputBinding:
      position: 101
      prefix: -z
  - id: min_coverage
    type: int
    doc: Minimum depth of coverage allowed for contigs (e.g. -w 1 = process all 
      reads [v3.7 behavior], required, recommended -w 5)
    inputBinding:
      position: 101
      prefix: -w
  - id: min_links_for_scaffold
    type:
      - 'null'
      - int
    doc: Minimum number of links (read pairs) to compute scaffold (default -k 5,
      optional)
    default: 5
    inputBinding:
      position: 101
      prefix: -l
  - id: min_overhang_consensus_ratio
    type:
      - 'null'
      - float
    doc: Minimum base ratio used to accept a overhang consensus base (default -r
      0.7)
    default: 0.7
    inputBinding:
      position: 101
      prefix: -r
  - id: min_overlap_bases
    type:
      - 'null'
      - int
    doc: Minimum number of overlapping bases with the seed/contig during 
      overhang consensus build up (default -m 20)
    default: 20
    inputBinding:
      position: 101
      prefix: -m
  - id: min_reads_for_base_call
    type:
      - 'null'
      - int
    doc: Minimum number of reads needed to call a base during an extension 
      (default -o 2)
    default: 2
    inputBinding:
      position: 101
      prefix: -o
  - id: output_basename
    type:
      - 'null'
      - string
    doc: Base name for your output files (optional)
    inputBinding:
      position: 101
      prefix: -b
  - id: paired_reads_file
    type: File
    doc: File containing all the [paired (-p 1)] reads (required)
    inputBinding:
      position: 101
      prefix: -f
  - id: seed_sequences_file
    type:
      - 'null'
      - File
    doc: Fasta file containing sequences to use as seeds exclusively (specify 
      only if different from read set, optional)
    inputBinding:
      position: 101
      prefix: -s
  - id: target_word_size
    type:
      - 'null'
      - int
    doc: Target sequence word size to hash (default -j 15)
    default: 15
    inputBinding:
      position: 101
      prefix: -j
  - id: track_coverage_and_position
    type:
      - 'null'
      - boolean
    doc: Track base coverage and read position for each contig (default -c 0, 
      optional)
    default: false
    inputBinding:
      position: 101
      prefix: -c
  - id: trim_bases
    type:
      - 'null'
      - int
    doc: Trim up to -t base(s) on the contig end when all possibilities have 
      been exhausted for an extension (default -t 0, optional)
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: unpaired_reads_file
    type:
      - 'null'
      - File
    doc: Fasta file containing unpaired sequence reads (optional)
    inputBinding:
      position: 101
      prefix: -g
  - id: use_paired_end_reads
    type:
      - 'null'
      - boolean
    doc: Paired-end reads used? (-p 1 = yes, default = no, optional)
    default: false
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Runs in verbose mode (-v 1 = yes, default = no, optional)
    default: false
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssake:v4.0-2-deb_cv1
stdout: ssake.out
