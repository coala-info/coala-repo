cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - shorah
  - snv
label: shorah_snv
doc: "Call SNVs from BAM files.\n\nTool homepage: https://github.com/cbg-ethz/shorah"
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
  - id: increment
    type:
      - 'null'
      - int
    doc: value of increment to use when calling SNVs (1 used in amplicon mode)
    inputBinding:
      position: 101
      prefix: --increment
  - id: maxcov
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
  - id: threshold
    type:
      - 'null'
      - float
    doc: pos threshold when calling variants from support files
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
stdout: shorah_snv.out
