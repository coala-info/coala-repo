cwlVersion: v1.2
class: CommandLineTool
baseCommand: sim4db
label: sim4db
doc: sim4db
inputs:
  - id: alignments
    type:
      - 'null'
      - boolean
    doc: print alignments
    inputBinding:
      position: 101
      prefix: -alignments
  - id: always_report
    type:
      - 'null'
      - int
    doc: always report <number> exon models, even if they are below the quality 
      thresholds
    inputBinding:
      position: 101
      prefix: -alwaysreport
  - id: cdna_fasta
    type: File
    doc: use these cDNA sequences
    inputBinding:
      position: 101
      prefix: -cdna
  - id: cut
    type:
      - 'null'
      - float
    doc: Trim marginal exons if A/T % > x (poly-AT tails)
    inputBinding:
      position: 101
      prefix: -cut
  - id: first_msp_threshold
    type:
      - 'null'
      - float
    doc: set the first MSP threshold
    inputBinding:
      position: 101
      prefix: -K
  - id: force_strand
    type:
      - 'null'
      - string
    doc: Force the strand prediction to always be 'forward' or 'reverse'
    inputBinding:
      position: 101
      prefix: -forcestrand
  - id: genomic_fasta
    type: File
    doc: use these genomic sequences
    inputBinding:
      position: 101
      prefix: -genomic
  - id: interspecies
    type:
      - 'null'
      - boolean
    doc: Use sim4cc for inter-species alignments
    inputBinding:
      position: 101
      prefix: -interspecies
  - id: max_msps
    type:
      - 'null'
      - int
    doc: set the limit of the number of MSPs allowed
    inputBinding:
      position: 101
      prefix: -Ma
  - id: max_msps_percentage
    type:
      - 'null'
      - float
    doc: same, as percentage of bases in cDNA
    inputBinding:
      position: 101
      prefix: -Mp
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: iteratively find all exon models with the specified minimum PERCENT 
      COVERAGE
    inputBinding:
      position: 101
      prefix: -mincoverage
  - id: min_identity
    type:
      - 'null'
      - float
    doc: iteratively find all exon models with the specified minimum PERCENT 
      EXON IDENTITY
    inputBinding:
      position: 101
      prefix: -minidentity
  - id: min_length
    type:
      - 'null'
      - int
    doc: iteratively find all exon models with the specified minimum ABSOLUTE 
      COVERAGE (number of bp matched)
    inputBinding:
      position: 101
      prefix: -minlength
  - id: no_def_lines
    type:
      - 'null'
      - boolean
    doc: don't include the defline in the output
    inputBinding:
      position: 101
      prefix: -nodeflines
  - id: noncanonical
    type:
      - 'null'
      - boolean
    doc: Don't force canonical splice sites
    inputBinding:
      position: 101
      prefix: -noncanonical
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: do pairs of sequences
    inputBinding:
      position: 101
      prefix: -pairwise
  - id: poly_tails
    type:
      - 'null'
      - boolean
    doc: DON'T mask poly-A and poly-T tails.
    inputBinding:
      position: 101
      prefix: -polytails
  - id: print_script_lines_annotated
    type:
      - 'null'
      - boolean
    doc: print script lines (to given file) as they are processed, annotated 
      with yes/no
    inputBinding:
      position: 101
      prefix: -YN
  - id: print_script_lines_stderr
    type:
      - 'null'
      - boolean
    doc: print script lines (stderr) as they are processed
    inputBinding:
      position: 101
      prefix: -V
  - id: relink_weight_factor
    type:
      - 'null'
      - float
    doc: set the relink weight factor
    inputBinding:
      position: 101
      prefix: -H
  - id: script_file
    type:
      - 'null'
      - File
    doc: use this script file
    inputBinding:
      position: 101
      prefix: -script
  - id: second_msp_threshold
    type:
      - 'null'
      - float
    doc: set the second MSP threshold
    inputBinding:
      position: 101
      prefix: -C
  - id: seed_pattern
    type:
      - 'null'
      - string
    doc: set the (spaced) seed pattern
    inputBinding:
      position: 101
      prefix: -Z
  - id: splice_model
    type:
      - 'null'
      - int
    doc: 'Use the following splice model: 0 - original sim4; 1 - GeneSplicer; 2 -
      Glimmer (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: -splicemodel
  - id: threads
    type:
      - 'null'
      - int
    doc: Use n threads.
    inputBinding:
      position: 101
      prefix: -threads
  - id: touch_file
    type:
      - 'null'
      - File
    doc: create this file when the program finishes execution
    inputBinding:
      position: 101
      prefix: -touch
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print status to stderr while running
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_sim4db
    type: File
    doc: write output to this file
    outputBinding:
      glob: $(inputs.output_sim4db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sim4db:2008--pl5321h609437b_2
