cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtpoa-cns
label: wtdbg_wtpoa-cns
doc: "Consensuser for wtdbg using PO-MSA\n\nTool homepage: https://github.com/ruanjue/wtdbg-1.2.8"
inputs:
  - id: abort_tri_poa_on_fast_align_fail
    type:
      - 'null'
      - boolean
    doc: Abort TriPOA when any read cannot be fast aligned, then try POA
    inputBinding:
      position: 101
      prefix: -A
  - id: bonus_tri_bases_match
    type:
      - 'null'
      - int
    doc: Bonus for tri-bases match
    inputBinding:
      position: 101
      prefix: -b
  - id: consensus_mode
    type:
      - 'null'
      - int
    doc: 'Consensus mode: 0, run-length; 1, dp-call-cns'
    inputBinding:
      position: 101
      prefix: -c
  - id: deletion_score
    type:
      - 'null'
      - int
    doc: Deletion score
    inputBinding:
      position: 101
      prefix: -D
  - id: expected_max_node_length
    type:
      - 'null'
      - int
    doc: Expected max length of node, or say the overlap length of two adjacent 
      units in layout file, [1500] bp. overlap will be default to 1500(or 150 
      for sam-sr) when having -d/-p, block size will be 2.5 * overlap
    inputBinding:
      position: 101
      prefix: -j
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite
    inputBinding:
      position: 101
      prefix: -f
  - id: force_reference_mode
    type:
      - 'null'
      - boolean
    doc: Force to use reference mode
    inputBinding:
      position: 101
      prefix: -r
  - id: homopolymer_merge_score
    type:
      - 'null'
      - float
    doc: Homopolymer merge score used in dp-call-cns mode
    inputBinding:
      position: 101
      prefix: -H
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) *.ctg.lay from wtdbg, +, Or sorted SAM files when having 
      -d/-p
    inputBinding:
      position: 101
      prefix: -i
  - id: insertion_score
    type:
      - 'null'
      - int
    doc: Insertion score
    inputBinding:
      position: 101
      prefix: -I
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score
    inputBinding:
      position: 101
      prefix: -M
  - id: max_reads_poa_msa
    type:
      - 'null'
      - int
    doc: Max number of reads in PO-MSA. Keep in mind that I am not going to 
      generate high accurate consensus sequences here
    inputBinding:
      position: 101
      prefix: -N
  - id: min_aligned_size_in_window
    type:
      - 'null'
      - string
    doc: Min size of aligned size in window
    inputBinding:
      position: 101
      prefix: -w
  - id: min_bases_for_consensus
    type:
      - 'null'
      - int
    doc: Min count of bases to call a consensus base
    inputBinding:
      position: 101
      prefix: -C
  - id: min_frequency_non_gap
    type:
      - 'null'
      - float
    doc: Min frequency of non-gap bases to call a consensus base
    inputBinding:
      position: 101
      prefix: -F
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: Mismatch score
    inputBinding:
      position: 101
      prefix: -X
  - id: poa_bandwidth
    type:
      - 'null'
      - string
    doc: Bandwidth in POA, [Wmin[,Wmax[,mat_rate]]], mat_rate = 
      matched_bases/total_bases. Program will double bandwidth from Wmin to Wmax
      when mat_rate is lower than setting
    inputBinding:
      position: 101
      prefix: -B
  - id: presets
    type:
      - 'null'
      - string
    doc: "Presets, sam-sr: polishs contigs from short reads mapping, accepts sorted
      SAM files; shorted for '-j 50 -W 0 -R 0 -b 1 -c 1 -N 50 -rS 2'"
    inputBinding:
      position: 101
      prefix: -x
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet
    inputBinding:
      position: 101
      prefix: -q
  - id: realignment_bandwidth
    type:
      - 'null'
      - int
    doc: 'Realignment bandwidth, 0: disable'
    inputBinding:
      position: 101
      prefix: -R
  - id: reference_sequences
    type:
      - 'null'
      - string
    doc: Reference sequences for SAM input, will invoke sorted-SAM input mode
    inputBinding:
      position: 101
      prefix: -d
  - id: shuffle_mode
    type:
      - 'null'
      - int
    doc: "Shuffle mode, 0: don't shuffle reads, 1: by shared kmers, 2: subsampling."
    inputBinding:
      position: 101
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: translate_sam_to_layout
    type:
      - 'null'
      - string
    doc: Similar with -d, but translate SAM into wtdbg layout file
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 101
      prefix: -v
  - id: window_size_fast_align
    type:
      - 'null'
      - int
    doc: Window size in the middle of the first read for fast align remaining 
      reads. If $W is negative, will disable fast align, but use the abs($W) as 
      Band align score cutoff
    inputBinding:
      position: 101
      prefix: -W
  - id: xor_flags
    type:
      - 'null'
      - int
    doc: "XORed flags to handle SAM input. 0x1: Only process reference regions present
      in/between SAM alignments; 0x2: Don't fileter secondary/supplementary SAM records
      with flag (0x100 | 0x800)"
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: output_files
    type:
      - 'null'
      - File
    doc: Output files
    outputBinding:
      glob: $(inputs.output_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg:2.5--h5b5514e_2
