cwlVersion: v1.2
class: CommandLineTool
baseCommand: satsuma2_SatsumaSynteny2
label: satsuma2_SatsumaSynteny2
doc: "Wrapper around high-sensitivity alignments.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: allow_dups
    type:
      - 'null'
      - boolean
    doc: allow for duplications in the query sequence
    default: 0
    inputBinding:
      position: 101
      prefix: -dups
  - id: cutoff
    type:
      - 'null'
      - float
    doc: signal cutoff
    default: 1.8
    inputBinding:
      position: 101
      prefix: -cutoff
  - id: do_refine
    type:
      - 'null'
      - boolean
    doc: refinement steps
    default: 0
    inputBinding:
      position: 101
      prefix: -do_refine
  - id: dump_cycle_matches
    type:
      - 'null'
      - boolean
    doc: dump matches on each cycle (for debug/testing)
    default: 0
    inputBinding:
      position: 101
      prefix: -dump_cycle_matches
  - id: jobs_per_block
    type:
      - 'null'
      - int
    doc: number of jobs per block
    default: 4
    inputBinding:
      position: 101
      prefix: -m
  - id: kmatch_memory
    type:
      - 'null'
      - int
    doc: memory required for kmatch (Gb)
    inputBinding:
      position: 101
      prefix: -km_mem
  - id: kmatch_sync
    type:
      - 'null'
      - boolean
    doc: run kmatch jobs synchronously
    default: 1
    inputBinding:
      position: 101
      prefix: -km_sync
  - id: max_seed_kmer_freq
    type:
      - 'null'
      - int
    doc: maximum frequency for kmatch seed kmers
    default: 1
    inputBinding:
      position: 101
      prefix: -max_seed_kmer_freq
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: minimum alignment length
    default: 0
    inputBinding:
      position: 101
      prefix: -l
  - id: min_matches
    type:
      - 'null'
      - int
    doc: minimum matches per target to keep iterating
    default: 20
    inputBinding:
      position: 101
      prefix: -min_matches
  - id: min_prob
    type:
      - 'null'
      - float
    doc: minimum probability to keep match
    default: 0.99999
    inputBinding:
      position: 101
      prefix: -min_prob
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: minimum length for kmatch seeds (after collapsing)
    default: 24
    inputBinding:
      position: 101
      prefix: -min_seed_length
  - id: nofilter
    type:
      - 'null'
      - boolean
    doc: do not pre-filter seeds (slower runtime)
    default: 0
    inputBinding:
      position: 101
      prefix: -nofilter
  - id: old_seed
    type:
      - 'null'
      - string
    doc: loads seeds and runs from there (xcorr*data)
    default: ''
    inputBinding:
      position: 101
      prefix: -old_seed
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: pixel
    type:
      - 'null'
      - int
    doc: number of blocks per pixel
    default: 24
    inputBinding:
      position: 101
      prefix: -pixel
  - id: prob_table
    type:
      - 'null'
      - boolean
    doc: approximate match prob using a table lookup in slaves
    default: 0
    inputBinding:
      position: 101
      prefix: -prob_table
  - id: processing_slaves
    type:
      - 'null'
      - int
    doc: number of processing slaves
    default: 1
    inputBinding:
      position: 101
      prefix: -slaves
  - id: query_chunk_size
    type:
      - 'null'
      - int
    doc: query chunk size
    default: 4096
    inputBinding:
      position: 101
      prefix: -q_chunk
  - id: query_fasta
    type: string
    doc: query fasta sequence
    inputBinding:
      position: 101
      prefix: -q
  - id: seed
    type:
      - 'null'
      - string
    doc: loads seeds and runs from there (kmatch files prefix)
    default: ''
    inputBinding:
      position: 101
      prefix: -seed
  - id: slaves_memory
    type:
      - 'null'
      - int
    doc: memory requirement for slaves (Gb)
    inputBinding:
      position: 101
      prefix: -sl_mem
  - id: target_chunk_size
    type:
      - 'null'
      - int
    doc: target chunk size
    default: 4096
    inputBinding:
      position: 101
      prefix: -t_chunk
  - id: target_fasta
    type: string
    doc: target fasta sequence
    inputBinding:
      position: 101
      prefix: -t
  - id: threads_per_slave
    type:
      - 'null'
      - int
    doc: number of working threads per processing slave
    default: 1
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
stdout: satsuma2_SatsumaSynteny2.out
