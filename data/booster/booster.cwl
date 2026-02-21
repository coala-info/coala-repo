cwlVersion: v1.2
class: CommandLineTool
baseCommand: booster
label: booster
doc: "Renewing Felsenstein's Phylogenetic Bootstrap in the Era of Big Data. Computes
  normalized or raw support values for phylogenetic trees.\n\nTool homepage: https://github.com/evolbioinfo/booster"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: tbe or fbp
    default: tbe
    inputBinding:
      position: 101
      prefix: --algo
  - id: bootstrap_tree
    type: File
    doc: Bootstrap tree file (1 file containing all bootstrap trees)
    inputBinding:
      position: 101
      prefix: --boot
  - id: count_per_branch
    type:
      - 'null'
      - boolean
    doc: Prints individual taxa moves for each branches in the log file (only with
      -S & -a tbe)
    inputBinding:
      position: 101
      prefix: --count-per-branch
  - id: dist_cutoff
    type:
      - 'null'
      - float
    doc: Distance cutoff to consider a branch for taxa transfer index computation
      (-a tbe only)
    default: 0.3
    inputBinding:
      position: 101
      prefix: --dist-cutoff
  - id: input_tree
    type: File
    doc: Input tree file (newick)
    inputBinding:
      position: 101
      prefix: --input
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress messages during analysis
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file with normalized support values
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_raw
    type:
      - 'null'
      - File
    doc: Output file with raw support values in the form of id|avgdist|depth
    outputBinding:
      glob: $(inputs.output_raw)
  - id: stat_file
    type:
      - 'null'
      - File
    doc: Prints output statistics for each branch in the given output file
    outputBinding:
      glob: $(inputs.stat_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/booster:0.1.2--hec16e2b_4
