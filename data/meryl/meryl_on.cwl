cwlVersion: v1.2
class: CommandLineTool
baseCommand: meryl
label: meryl_on
doc: "A meryl command line is formed as a series of commands and files, possibly grouped
  using square brackets. Each command operates on the file(s) that are listed after
  it.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: command
    type: string
    doc: The meryl command to execute (e.g., statistics, histogram, print, 
      count, less-than, union, intersect, etc.)
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments specific to the chosen command (e.g., N for less-than N, X 
      for increase X, etc.)
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the command. For some commands, this can be a meryl 
      database.
    inputBinding:
      position: 3
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress homopolymer runs to a single letter.
    inputBinding:
      position: 104
      prefix: compress
  - id: decrease
    type:
      - 'null'
      - string
    doc: subtract X from the count of each kmer.
    inputBinding:
      position: 104
      prefix: decrease
  - id: difference
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in the first input, but none of the other 
      inputs
    inputBinding:
      position: 104
      prefix: difference
  - id: divide
    type:
      - 'null'
      - string
    doc: divide the count of each kmer by X.
    inputBinding:
      position: 104
      prefix: divide
  - id: divide_round
    type:
      - 'null'
      - string
    doc: divide the count of each kmer by X and round results. count < X will 
      become 1.
    inputBinding:
      position: 104
      prefix: divide-round
  - id: equal_to
    type:
      - 'null'
      - int
    doc: return kmers that occur exactly N times in the input.
    inputBinding:
      position: 104
      prefix: equal-to
  - id: greater_than
    type:
      - 'null'
      - int
    doc: return kmers that occur more than N times in the input.
    inputBinding:
      position: 104
      prefix: greater-than
  - id: increase
    type:
      - 'null'
      - string
    doc: add X to the count of each kmer.
    inputBinding:
      position: 104
      prefix: increase
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the count in 
      the first input.
    inputBinding:
      position: 104
      prefix: intersect
  - id: intersect_max
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the maximum 
      count.
    inputBinding:
      position: 104
      prefix: intersect-max
  - id: intersect_min
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the minimum 
      count.
    inputBinding:
      position: 104
      prefix: intersect-min
  - id: intersect_sum
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the sum of the 
      counts.
    inputBinding:
      position: 104
      prefix: intersect-sum
  - id: k
    type: int
    doc: create mers of size K bases (mandatory for count operations).
    inputBinding:
      position: 104
      prefix: k
  - id: less_than
    type:
      - 'null'
      - int
    doc: return kmers that occur fewer than N times in the input.
    inputBinding:
      position: 104
      prefix: less-than
  - id: memory
    type:
      - 'null'
      - string
    doc: use no more than (about) M GB memory.
    inputBinding:
      position: 104
      prefix: memory
  - id: modulo
    type:
      - 'null'
      - string
    doc: set the count of each kmer to the remainder of the count divided by X.
    inputBinding:
      position: 104
      prefix: modulo
  - id: multiply
    type:
      - 'null'
      - string
    doc: multiply the count of each kmer by X.
    inputBinding:
      position: 104
      prefix: multiply
  - id: n
    type:
      - 'null'
      - int
    doc: expect N mers in the input (optional; for precise memory sizing).
    inputBinding:
      position: 104
      prefix: n
  - id: not_equal_to
    type:
      - 'null'
      - int
    doc: return kmers that do not occur exactly N times in the input.
    inputBinding:
      position: 104
      prefix: not-equal-to
  - id: subtract
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in the first input, substracting counts from 
      the other inputs
    inputBinding:
      position: 104
      prefix: subtract
  - id: symmetric_difference
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in exactly one input
    inputBinding:
      position: 104
      prefix: symmetric-difference
  - id: threads
    type:
      - 'null'
      - int
    doc: use no more than T threads.
    inputBinding:
      position: 104
      prefix: threads
  - id: union
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the number of 
      inputs with this kmer.
    inputBinding:
      position: 104
      prefix: union
  - id: union_max
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the maximum 
      count
    inputBinding:
      position: 104
      prefix: union-max
  - id: union_min
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the minimum 
      count
    inputBinding:
      position: 104
      prefix: union-min
  - id: union_sum
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the sum of the 
      counts
    inputBinding:
      position: 104
      prefix: union-sum
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: write kmers generated by the present command to an output meryl 
      database O. mandatory for count operations.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2
