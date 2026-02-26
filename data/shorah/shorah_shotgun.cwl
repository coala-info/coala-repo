cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - shorah
  - shotgun
label: shorah_shotgun
doc: "Call SNVs from shotgun sequencing data.\n\nTool homepage: https://github.com/cbg-ethz/shorah"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: alpha in dpm sampling (controls the probability of creating new 
      classes)
    inputBinding:
      position: 101
      prefix: --alpha
  - id: bam_file
    type: File
    doc: sorted bam format alignment file
    inputBinding:
      position: 101
      prefix: --bam
  - id: ignore_indels
    type:
      - 'null'
      - boolean
    doc: ignore SNVs adjacent to insertions/deletions (legacy behaviour of 
      'fil', ignore this option if you don't understand)
    inputBinding:
      position: 101
      prefix: --ignore_indels
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: keep all intermediate files
    inputBinding:
      position: 101
      prefix: --keep_files
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: approximate max coverage allowed
    inputBinding:
      position: 101
      prefix: --maxcov
  - id: out_format
    type:
      - 'null'
      - type: array
        items: string
    doc: output format of called SNVs
    inputBinding:
      position: 101
      prefix: --out_format
  - id: reference_fasta
    type: File
    doc: reference genome in fasta format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: region
    type:
      - 'null'
      - string
    doc: region in format 'chr:start-stop', e.g. 'chrm:1000-3000'
    inputBinding:
      position: 101
      prefix: --region
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for reproducible results
    inputBinding:
      position: 101
      prefix: --seed
  - id: sigma
    type:
      - 'null'
      - float
    doc: sigma value to use when calling SNVs
    inputBinding:
      position: 101
      prefix: --sigma
  - id: threads
    type:
      - 'null'
      - int
    doc: 'limit maximum number of parallel sampler threads (0: CPUs count-1, n: limit
      to n)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: pos threshold when calling variants from support files
    inputBinding:
      position: 101
      prefix: --threshold
  - id: win_coverage
    type:
      - 'null'
      - int
    doc: coverage threshold. Omit windows with low coverage
    inputBinding:
      position: 101
      prefix: --win_coverage
  - id: windowsize
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 101
      prefix: --windowsize
  - id: winshifts
    type:
      - 'null'
      - int
    doc: number of window shifts
    inputBinding:
      position: 101
      prefix: --winshifts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
stdout: shorah_shotgun.out
