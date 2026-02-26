cwlVersion: v1.2
class: CommandLineTool
baseCommand: uncovered
label: tigr-glimmer_uncovered
doc: Read fasta-format <sequence-file> and extract from it the subsequences not 
  covered by regions specified in <coords>.
inputs:
  - id: sequence_file
    type: File
    doc: Fasta-format sequence file
    inputBinding:
      position: 1
  - id: coords
    type: File
    doc: File containing regions not to extract
    inputBinding:
      position: 2
  - id: direction
    type:
      - 'null'
      - boolean
    doc: Use the 4th column of each input line to specify the direction of the 
      sequence. Positive is forward, negative is reverse. The input sequence is 
      assumed to be circular
    inputBinding:
      position: 103
      prefix: --dir
  - id: min_length
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
  - id: omit_start
    type:
      - 'null'
      - boolean
    doc: Omit the first 3 characters of each <coords> region
    inputBinding:
      position: 103
      prefix: --nostart
  - id: omit_stop
    type:
      - 'null'
      - boolean
    doc: Omit the last 3 characters of each <coords> region
    inputBinding:
      position: 103
      prefix: --nostop
  - id: two_fields
    type:
      - 'null'
      - boolean
    doc: Output each sequence as 2 fields (tag and sequence) on a single line
    inputBinding:
      position: 103
      prefix: '-2'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_uncovered.out
