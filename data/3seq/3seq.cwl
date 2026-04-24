cwlVersion: v1.2
class: CommandLineTool
baseCommand: 3seq
label: 3seq
doc: "Software For Identifying Recombination In Sequence Data\n\nTool homepage: https://mol.ax/software/3seq/"
inputs:
  - id: seq_file
    type: File
    doc: Input sequence file (PHYLIP or FASTA format)
    inputBinding:
      position: 1
  - id: actual_comparisons
    type:
      - 'null'
      - boolean
    doc: use the actual number of comparisons performed for multiple comparisons
      corrections
    inputBinding:
      position: 102
      prefix: -#
  - id: all_sites
    type:
      - 'null'
      - boolean
    doc: use all sites rather than just polymorphic sites; default is off.
    inputBinding:
      position: 102
      prefix: -a
  - id: begin_seq
    type:
      - 'null'
      - int
    doc: beginning sequence index for testing child sequences
    inputBinding:
      position: 102
      prefix: -b
  - id: bp_all
    type:
      - 'null'
      - boolean
    doc: calculate all breakpoint positions for all candidate recombinants
    inputBinding:
      position: 102
      prefix: -bp-all
  - id: bp_none
    type:
      - 'null'
      - boolean
    doc: do not calculate any breakpoint positions
    inputBinding:
      position: 102
      prefix: -bp-none
  - id: cut
    type:
      - 'null'
      - boolean
    doc: cut out a portion of the sequence defined by -f and -l and use the 
      remainder
    inputBinding:
      position: 102
      prefix: -x
  - id: distinct_only
    type:
      - 'null'
      - boolean
    doc: distinct sequences only; removes sequences that are identical to other 
      sequences
    inputBinding:
      position: 102
      prefix: -d
  - id: end_seq
    type:
      - 'null'
      - int
    doc: end sequence index for testing child sequences
    inputBinding:
      position: 102
      prefix: -e
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: format output as FASTA (used in write mode only)
    inputBinding:
      position: 102
      prefix: -fasta
  - id: first_nucleotide
    type:
      - 'null'
      - int
    doc: first nucleotide to be analyzed
    inputBinding:
      position: 102
      prefix: -f
  - id: first_second_pos_only
    type:
      - 'null'
      - boolean
    doc: first and second positions only
    inputBinding:
      position: 102
      prefix: -12po
  - id: id_auto
    type:
      - 'null'
      - boolean
    doc: automatically give a unique identifier for this run based on the 
      run-time
    inputBinding:
      position: 102
      prefix: -id-auto
  - id: iterations
    type:
      - 'null'
      - int
    doc: specify the number of iterations of the recombination analysis
    inputBinding:
      position: 102
      prefix: -n
  - id: last_nucleotide
    type:
      - 'null'
      - int
    doc: last nucleotide to be analyzed
    inputBinding:
      position: 102
      prefix: -l
  - id: min_length
    type:
      - 'null'
      - int
    doc: set the minimum length to count a segment as recombinant
    inputBinding:
      position: 102
      prefix: -L
  - id: nexus_output
    type:
      - 'null'
      - boolean
    doc: format output as NEXUS (used in write mode only)
    inputBinding:
      position: 102
      prefix: -nexus
  - id: ptable_file
    type:
      - 'null'
      - File
    doc: specify the ptable file to use
    inputBinding:
      position: 102
      prefix: -ptable
  - id: random_subsample
    type:
      - 'null'
      - int
    doc: specify the number of random child sequences to be sub-sampled
    inputBinding:
      position: 102
      prefix: -rand
  - id: record_skipped
    type:
      - 'null'
      - boolean
    doc: record skipped computation to file '3s.skipped'
    inputBinding:
      position: 102
      prefix: -r
  - id: rejection_threshold
    type:
      - 'null'
      - float
    doc: rejection threshold (e.g., -t0.01)
    inputBinding:
      position: 102
      prefix: -t
  - id: run_id
    type:
      - 'null'
      - string
    doc: give unique identifier for this run to prefix output files
    inputBinding:
      position: 102
      prefix: -id
  - id: run_mode
    type:
      - 'null'
      - boolean
    doc: Full recombination analysis mode (most common usage)
    inputBinding:
      position: 102
      prefix: -full
  - id: subset_file
    type:
      - 'null'
      - File
    doc: designate subset of sequences to be analyzed
    inputBinding:
      position: 102
      prefix: -subset
  - id: subset_remove
    type:
      - 'null'
      - File
    doc: sequences in the subset file are removed from the dataset
    inputBinding:
      position: 102
      prefix: -subset-remove
  - id: suppress_csv
    type:
      - 'null'
      - boolean
    doc: suppress writing to '3s.rec.csv' file
    inputBinding:
      position: 102
      prefix: -nr
  - id: suppress_hogan_siegmund
    type:
      - 'null'
      - boolean
    doc: suppress using Hogan-Siegmund approximations
    inputBinding:
      position: 102
      prefix: -nohs
  - id: third_pos_only
    type:
      - 'null'
      - boolean
    doc: third positions only
    inputBinding:
      position: 102
      prefix: -3po
  - id: yes_no_mode
    type:
      - 'null'
      - boolean
    doc: algorithm stops once a significant triple has been found
    inputBinding:
      position: 102
      prefix: -y
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/3seq:1.8--h9948957_6
stdout: 3seq.out
