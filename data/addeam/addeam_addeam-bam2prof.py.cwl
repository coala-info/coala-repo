cwlVersion: v1.2
class: CommandLineTool
baseCommand: addeam-bam2prof.py
label: addeam_addeam-bam2prof.py
doc: "Python wrapper for bam2prof\n\nTool homepage: https://github.com/LouisPwr/AdDeam"
inputs:
  - id: bam_files
    type:
      - 'null'
      - File
    doc: File with paths to BAM files; one per line.
    inputBinding:
      position: 1
  - id: bam2prof_path
    type:
      - 'null'
      - File
    doc: Provide absolute path to bam2prof binary and use it for execution
    inputBinding:
      position: 102
      prefix: -bam2profpath
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file for positions
    inputBinding:
      position: 102
      prefix: -bed
  - id: both
    type:
      - 'null'
      - boolean
    doc: Report both C->T and G->A
    default: false
    inputBinding:
      position: 102
      prefix: -both
  - id: classic
    type:
      - 'null'
      - boolean
    doc: One Profile per bam file
    default: false
    inputBinding:
      position: 102
      prefix: -classic
  - id: damage_patterns_format
    type:
      - 'null'
      - boolean
    doc: Output in damage-patterns format
    default: false
    inputBinding:
      position: 102
      prefix: -dp
  - id: double_strand
    type:
      - 'null'
      - boolean
    doc: Double strand library
    default: false
    inputBinding:
      position: 102
      prefix: -double
  - id: endo
    type:
      - 'null'
      - int
    doc: Endo flag
    default: 0
    inputBinding:
      position: 102
      prefix: -endo
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate
    default: 0
    inputBinding:
      position: 102
      prefix: -err
  - id: length
    type:
      - 'null'
      - int
    doc: Length
    default: 5
    inputBinding:
      position: 102
      prefix: -length
  - id: logarithmic_scale
    type:
      - 'null'
      - boolean
    doc: Logarithmic scale
    default: false
    inputBinding:
      position: 102
      prefix: -log
  - id: mask_file
    type:
      - 'null'
      - File
    doc: BED file for mask positions
    inputBinding:
      position: 102
      prefix: -mask
  - id: meta
    type:
      - 'null'
      - boolean
    doc: One Profile per unique reference
    default: false
    inputBinding:
      position: 102
      prefix: -meta
  - id: min_aligned
    type:
      - 'null'
      - int
    doc: Number of aligned sequences after which substitution patterns are 
      checked if frequencies converge
    default: 10000000
    inputBinding:
      position: 102
      prefix: -minAligned
  - id: min_converge
    type:
      - 'null'
      - float
    doc: Set minimum threshold for substitution frequency convergence
    default: 0.01
    inputBinding:
      position: 102
      prefix: -minConverge
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum fragment/read length
    default: 35
    inputBinding:
      position: 102
      prefix: -minl
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    default: 0
    inputBinding:
      position: 102
      prefix: -minq
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Allow paired reads
    default: false
    inputBinding:
      position: 102
      prefix: -paired
  - id: precision
    type:
      - 'null'
      - float
    doc: Set minimum decimal precision for substitution frequency computation
    default: 0
    inputBinding:
      position: 102
      prefix: -precision
  - id: quiet
    type:
      - 'null'
      - int
    doc: Do not print why reads are skipped
    default: 1
    inputBinding:
      position: 102
      prefix: -q
  - id: ref_id
    type:
      - 'null'
      - string
    doc: Specify reference ID
    inputBinding:
      position: 102
      prefix: -ref-id
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Single strand library
    default: false
    inputBinding:
      position: 102
      prefix: -single
  - id: steps_converge
    type:
      - 'null'
      - int
    doc: Check every step-size number of aligned fragments for convergence
    default: 500
    inputBinding:
      position: 102
      prefix: -stepsConverge
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. One file per thread
    default: 1
    inputBinding:
      position: 102
      prefix: -threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
  - id: hpc_dry_run
    type:
      - 'null'
      - File
    doc: Dry Run. Pipe execution commands to file
    outputBinding:
      glob: $(inputs.hpc_dry_run)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
