cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngshmmalign
label: ngshmmalign
doc: "ngshmmalign\n\nTool homepage: https://github.com/cbg-ethz/ngshmmalign"
inputs:
  - id: ambiguous_bases_allele_frequencies
    type:
      - 'null'
      - boolean
    doc: Loci with ambiguous bases get their emission probabilities according to
      their allele frequencies. In practice this is undesirable, as it leads to 
      systematic accumulation of gaps in homopolymeric regions with SNVs
    inputBinding:
      position: 101
      prefix: -U
  - id: consensus_contig_name
    type:
      - 'null'
      - string
    doc: Name of consensus reference contig that will be created
    inputBinding:
      position: 101
      prefix: -N
  - id: extreme_hard_clip
    type:
      - 'null'
      - boolean
    doc: Extreme hard-clip reads. Do not write hard-clip in CIGAR, as if the 
      hard-clipped bases never existed. Mutually exclusive with previous option
    inputBinding:
      position: 101
      prefix: --HARD
  - id: full_exhaustive_search
    type:
      - 'null'
      - boolean
    doc: Use full-exhaustive search, avoiding indexed lookup
    inputBinding:
      position: 101
      prefix: -E
  - id: gap_extend_probability
    type:
      - 'null'
      - float
    doc: Gap extend probability
    inputBinding:
      position: 101
      prefix: --ge
  - id: gap_open_probability
    type:
      - 'null'
      - float
    doc: Gap open probability
    inputBinding:
      position: 101
      prefix: --go
  - id: global_substitution_probability
    type:
      - 'null'
      - float
    doc: Global substitution probability
    inputBinding:
      position: 101
      prefix: --error
  - id: hard_clip
    type:
      - 'null'
      - boolean
    doc: Hard-clip reads. Clipped bases will NOT be in the sequence in the 
      alignment
    inputBinding:
      position: 101
      prefix: --hard
  - id: insert_extend_probability
    type:
      - 'null'
      - float
    doc: Insert extend probability
    inputBinding:
      position: 101
      prefix: --ie
  - id: insert_open_probability
    type:
      - 'null'
      - float
    doc: Insert open probability
    inputBinding:
      position: 101
      prefix: --io
  - id: jump_to_end_probability
    type:
      - 'null'
      - float
    doc: Jump to end probability; usually 1/L, where L is the average length of 
      the reads
    inputBinding:
      position: 101
      prefix: --ep
  - id: keep_mafft_temp_files
    type:
      - 'null'
      - boolean
    doc: Do not clean up MAFFT temporary MSA files
    inputBinding:
      position: 101
      prefix: -l
  - id: left_clip_extend_probability
    type:
      - 'null'
      - float
    doc: Left clip extend probability
    inputBinding:
      position: 101
      prefix: --lce
  - id: left_clip_open_probability
    type:
      - 'null'
      - float
    doc: Left clip open probability
    inputBinding:
      position: 101
      prefix: --lco
  - id: min_ambiguous_base_frequency
    type:
      - 'null'
      - float
    doc: Minimum frequency for calling ambiguous base
    inputBinding:
      position: 101
      prefix: -a
  - id: min_mapped_length
    type:
      - 'null'
      - float
    doc: Minimum mapped length of read
    inputBinding:
      position: 101
      prefix: -M
  - id: progress_indicator
    type:
      - 'null'
      - boolean
    doc: Show progress indicator while aligning
    inputBinding:
      position: 101
      prefix: -v
  - id: reference_profile
    type:
      - 'null'
      - File
    doc: File containing the profile/MSA of the reference
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_profile_mafft
    type:
      - 'null'
      - File
    doc: File containing the profile/MSA of the reference. Will perform a 
      comprehensive parameter estimation using MAFFT. Mutually exclusive with -r
      option
    inputBinding:
      position: 101
      prefix: -R
  - id: replace_match_mismatch_cigar
    type:
      - 'null'
      - boolean
    doc: Replace general aligned state 'M' with '=' (match) and 'X' (mismatch) 
      in CIGAR
    inputBinding:
      position: 101
      prefix: -X
  - id: right_clip_extend_probability
    type:
      - 'null'
      - float
    doc: Right clip extend probability
    inputBinding:
      position: 101
      prefix: --rce
  - id: right_clip_open_probability
    type:
      - 'null'
      - float
    doc: Right clip open probability
    inputBinding:
      position: 101
      prefix: --rco
  - id: seed
    type:
      - 'null'
      - int
    doc: Value of seed for deterministic run. A value of 0 will pick a random 
      seed from some non-deterministic entropy source
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment. Defaults to number of logical 
      cores found
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_alignment
    type:
      - 'null'
      - File
    doc: Filename where alignment will be written to
    outputBinding:
      glob: $(inputs.output_alignment)
  - id: filtered_alignment
    type:
      - 'null'
      - File
    doc: Filename where alignment will be written that are filtered (too short, 
      unpaired)
    outputBinding:
      glob: $(inputs.filtered_alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngshmmalign:0.1.1--0
