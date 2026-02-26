cwlVersion: v1.2
class: CommandLineTool
baseCommand: multi-extract
label: tigr-glimmer_multi-extract
doc: Read multi-fasta-format <sequence-file> and extract from it the 
  subsequences specified by <coords>
inputs:
  - id: sequence_file
    type: File
    doc: multi-fasta-format sequence file
    inputBinding:
      position: 1
  - id: coords
    type: File
    doc: File containing lines of the form <id> <tag> <start> <stop> [<frame>] 
      ... or '-' for standard input
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
  - id: min_len
    type:
      - 'null'
      - int
    doc: Don't output any sequence shorter than <n> characters
    inputBinding:
      position: 103
      prefix: --minlen
  - id: no_start
    type:
      - 'null'
      - boolean
    doc: Omit the first 3 characters of each output string
    inputBinding:
      position: 103
      prefix: --nostart
  - id: no_stop
    type:
      - 'null'
      - boolean
    doc: Omit the last 3 characters of each output string
    inputBinding:
      position: 103
      prefix: --nostop
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
  - id: two_fields
    type:
      - 'null'
      - boolean
    doc: Output each sequence as 2 fields (tag and sequence) on a single line
    inputBinding:
      position: 103
      prefix: --2_fields
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_multi-extract.out
