cwlVersion: v1.2
class: CommandLineTool
baseCommand: primedlamp
label: primedlamp
doc: PRIMEr Design for Loop-mediated isothermal AMPlification. Automatically 
  designs LAMP primer sets for target sequences.
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing target sequences
    inputBinding:
      position: 101
      prefix: --input
  - id: max_primers
    type:
      - 'null'
      - int
    doc: Maximum number of primer sets to return
    inputBinding:
      position: 101
      prefix: --max-primers
  - id: max_tm
    type:
      - 'null'
      - float
    doc: Maximum melting temperature (Tm) for primers
    inputBinding:
      position: 101
      prefix: --max-tm
  - id: min_tm
    type:
      - 'null'
      - float
    doc: Minimum melting temperature (Tm) for primers
    inputBinding:
      position: 101
      prefix: --min-tm
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: salt_concentration
    type:
      - 'null'
      - float
    doc: Salt concentration (mM) for Tm calculation
    inputBinding:
      position: 101
      prefix: --salt
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedlamp:1.0.1--py_0
