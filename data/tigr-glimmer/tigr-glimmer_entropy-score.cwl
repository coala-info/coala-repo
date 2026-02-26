cwlVersion: v1.2
class: CommandLineTool
baseCommand: entropy-score
label: tigr-glimmer_entropy-score
doc: Read fasta-format <sequence-file> and then score regions in it specified by
  <coords>. By default, <coords> is the name of a file containing lines of the 
  form <tag> <start> <stop> [<frame>] ... Coordinates are inclusive counting 
  from 1, e.g., "1 3" represents the 1st 3 characters of the sequence. Output is
  the same format as <coords> put with the entropy distance score appended to 
  each line Output goes to stdout.
inputs:
  - id: sequence_file
    type: File
    doc: Fasta-format sequence file
    inputBinding:
      position: 1
  - id: coords
    type: File
    doc: File containing regions to score
    inputBinding:
      position: 2
  - id: entropy_profile_file
    type:
      - 'null'
      - File
    doc: Read entropy profiles from <filename>. Format is one header line, then 
      20 lines of 3 columns each. Columns are amino acid, positive entropy, 
      negative entropy. Rows must be in order by amino acid code letter
    inputBinding:
      position: 103
      prefix: --entropy
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: Don't output any sequence shorter than <n> characters
    inputBinding:
      position: 103
      prefix: --minlen
  - id: no_wrap
    type:
      - 'null'
      - boolean
    doc: Use the actual input coordinates without any wraparound that would be 
      needed by a circular genome. Without this option, the output sequence is 
      the shorter of the two ways around the circle. Use the -d option to 
      specify direction explicitly.
    inputBinding:
      position: 103
      prefix: --nowrap
  - id: omit_start_chars
    type:
      - 'null'
      - boolean
    doc: Omit the first 3 characters of each specified string
    inputBinding:
      position: 103
      prefix: --nostart
  - id: omit_stop_chars
    type:
      - 'null'
      - boolean
    doc: Omit the last 3 characters of each specified string
    inputBinding:
      position: 103
      prefix: --nostop
  - id: use_direction
    type:
      - 'null'
      - boolean
    doc: Use the 4th column of each input line to specify the direction of the 
      sequence. Positive is forward, negative is reverse. The input sequence is 
      assumed to be circular
    inputBinding:
      position: 103
      prefix: --dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_entropy-score.out
