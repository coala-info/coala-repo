cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - sequence
label: tksm_sequence
doc: "Sequencer module: generates FASTQ/FASTA reads from an MDF (molecule description file) and reference FASTA files\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: input
    type: File
    doc: "MDF file."
    inputBinding:
      position: 1
      prefix: --input
  - id: references
    type:
      - 'null'
      - File[]
    doc: "Reference FASTA files, space separated."
    inputBinding:
      position: 1
      prefix: --references
  - id: badread
    type:
      - 'null'
      - string
    doc: "Badread reads output file. Default: no output."
    inputBinding:
      position: 1
      prefix: --badread
  - id: perfect
    type:
      - 'null'
      - string
    doc: "Perfect reads output file. Default: no output."
    inputBinding:
      position: 1
      prefix: --perfect
  - id: skip_qual_compute
    type:
      - 'null'
      - boolean
    doc: "Use all 'K' for q-scores. Default: compute quality score using Edlib alignment to input sequences."
    inputBinding:
      position: 1
      prefix: --skip-qual-compute
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format, fastq or fasta. Default: infer from output file extension and fall back to FASTA."
    inputBinding:
      position: 1
      prefix: --output-format
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads."
    inputBinding:
      position: 1
      prefix: --threads
  - id: badread_identity
    type:
      - 'null'
      - string
    doc: "Sequencing identity distribution (mean, max and stdev) (default: 84.0,99.0,5.5)"
    inputBinding:
      position: 1
      prefix: --badread-identity
  - id: badread_error_model
    type:
      - 'null'
      - string
    doc: "Badread error model name or file path. Available model names: random, nanopore2020, pacbio2016, nanopore2018 (default: nanopore2020)"
    inputBinding:
      position: 1
      prefix: --badread-error-model
  - id: badread_qscore_model
    type:
      - 'null'
      - string
    doc: "Badread qscore model name or file path. Available model names: random, ideal, nanopore2020, nanopore2018, pacbio2016 (default: nanopore2020)"
    inputBinding:
      position: 1
      prefix: --badread-qscore-model
  - id: badread_tail_model
    type:
      - 'null'
      - string
    doc: "Badread tail model name or file path. Available model names: no_noise (default: no_noise)"
    inputBinding:
      position: 1
      prefix: --badread-tail-model
outputs:
  - id: badread_reads
    type:
      - 'null'
      - File
    doc: "Simulated reads written with --badread (synthetic data by design)"
    outputBinding:
      glob: "$(inputs.badread)"
  - id: perfect_reads
    type:
      - 'null'
      - File
    doc: "Error-free reads written with --perfect (synthetic data by design)"
    outputBinding:
      glob: "$(inputs.perfect)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm_sequence.out
