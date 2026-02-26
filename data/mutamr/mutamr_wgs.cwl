cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutamr_wgs
label: mutamr_wgs
doc: "Run mutamr for whole genome sequencing data.\n\nTool homepage: https://github.com/MDU-PHL/mutamr"
inputs:
  - id: annotation_species
    type:
      - 'null'
      - string
    doc: Name of species for annotation - needs to be a snpEff annotation 
      config. Not required if using --mtb
    inputBinding:
      position: 101
      prefix: --annotation_species
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force override an existing mutamr run.
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep accessory files for further use.
    default: false
    inputBinding:
      position: 101
      prefix: --keep
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to call a variant
    default: 20
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_frac
    type:
      - 'null'
      - float
    doc: Minimum proportion to call a variant (0-1)
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_frac
  - id: mtb
    type:
      - 'null'
      - boolean
    doc: Run for Mtb
    default: false
    inputBinding:
      position: 101
      prefix: --mtb
  - id: ram
    type:
      - 'null'
      - int
    doc: Max ram to use
    default: 8
    inputBinding:
      position: 101
      prefix: --ram
  - id: read1
    type:
      - 'null'
      - File
    doc: path to read1
    default: ''
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: path to read2
    default: ''
    inputBinding:
      position: 101
      prefix: --read2
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference to use for alignment. Not required if using --mtb
    inputBinding:
      position: 101
      prefix: --reference
  - id: seq_id
    type:
      - 'null'
      - string
    doc: Sequence name
    default: mutamr
    inputBinding:
      position: 101
      prefix: --seq_id
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use for generation of vcf file.
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: temp directory to use
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutamr:0.0.2--pyhdfd78af_0
stdout: mutamr_wgs.out
