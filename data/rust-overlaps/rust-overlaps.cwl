cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-overlaps
label: rust-overlaps
doc: "Finds approximate suffix prefix overlaps from a given fasta file\n\nTool homepage:
  https://github.com/jbaaijens/rust-overlaps"
inputs:
  - id: in_path
    type: File
    doc: Path to the input fasta file
    inputBinding:
      position: 1
  - id: err_rate
    type: float
    doc: The max rate of errors in an overlap
    inputBinding:
      position: 2
  - id: thresh
    type: int
    doc: Shortest allowed length of an overlap
    inputBinding:
      position: 3
  - id: edit_distance
    type:
      - 'null'
      - boolean
    doc: Uses Levenshtein / edit distance instead of Hamming distance
    inputBinding:
      position: 104
      prefix: --edit_distance
  - id: format_line
    type:
      - 'null'
      - boolean
    doc: The first line of the output file will contain a TSV header line.
    inputBinding:
      position: 104
      prefix: --format_line
  - id: greedy_output
    type:
      - 'null'
      - boolean
    doc: Threads print solutions to output greedily instead of storing them. 
      Limited duplication may arise
    inputBinding:
      position: 104
      prefix: --greedy_output
  - id: inclusions
    type:
      - 'null'
      - boolean
    doc: Enables finding of inclusion overlaps (one string within another)
    inputBinding:
      position: 104
      prefix: --inclusions
  - id: mode
    type:
      - 'null'
      - string
    doc: Uses the filtering scheme mode given options {valimaki, kucherov}. 
      Modes can also be supplied string arguments i.e. 'kucherov_2'.
    inputBinding:
      position: 104
      prefix: --mode
  - id: no_n
    type:
      - 'null'
      - boolean
    doc: Omits N symbol from alphabet saving time. Will remove N symbols from 
      input file (with a warning)
    inputBinding:
      position: 104
      prefix: --no_n
  - id: print
    type:
      - 'null'
      - boolean
    doc: For each solution printed to file, also prints a rough visualization to
      stdout (mostly for debugging purposes)
    inputBinding:
      position: 104
      prefix: --print
  - id: reversals
    type:
      - 'null'
      - boolean
    doc: Enables reversals of input strings
    inputBinding:
      position: 104
      prefix: --reversals
  - id: track_progress
    type:
      - 'null'
      - boolean
    doc: Prints progress bar for completed tasks and ETA to stdout
    inputBinding:
      position: 104
      prefix: --track_progress
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints completed steps of the run process
    inputBinding:
      position: 104
      prefix: --verbose
  - id: worker_threads
    type:
      - 'null'
      - int
    doc: Number of worker threads used. Defaults to number of logical cpu cores
    inputBinding:
      position: 104
      prefix: --worker_threads
outputs:
  - id: out_path
    type: File
    doc: Path of desired output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-overlaps:0.1.1--h577a1d6_10
