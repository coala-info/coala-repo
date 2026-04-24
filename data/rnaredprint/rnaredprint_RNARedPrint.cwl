cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/../share/RNARedPrint/RNARedPrint
label: rnaredprint_RNARedPrint
doc: "Generates valid designs for the RNA secondary structures from the weighted distribution\n\
  \nTool homepage: https://github.com/yannponty/RNARedPrint"
inputs:
  - id: struct1
    type: string
    doc: Target structure 1
    inputBinding:
      position: 1
  - id: struct2
    type: string
    doc: Target structure 2
    inputBinding:
      position: 2
  - id: additional_structures
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional target structures
    inputBinding:
      position: 3
  - id: compute_partition_function
    type:
      - 'null'
      - boolean
    doc: Simply compute the partition function and report the result.
    inputBinding:
      position: 104
      prefix: --count
  - id: custom_weights
    type:
      - 'null'
      - string
    doc: Assigns custom weights to each targeted structure
    inputBinding:
      position: 104
      prefix: --weights
  - id: energy_model
    type:
      - 'null'
      - int
    doc: Set energy model used for stochastic sampling
    inputBinding:
      position: 104
      prefix: --model
  - id: gc_weight
    type:
      - 'null'
      - float
    doc: Assigns custom weight to each occurrence of GC, to control GC%
    inputBinding:
      position: 104
      prefix: --gcw
  - id: num_sequences
    type:
      - 'null'
      - int
    doc: Sets number of generated sequences
    inputBinding:
      position: 104
      prefix: --num
  - id: prefix_path
    type:
      - 'null'
      - boolean
    doc: Prefix path for locating the TD libraries
    inputBinding:
      position: 104
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaredprint:0.3--h9948957_2
stdout: rnaredprint_RNARedPrint.out
