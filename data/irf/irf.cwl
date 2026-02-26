cwlVersion: v1.2
class: CommandLineTool
baseCommand: irf
label: irf
doc: "Inverted Repeats Finder\n\nTool homepage: https://github.com/Benson-Genomics-Lab/IRF"
inputs:
  - id: file
    type: File
    doc: sequences input file
    inputBinding:
      position: 1
  - id: match
    type: int
    doc: matching weight
    inputBinding:
      position: 2
  - id: mismatch
    type: int
    doc: mismatching penalty
    inputBinding:
      position: 3
  - id: delta
    type: int
    doc: indel penalty
    inputBinding:
      position: 4
  - id: pm
    type: int
    doc: match probability (whole number)
    inputBinding:
      position: 5
  - id: pi
    type: int
    doc: indel probability (whole number)
    inputBinding:
      position: 6
  - id: minscore
    type: int
    doc: minimum alignment score to report
    inputBinding:
      position: 7
  - id: max_length
    type: int
    doc: maximum stem length to report (10,000 minimum and no upper limit, but 
      system will run out memory if this is too large)
    inputBinding:
      position: 8
  - id: max_loop
    type: int
    doc: filters results to have loop less than this value (will not give you 
      more results unless you increase -t4,-t4,-t7 as well)
    inputBinding:
      position: 9
  - id: allow_gt_match
    type:
      - 'null'
      - boolean
    doc: allow the GT match (gt matching weight must follow immediately after 
      the switch)
    inputBinding:
      position: 110
      prefix: -gt
  - id: compact_dat_output
    type:
      - 'null'
      - boolean
    doc: more compact .dat output on multisequence files, returns 0 on success.
    inputBinding:
      position: 110
      prefix: -ngs
  - id: data_file
    type:
      - 'null'
      - boolean
    doc: data file
    inputBinding:
      position: 110
      prefix: -d
  - id: flanking_sequence
    type:
      - 'null'
      - boolean
    doc: flanking sequence
    inputBinding:
      position: 110
      prefix: -f
  - id: identity_value
    type:
      - 'null'
      - int
    doc: set the identity value of the redundancy algorithm (value 60 to 100 
      must follow immediately after the switch)
    inputBinding:
      position: 110
      prefix: -r
  - id: lookahead_test
    type:
      - 'null'
      - boolean
    doc: lookahead test enabled. Results are slightly different as a repeat 
      might be found at a different interval. Faster.
    inputBinding:
      position: 110
      prefix: -la
  - id: lowercase_participate
    type:
      - 'null'
      - boolean
    doc: lowercase letters do not participate in a k-tuple match, but can be 
      part of an alignment
    inputBinding:
      position: 110
      prefix: -l
  - id: masked_sequence_file
    type:
      - 'null'
      - boolean
    doc: masked sequence file
    inputBinding:
      position: 110
      prefix: -m
  - id: max_loop_separation_tuple4
    type:
      - 'null'
      - int
    doc: set the maximum loop separation for tuple of length4 (default 154, 
      separation <=1,000 must follow)
    inputBinding:
      position: 110
      prefix: -t4
  - id: max_loop_separation_tuple5
    type:
      - 'null'
      - int
    doc: set the maximum loop separation for tuple of length5 (default 813, 
      separation <=10,000 must follow)
    inputBinding:
      position: 110
      prefix: -t5
  - id: max_loop_separation_tuple7
    type:
      - 'null'
      - int
    doc: set the maximum loop separation for tuple of length7 (default 14800, 
      limited by your system's memory, make sure you increase maxloop to the 
      same value)
    inputBinding:
      position: 110
      prefix: -t7
  - id: mirror_repeats
    type:
      - 'null'
      - boolean
    doc: target is mirror repeats
    inputBinding:
      position: 110
      prefix: -mr
  - id: modified_redundancy_algorithm
    type:
      - 'null'
      - boolean
    doc: modified redundancy algorithm, does not remove stuff which is redundant
      to redundant. Slower and not good for TA repeat regions, would not leave 
      the largest, but a whole bunch.
    inputBinding:
      position: 110
      prefix: -r2
  - id: narrowband_alignment
    type:
      - 'null'
      - boolean
    doc: same as a3 but alignment is of maximum narrowband width. Slightly 
      better results than a3. Much slower.
    inputBinding:
      position: 110
      prefix: -a4
  - id: no_redundancy_elimination
    type:
      - 'null'
      - boolean
    doc: do not eliminate redundancy from the output
    inputBinding:
      position: 110
      prefix: -r0
  - id: no_stop_all_intervals
    type:
      - 'null'
      - boolean
    doc: Do not stop once a repeat is found at a certain interval and try all 
      intervals at same and nearby centers. Better(?) results. Much slower.
    inputBinding:
      position: 110
      prefix: -i2
  - id: no_stop_interval_repeat
    type:
      - 'null'
      - boolean
    doc: Do not stop once a repeat is found at a certain interval and try larger
      intervals at nearby centers. Better(?) results. Slower.
    inputBinding:
      position: 110
      prefix: -i1
  - id: suppress_html_output
    type:
      - 'null'
      - boolean
    doc: suppress HTML output
    inputBinding:
      position: 110
      prefix: -h
  - id: third_alignment
    type:
      - 'null'
      - boolean
    doc: perform a third alignment going inward. Produces longer or better 
      alignments. Slower.
    inputBinding:
      position: 110
      prefix: -a3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irf:3.09--h7b50bb2_0
stdout: irf.out
