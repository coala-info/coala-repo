cwlVersion: v1.2
class: CommandLineTool
baseCommand: tasmanian-mismatch_run_tasmanian
label: tasmanian-mismatch_run_tasmanian
doc: "Run Tasmanian mismatch caller\n\nTool homepage: https://github.com/nebiolabs/tasmanian-mismatch"
inputs:
  - id: base_quality
    type:
      - 'null'
      - int
    doc: minimum base quality
    inputBinding:
      position: 101
      prefix: -q
  - id: confidence
    type:
      - 'null'
      - int
    doc: number of bases in the confident region of the read
    inputBinding:
      position: 101
      prefix: --confidence
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create a log file
    inputBinding:
      position: 101
      prefix: --debug
  - id: filter_indel
    type:
      - 'null'
      - boolean
    doc: exclude reads with indels
    inputBinding:
      position: 101
      prefix: --filter-indel
  - id: filter_length
    type:
      - 'null'
      - string
    doc: include only reads with x,y range of lengths
    inputBinding:
      position: 101
      prefix: --filter-length
  - id: fragment_length
    type:
      - 'null'
      - string
    doc: use fragments with these lengths ONLY
    inputBinding:
      position: 101
      prefix: --fragment-length
  - id: include_pwm
    type:
      - 'null'
      - boolean
    doc: include PWM
    inputBinding:
      position: 101
      prefix: --include-pwm
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: minimum allowed mapping quality
    inputBinding:
      position: 101
      prefix: --mapping-quality
  - id: ont
    type:
      - 'null'
      - boolean
    doc: this is ONT data
    inputBinding:
      position: 101
      prefix: --ont
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: use this prefix for the output and logging files
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: picard_logic
    type:
      - 'null'
      - boolean
    doc: normalize tables based on picard CollectSequencingArtifactMetrics logic
    inputBinding:
      position: 101
      prefix: --picard-logic
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference-fasta
  - id: soft_clip_bypass
    type:
      - 'null'
      - int
    doc: Decide when softclipped base is correct(0). Don't use these bases(1). 
      Force use them(2).
    inputBinding:
      position: 101
      prefix: --soft-clip-bypass
  - id: unmask_genome
    type:
      - 'null'
      - boolean
    doc: convert masked bases to upper case and include them in the calculations
    inputBinding:
      position: 101
      prefix: --unmask-genome
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
stdout: tasmanian-mismatch_run_tasmanian.out
