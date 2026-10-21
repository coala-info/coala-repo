cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - sw
label: ropebwt3_sw
doc: "Find local alignments of query sequences in an FMR/FMD index.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: idx_fmr
    type: File
    doc: Input FMR or FMD index file (<index>.ssa, the sampled suffix array, and <index>.len.gz, the sequence names and lengths, are used when present)
    secondaryFiles:
      - pattern: .ssa
        required: false
      - pattern: .len.gz
        required: false
    inputBinding:
      position: 1
  - id: seq_fa
    type:
      type: array
      items: File
    doc: Query FASTA/FASTQ file(s)
    inputBinding:
      position: 2
  - id: max_hits_per_node
    type:
      - 'null'
      - int
    doc: keep up to INT hits per DAWG node
    inputBinding:
      position: 102
      prefix: '-N'
  - id: min_score
    type:
      - 'null'
      - int
    doc: min alignment score
    inputBinding:
      position: 102
      prefix: '-m'
  - id: match_score
    type:
      - 'null'
      - int
    doc: match score
    inputBinding:
      position: 102
      prefix: '-A'
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty
    inputBinding:
      position: 102
      prefix: '-B'
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 102
      prefix: '-O'
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty; a k-long gap costs O+k*E
    inputBinding:
      position: 102
      prefix: '-E'
  - id: ranking_cache_size
    type:
      - 'null'
      - string
    doc: size of the ranking cache
    inputBinding:
      position: 102
      prefix: '-C'
  - id: ignore_secondary_below
    type:
      - 'null'
      - int
    doc: ignore secondary hits scored INT lower than the best
    inputBinding:
      position: 102
      prefix: '-y'
  - id: end_to_end
    type:
      - 'null'
      - boolean
    doc: end-to-end mode (forcing -k to 1)
    inputBinding:
      position: 102
      prefix: '-e'
  - id: min_mem_length
    type:
      - 'null'
      - int
    doc: min MEM length to initiate alignment
    inputBinding:
      position: 102
      prefix: '-j'
  - id: end_kmer
    type:
      - 'null'
      - int
    doc: require INT-mer match at the end of alignment
    inputBinding:
      position: 102
      prefix: '-k'
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: align both strands (effective with --all-e2e)
    inputBinding:
      position: 102
      prefix: '-b'
  - id: write_unmapped
    type:
      - 'null'
      - boolean
    doc: write unmapped queries to PAF
    inputBinding:
      position: 102
      prefix: '-u'
  - id: write_ref_seq
    type:
      - 'null'
      - boolean
    doc: write reference sequence to the rs tag
    inputBinding:
      position: 102
      prefix: '--seq'
  - id: all_e2e
    type:
      - 'null'
      - boolean
    doc: write all end-to-end hits in a compact format (forcing -e)
    inputBinding:
      position: 102
      prefix: '--all-e2e'
  - id: cap_all_e2e
    type:
      - 'null'
      - int
    doc: cap the number of --all-e2e output to INT (forcing --all-e2e)
    inputBinding:
      position: 102
      prefix: '-g'
  - id: no_ssa
    type:
      - 'null'
      - boolean
    doc: ignore the sampled suffix array
    inputBinding:
      position: 102
      prefix: '--no-ssa'
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: '-t'
  - id: output_positions
    type:
      - 'null'
      - int
    doc: output up to INT positions
    inputBinding:
      position: 102
      prefix: '-p'
  - id: one_sequence_per_line
    type:
      - 'null'
      - boolean
    doc: one sequence per line in the input
    inputBinding:
      position: 102
      prefix: '-L'
  - id: query_batch_size
    type:
      - 'null'
      - string
    doc: query batch size
    inputBinding:
      position: 102
      prefix: '-K'
  - id: mmap
    type:
      - 'null'
      - boolean
    doc: use mmap to load FMD
    inputBinding:
      position: 102
      prefix: '-M'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_sw.out
