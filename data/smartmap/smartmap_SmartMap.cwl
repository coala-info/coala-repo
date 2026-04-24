cwlVersion: v1.2
class: CommandLineTool
baseCommand: SmartMap
label: smartmap_SmartMap
doc: "SmartMap for analysis of ambiguously mapping reads in next-generation sequencing.\n\
  \nTool homepage: http://shah-rohan.github.io/SmartMap"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: bed or bed.gz file input(s)
    inputBinding:
      position: 1
  - id: continuous_output
    type:
      - 'null'
      - boolean
    doc: Flag for continuous output bedgraphs. Default off.
    inputBinding:
      position: 102
      prefix: -c
  - id: cross_validation_folds
    type:
      - 'null'
      - int
    doc: N for N-fold cross-validation. Default 1 (no cross-validation).
    inputBinding:
      position: 102
      prefix: -v
  - id: genome_length_file
    type: File
    doc: Genome length file listing all chromosomes and lengths. Chromosomes 
      will appear in this order in output file.
    inputBinding:
      position: 102
      prefix: -g
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations.
    inputBinding:
      position: 102
      prefix: -i
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of alignments for a read to be processed.
    inputBinding:
      position: 102
      prefix: -m
  - id: min_bowtie2_score
    type:
      - 'null'
      - int
    doc: Minimum score for Bowtie2 display. Default 0 (unscored).
    inputBinding:
      position: 102
      prefix: -s
  - id: output_prefix
    type: string
    doc: Output prefix used for output bedgraph and log files.
    inputBinding:
      position: 102
      prefix: -o
  - id: read_output_weighted
    type:
      - 'null'
      - boolean
    doc: Flag for read output mode with weights. Default off.
    inputBinding:
      position: 102
      prefix: -r
  - id: reweighting_fit_rate
    type:
      - 'null'
      - float
    doc: Rate of fitting in reweighting. Default 1.
    inputBinding:
      position: 102
      prefix: -l
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Flag for strand-specific mode. Default off.
    inputBinding:
      position: 102
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
stdout: smartmap_SmartMap.out
