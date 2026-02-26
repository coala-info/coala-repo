cwlVersion: v1.2
class: CommandLineTool
baseCommand: metilene
label: metilene
doc: "metilene - a tool for fast and sensitive detection of differential DNA methylation\n\
  \nTool homepage: http://www.bioinf.uni-leipzig.de/Software/metilene"
inputs:
  - id: data_input_file
    type: File
    doc: DataInputFile needs to be SORTED for chromosomes and genomic positions
    inputBinding:
      position: 1
  - id: bed_file
    type:
      - 'null'
      - File
    doc: bed-file for mode 2 containing pre-defined regions; needs to be SORTED 
      equally to the DataInputFile
    inputBinding:
      position: 102
      prefix: --bed
  - id: group_a
    type:
      - 'null'
      - string
    doc: name of group A
    default: g1
    inputBinding:
      position: 102
      prefix: --groupA
  - id: group_b
    type:
      - 'null'
      - string
    doc: name of group B
    default: g2
    inputBinding:
      position: 102
      prefix: --groupB
  - id: max_distance
    type:
      - 'null'
      - int
    doc: maximum distance
    default: 300
    inputBinding:
      position: 102
      prefix: --maxdist
  - id: max_segment_length
    type:
      - 'null'
      - int
    doc: maximum segment length in case of memory issues
    default: -1
    inputBinding:
      position: 102
      prefix: --maxseg
  - id: min_cpgs
    type:
      - 'null'
      - int
    doc: minimum cpgs
    default: 10
    inputBinding:
      position: 102
      prefix: --mincpgs
  - id: min_meth_diff
    type:
      - 'null'
      - float
    doc: minimum mean methylation difference
    default: 0.1
    inputBinding:
      position: 102
      prefix: --minMethDiff
  - id: min_no_a
    type:
      - 'null'
      - int
    doc: minimal number of values in group A
    default: -1
    inputBinding:
      position: 102
      prefix: --minNoA
  - id: min_no_b
    type:
      - 'null'
      - int
    doc: minimal number of values in group B
    default: -1
    inputBinding:
      position: 102
      prefix: --minNoB
  - id: mode
    type:
      - 'null'
      - int
    doc: 'number of method: 1: de-novo, 2: pre-defined regions, 3: DMCs'
    default: 1
    inputBinding:
      position: 102
      prefix: --mode
  - id: mtc
    type:
      - 'null'
      - int
    doc: 'method of multiple testing correction: 1: Bonferroni, 2: Benjamini-Hochberg
      (FDR)'
    default: 1
    inputBinding:
      position: 102
      prefix: --mtc
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for random generator
    default: 26061981
    inputBinding:
      position: 102
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: valley
    type:
      - 'null'
      - float
    doc: valley filter (0.0 - 1.0)
    default: 0.7
    inputBinding:
      position: 102
      prefix: --valley
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0
stdout: metilene.out
