cwlVersion: v1.2
class: CommandLineTool
baseCommand: leaff
label: leaff
doc: "leaff is a tool for manipulating and analyzing sequence data from FASTA files.\n\
  \nTool homepage: https://github.com/alexjbest/leaff"
inputs:
  - id: actions_file
    type:
      - 'null'
      - File
    doc: read actions from 'file'
    inputBinding:
      position: 101
      prefix: -A
  - id: complement
    type:
      - 'null'
      - boolean
    doc: complement the sequences
    inputBinding:
      position: 101
      prefix: -C
  - id: defline_word
    type:
      - 'null'
      - string
    doc: Use the next word as the defline ("-H -H" will reset to the original 
      defline)
    inputBinding:
      position: 101
      prefix: -h
  - id: ends_bases
    type:
      - 'null'
      - int
    doc: Print n bases from each end of the sequence. One input sequence 
      generates two output sequences, with '_5' or '_3' appended to the ID. If 
      2n >= length of the sequence, the sequence itself is printed, no ends are 
      extracted (they overlap).
    inputBinding:
      position: 101
      prefix: -ends
  - id: extract_beg
    type:
      - 'null'
      - int
    doc: Print only the bases from position 'beg' to position 'end' (space 
      based, relative to the FORWARD sequence!)
    inputBinding:
      position: 101
      prefix: -e
  - id: extract_end
    type:
      - 'null'
      - int
    doc: Print only the bases from position 'beg' to position 'end' (space 
      based, relative to the FORWARD sequence!)
    inputBinding:
      position: 101
      prefix: -e
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: use sequence in 'file'
    inputBinding:
      position: 101
      prefix: -f
  - id: help_topic
    type:
      - 'null'
      - string
    doc: analysis or examples
    inputBinding:
      position: 101
      prefix: -help
  - id: index_name
    type:
      - 'null'
      - string
    doc: print an index, labelling the source 'name'
    inputBinding:
      position: 101
      prefix: -i
  - id: length_range_max
    type:
      - 'null'
      - int
    doc: print all sequences such that s <= length < l
    inputBinding:
      position: 101
      prefix: -L
  - id: length_range_min
    type:
      - 'null'
      - int
    doc: print all sequences such that s <= length < l
    inputBinding:
      position: 101
      prefix: -L
  - id: line_break_interval
    type:
      - 'null'
      - int
    doc: insert a newline every 60 letters (if the next arg is a number, 
      newlines are inserted every n letters, e.g., -6 80. Disable line breaks 
      with -6 0, or just don't use -6!)
    inputBinding:
      position: 101
      prefix: '-6'
  - id: n_composition_max
    type:
      - 'null'
      - float
    doc: print all sequences such that l <= % N composition < h (NOTE 0.0 <= l <
      h < 100.0)
    inputBinding:
      position: 101
      prefix: -N
  - id: n_composition_min
    type:
      - 'null'
      - float
    doc: print all sequences such that l <= % N composition < h (NOTE 0.0 <= l <
      h < 100.0)
    inputBinding:
      position: 101
      prefix: -N
  - id: no_defline
    type:
      - 'null'
      - boolean
    doc: DON'T print the defline
    inputBinding:
      position: 101
      prefix: -H
  - id: print_all_sequences
    type:
      - 'null'
      - boolean
    doc: print all sequences (do the whole file)
    inputBinding:
      position: 101
      prefix: -W
  - id: print_sequence_count
    type:
      - 'null'
      - boolean
    doc: print the number of sequences in the fasta
    inputBinding:
      position: 101
      prefix: -d
  - id: random_pick_num
    type:
      - 'null'
      - int
    doc: print 'num' randomly picked sequences
    inputBinding:
      position: 101
      prefix: -r
  - id: random_sequences_count
    type:
      - 'null'
      - int
    doc: print n randomly generated sequences, 0 < s <= length <= l
    inputBinding:
      position: 101
      prefix: -G
  - id: random_sequences_max_len
    type:
      - 'null'
      - int
    doc: print n randomly generated sequences, 0 < s <= length <= l
    inputBinding:
      position: 101
      prefix: -G
  - id: random_sequences_min_len
    type:
      - 'null'
      - int
    doc: print n randomly generated sequences, 0 < s <= length <= l
    inputBinding:
      position: 101
      prefix: -G
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse the sequences
    inputBinding:
      position: 101
      prefix: -R
  - id: seqid_list_file
    type:
      - 'null'
      - File
    doc: print sequences from the seqid list in 'file'
    inputBinding:
      position: 101
      prefix: -q
  - id: seqid_range_end
    type:
      - 'null'
      - string
    doc: print all the sequences from ID 'f' to 'l' (inclusive)
    inputBinding:
      position: 101
      prefix: -S
  - id: seqid_range_start
    type:
      - 'null'
      - string
    doc: print all the sequences from ID 'f' to 'l' (inclusive)
    inputBinding:
      position: 101
      prefix: -S
  - id: single_seqid
    type:
      - 'null'
      - string
    doc: print the single sequence 'seqid'
    inputBinding:
      position: 101
      prefix: -s
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: uppercase all bases
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/leaff:v020150903r2013-6-deb_cv1
stdout: leaff.out
