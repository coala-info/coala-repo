cwlVersion: v1.2
class: CommandLineTool
baseCommand: meryl
label: meryl_count-forward
doc: "Count the occurrences of forward kmers in the input.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: input_file
    type: File
    doc: Input file for counting
    inputBinding:
      position: 1
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress homopolymer runs to a single letter.
    inputBinding:
      position: 102
  - id: decrease
    type:
      - 'null'
      - string
    doc: subtract X from the count of each kmer.
    inputBinding:
      position: 102
  - id: difference
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in the first input, but none of the other 
      inputs
    inputBinding:
      position: 102
  - id: divide
    type:
      - 'null'
      - string
    doc: divide the count of each kmer by X.
    inputBinding:
      position: 102
  - id: divide_round
    type:
      - 'null'
      - string
    doc: divide the count of each kmer by X and round results. count < X will 
      become 1.
    inputBinding:
      position: 102
  - id: equal_to
    type:
      - 'null'
      - int
    doc: return kmers that occur exactly N times in the input. accepts exactly 
      one input.
    inputBinding:
      position: 102
  - id: greater_than
    type:
      - 'null'
      - int
    doc: return kmers that occur more than N times in the input. accepts exactly
      one input.
    inputBinding:
      position: 102
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: display kmer frequency on the screen as 'frequency<tab>count'. accepts 
      exactly one input.
    inputBinding:
      position: 102
  - id: increase
    type:
      - 'null'
      - string
    doc: add X to the count of each kmer.
    inputBinding:
      position: 102
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the count in 
      the first input.
    inputBinding:
      position: 102
  - id: intersect_max
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the maximum 
      count.
    inputBinding:
      position: 102
  - id: intersect_min
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the minimum 
      count.
    inputBinding:
      position: 102
  - id: intersect_sum
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in all inputs, set the count to the sum of the 
      counts.
    inputBinding:
      position: 102
  - id: k
    type: int
    doc: create mers of size K bases (mandatory).
    inputBinding:
      position: 102
  - id: less_than
    type:
      - 'null'
      - int
    doc: return kmers that occur fewer than N times in the input. accepts 
      exactly one input.
    inputBinding:
      position: 102
  - id: memory
    type:
      - 'null'
      - string
    doc: use no more than (about) M GB memory.
    inputBinding:
      position: 102
  - id: modulo
    type:
      - 'null'
      - string
    doc: set the count of each kmer to the remainder of the count divided by X.
    inputBinding:
      position: 102
  - id: multiply
    type:
      - 'null'
      - string
    doc: multiply the count of each kmer by X.
    inputBinding:
      position: 102
  - id: n
    type:
      - 'null'
      - int
    doc: expect N mers in the input (optional; for precise memory sizing).
    inputBinding:
      position: 102
  - id: not_equal_to
    type:
      - 'null'
      - int
    doc: return kmers that do not occur exactly N times in the input. accepts 
      exactly one input.
    inputBinding:
      position: 102
  - id: print
    type:
      - 'null'
      - boolean
    doc: display kmers on the screen as 'kmer<tab>count'. accepts exactly one 
      input.
    inputBinding:
      position: 102
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: display total, unique, distinct, present number of the kmers on the 
      screen. accepts exactly one input.
    inputBinding:
      position: 102
  - id: subtract
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in the first input, substracting counts from 
      the other inputs
    inputBinding:
      position: 102
  - id: symmetric_difference
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in exactly one input
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: use no more than T threads.
    inputBinding:
      position: 102
  - id: union
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the number of 
      inputs with this kmer.
    inputBinding:
      position: 102
  - id: union_max
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the maximum 
      count
    inputBinding:
      position: 102
  - id: union_min
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the minimum 
      count
    inputBinding:
      position: 102
  - id: union_sum
    type:
      - 'null'
      - boolean
    doc: return kmers that occur in any input, set the count to the sum of the 
      counts
    inputBinding:
      position: 102
outputs:
  - id: output
    type: File
    doc: "write kmers generated by the present command to an output meryl database
      O\nmandatory for count operations."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2
