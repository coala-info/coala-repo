cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustyread
arguments:
  - position: 2
    valueFrom: simulate
label: rustyread_simulate
doc: "Generate fake long read\n\nTool homepage: https://github.com/natir/rustyread"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of thread use by rustyread, 0 use all avaible core, default value 0
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - boolean
    doc: Verbosity level also control by environment variable RUSTYREAD_LOG if flag
      is set RUSTYREAD_LOG value is ignored
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: chimera
    type:
      - 'null'
      - string
    doc: Percentage at which separate fragments join together
    inputBinding:
      position: 103
      prefix: --chimera
  - id: end_adapter
    type:
      - 'null'
      - string
    doc: Adapter parameters for read ends (rate and amount)
    inputBinding:
      position: 103
      prefix: --end_adapter
  - id: end_adapter_seq
    type:
      - 'null'
      - string
    doc: Adapter parameters for read ends
    inputBinding:
      position: 103
      prefix: --end_adapter_seq
  - id: error_model
    type:
      - 'null'
      - string
      - File
    doc: Path to an error model file (a model file, or the name of a model installed with badread, or random)
    inputBinding:
      position: 103
      prefix: --error_model
  - id: glitches
    type:
      - 'null'
      - string
    doc: Read glitch parameters (rate, size and skip)
    inputBinding:
      position: 103
      prefix: --glitches
  - id: identity
    type:
      - 'null'
      - string
    doc: Sequencing identity distribution (mean, max and stdev)
    inputBinding:
      position: 103
      prefix: --identity
  - id: junk_reads
    type:
      - 'null'
      - string
    doc: This percentage of reads wil be low complexity junk
    inputBinding:
      position: 103
      prefix: --junk_reads
  - id: length
    type:
      - 'null'
      - string
    doc: Fragment length distribution (mean and stdev)
    inputBinding:
      position: 103
      prefix: --length
  - id: number_base_store
    type:
      - 'null'
      - string
    doc: "Number of base, rustyread can store in ram before write in output in absolute
      value\n            (e.g. 250M) or a relative depth (e.g. 25x)"
    inputBinding:
      position: 103
      prefix: --number_base_store
  - id: qscore_model
    type:
      - 'null'
      - string
      - File
    doc: Path to an quality score model file (a model file, or the name of a model installed with badread, or random)
    inputBinding:
      position: 103
      prefix: --qscore_model
  - id: quantity
    type: string
    doc: Either an absolute value (e.g. 250M) or a relative depth (e.g. 25x)
    inputBinding:
      position: 103
      prefix: --quantity
  - id: random_reads
    type:
      - 'null'
      - string
    doc: This percentage of reads wil be random sequence
    inputBinding:
      position: 103
      prefix: --random_reads
  - id: reference
    type: File
    doc: Path to reference fasta (can be gzipped, bzip2ped, xzped)
    inputBinding:
      position: 103
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - string
    doc: "Random number generator seed for deterministic output (default: different
      output each\n            time)"
    inputBinding:
      position: 103
      prefix: --seed
  - id: small_plasmid_bias
    type:
      - 'null'
      - boolean
    doc: "If set, then small circular plasmids are lost when the fragment length is
      too high\n            (default: small plasmids are included regardless of fragment
      length)"
    inputBinding:
      position: 103
      prefix: --small_plasmid_bias
  - id: start_adapter
    type:
      - 'null'
      - string
    doc: Adapter parameters for read starts (rate and amount)
    inputBinding:
      position: 103
      prefix: --start_adapter
  - id: start_adapter_seq
    type:
      - 'null'
      - string
    doc: Adapter parameters for read starts
    inputBinding:
      position: 103
      prefix: --start_adapter_seq
  - id: output_path_path
    type: string
    doc: Path where read is write
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Path where read is write
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustyread:0.4.1--heebf65f_4
