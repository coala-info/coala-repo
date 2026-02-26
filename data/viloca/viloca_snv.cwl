cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viloca
  - snv
label: viloca_snv
doc: "Call SNVs from BAM files\n\nTool homepage: https://github.com/cbg-ethz/VILOCA"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: sorted bam format alignment file
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: reference genome in fasta format
    inputBinding:
      position: 2
  - id: alpha
    type:
      - 'null'
      - float
    doc: alpha
    inputBinding:
      position: 103
      prefix: --alpha
  - id: ignore_indels
    type:
      - 'null'
      - boolean
    doc: ignore SNVs adjacent to insertions/deletions (legacy behaviour of 
      'fil', ignore this option if you don't understand)
    inputBinding:
      position: 103
      prefix: --ignore_indels
  - id: increment
    type:
      - 'null'
      - int
    doc: value of increment to use when calling SNVs
    inputBinding:
      position: 103
      prefix: --increment
  - id: maxcov
    type:
      - 'null'
      - int
    doc: approximate max read coverage per position allowed
    inputBinding:
      position: 103
      prefix: --maxcov
  - id: out_format
    type:
      - 'null'
      - type: array
        items: string
    doc: output format of called SNVs
    inputBinding:
      position: 103
      prefix: --out_format
  - id: region
    type:
      - 'null'
      - string
    doc: region in format 'chr:start-stop', e.g. 'chrm:1000-3000'
    inputBinding:
      position: 103
      prefix: --region
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for reproducible results
    inputBinding:
      position: 103
      prefix: --seed
  - id: sigma
    type:
      - 'null'
      - float
    doc: sigma value to use when calling SNVs
    inputBinding:
      position: 103
      prefix: --sigma
  - id: threshold
    type:
      - 'null'
      - float
    doc: pos threshold when calling variants from support files
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viloca:1.1.0--pyhdfd78af_0
stdout: viloca_snv.out
