cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifihla call-consensus
label: hifihla_call-consensus
doc: "Call HLA Star (*) alleles from consensus sequences\n\nTool homepage: https://github.com/PacificBiosciences/hifihla"
inputs:
  - id: cdna
    type:
      - 'null'
      - boolean
    doc: Enable cDNA-only calling
    inputBinding:
      position: 101
      prefix: --cdna
  - id: exon2
    type:
      - 'null'
      - boolean
    doc: Require Exon2 in query sequence
    inputBinding:
      position: 101
      prefix: --exon2
  - id: fasta
    type: File
    doc: Input fasta file of consensus sequences
    inputBinding:
      position: 101
      prefix: --fasta
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: Full length IMGT records only
    inputBinding:
      position: 101
      prefix: --full_length
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Alternative to repeated -v/--verbose: set log level via key. Equivalence
      to -v/--verbose: => "Warn" -v => "Info" -vv => "Debug" -vvv => "Trace"'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_matches
    type:
      - 'null'
      - int
    doc: Maximum equivalent matches per query in report
    inputBinding:
      position: 101
      prefix: --max_matches
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory [deprecated]
    inputBinding:
      position: 101
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Analysis threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
stdout: hifihla_call-consensus.out
