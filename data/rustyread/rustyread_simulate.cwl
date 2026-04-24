cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rustyread
  - simulate
label: rustyread_simulate
doc: "Generate fake long read\n\nTool homepage: https://github.com/natir/rustyread"
inputs:
  - id: chimera
    type:
      - 'null'
      - string
    doc: Percentage at which separate fragments join together
    inputBinding:
      position: 101
      prefix: --chimera
  - id: end_adapter
    type:
      - 'null'
      - string
    doc: Adapter parameters for read ends (rate and amount)
    inputBinding:
      position: 101
      prefix: --end_adapter
  - id: end_adapter_seq
    type:
      - 'null'
      - string
    doc: Adapter parameters for read ends
    inputBinding:
      position: 101
      prefix: --end_adapter_seq
  - id: error_model
    type:
      - 'null'
      - string
    doc: Path to an error model file
    inputBinding:
      position: 101
      prefix: --error_model
  - id: glitches
    type:
      - 'null'
      - string
    doc: Read glitch parameters (rate, size and skip)
    inputBinding:
      position: 101
      prefix: --glitches
  - id: identity
    type:
      - 'null'
      - string
    doc: Sequencing identity distribution (mean, max and stdev)
    inputBinding:
      position: 101
      prefix: --identity
  - id: junk_reads
    type:
      - 'null'
      - string
    doc: This percentage of reads wil be low complexity junk
    inputBinding:
      position: 101
      prefix: --junk_reads
  - id: length
    type:
      - 'null'
      - string
    doc: Fragment length distribution (mean and stdev)
    inputBinding:
      position: 101
      prefix: --length
  - id: number_base_store
    type:
      - 'null'
      - string
    doc: "Number of base, rustyread can store in ram before write in output in absolute
      value\n            (e.g. 250M) or a relative depth (e.g. 25x)"
    inputBinding:
      position: 101
      prefix: --number_base_store
  - id: qscore_model
    type:
      - 'null'
      - string
    doc: Path to an quality score model file
    inputBinding:
      position: 101
      prefix: --qscore_model
  - id: quantity
    type: string
    doc: Either an absolute value (e.g. 250M) or a relative depth (e.g. 25x)
    inputBinding:
      position: 101
      prefix: --quantity
  - id: random_reads
    type:
      - 'null'
      - string
    doc: This percentage of reads wil be random sequence
    inputBinding:
      position: 101
      prefix: --random_reads
  - id: reference
    type: File
    doc: Path to reference fasta (can be gzipped, bzip2ped, xzped)
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - string
    doc: "Random number generator seed for deterministic output (default: different
      output each\n            time)"
    inputBinding:
      position: 101
      prefix: --seed
  - id: small_plasmid_bias
    type:
      - 'null'
      - boolean
    doc: "If set, then small circular plasmids are lost when the fragment length is
      too high\n            (default: small plasmids are included regardless of fragment
      length)"
    inputBinding:
      position: 101
      prefix: --small_plasmid_bias
  - id: start_adapter
    type:
      - 'null'
      - string
    doc: Adapter parameters for read starts (rate and amount)
    inputBinding:
      position: 101
      prefix: --start_adapter
  - id: start_adapter_seq
    type:
      - 'null'
      - string
    doc: Adapter parameters for read starts
    inputBinding:
      position: 101
      prefix: --start_adapter_seq
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Path where read is write
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustyread:0.4.1--heebf65f_4
