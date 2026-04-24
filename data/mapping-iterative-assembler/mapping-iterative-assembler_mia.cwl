cwlVersion: v1.2
class: CommandLineTool
baseCommand: mia
label: mapping-iterative-assembler_mia
doc: "A tool for creating short read assemblies.\n\nTool homepage: https://github.com/mpieva/mapping-iterative-assembler"
inputs:
  - id: adapter_sequence_or_code
    type:
      - 'null'
      - string
    doc: adapter sequence or code
    inputBinding:
      position: 101
      prefix: -a
  - id: circular_reference_or_assembly
    type:
      - 'null'
      - boolean
    doc: means reference/assembly is circular
    inputBinding:
      position: 101
      prefix: -c
  - id: collapse_sequences_tolerance
    type:
      - 'null'
      - int
    doc: 'collapse sequences with same start, end, strand info into a single sequence.
      Allow <tolerance> bases difference for start and end coordinates. Important:
      keep NO SPACE between parameter and value: e.g. -C3'
    inputBinding:
      position: 101
      prefix: -C
  - id: consensus_calling_code
    type:
      - 'null'
      - int
    doc: consensus calling code; default = 1
    inputBinding:
      position: 101
      prefix: -p
  - id: discount_homopolymer_gaps
    type:
      - 'null'
      - boolean
    doc: give special discount for homopolymer gaps
    inputBinding:
      position: 101
      prefix: -h
  - id: distantly_related_reference
    type:
      - 'null'
      - File
    doc: distantly related reference sequence
    inputBinding:
      position: 101
      prefix: -D
  - id: filter_repeats_by_qscore_sum
    type:
      - 'null'
      - boolean
    doc: fasta database has repeat sequences, keep one based on sum of q-scores
    inputBinding:
      position: 101
      prefix: -U
  - id: filter_repeats_by_score
    type:
      - 'null'
      - boolean
    doc: fasta database has repeat sequences, keep one based on alignment score
    inputBinding:
      position: 101
      prefix: -u
  - id: fragments_file
    type: File
    doc: fasta or fastq file of fragments to align
    inputBinding:
      position: 101
      prefix: -f
  - id: hard_score_cutoff
    type:
      - 'null'
      - int
    doc: do not do dynamic score cutoff, instead use this Hard score cutoff
    inputBinding:
      position: 101
      prefix: -H
  - id: intercept_length_score_cutoff
    type:
      - 'null'
      - float
    doc: intercept of length/score cutoff line
    inputBinding:
      position: 101
      prefix: -N
  - id: iterate_assembly
    type:
      - 'null'
      - boolean
    doc: iterate assembly until convergence (default)
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_filter_length
    type:
      - 'null'
      - int
    doc: use kmer filter with kmers of this length
    inputBinding:
      position: 101
      prefix: -k
  - id: maln_output_root_file
    type:
      - 'null'
      - string
    doc: root file name for maln output file(s) (assembly.maln.iter)
    inputBinding:
      position: 101
      prefix: -m
  - id: no_iterate_assembly
    type:
      - 'null'
      - boolean
    doc: do not iterate assembly until convergence
    inputBinding:
      position: 101
      prefix: -n
  - id: output_final_assembly_only
    type:
      - 'null'
      - boolean
    doc: only output the FINAL assembly, not each iteration
    inputBinding:
      position: 101
      prefix: -F
  - id: reference_sequence
    type: File
    doc: reference sequence
    inputBinding:
      position: 101
      prefix: -r
  - id: sequence_ids_to_use_file
    type:
      - 'null'
      - File
    doc: filename of list of sequence IDs to use, ignoring all others
    inputBinding:
      position: 101
      prefix: -I
  - id: slope_length_score_cutoff
    type:
      - 'null'
      - float
    doc: slope of length/score cutoff line
    inputBinding:
      position: 101
      prefix: -S
  - id: substitution_matrix_file
    type:
      - 'null'
      - File
    doc: substitution matrix file (if not supplied an default matrix is used)
    inputBinding:
      position: 101
      prefix: -s
  - id: trim_adapters
    type:
      - 'null'
      - boolean
    doc: fasta database has adapters, trim these
    inputBinding:
      position: 101
      prefix: -T
  - id: use_adapter_presence_for_filtering
    type:
      - 'null'
      - boolean
    doc: use adapter presence and coordinate information to more aggressively 
      remove repeat sequences - suitable only for 454 sequences that have not 
      already been adapter trimmed
    inputBinding:
      position: 101
      prefix: -A
  - id: use_lowercase_soft_masking
    type:
      - 'null'
      - boolean
    doc: use lower-case soft-masking of kmers
    inputBinding:
      position: 101
      prefix: -M
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/mapping-iterative-assembler:1.0--h503566f_7
stdout: mapping-iterative-assembler_mia.out
