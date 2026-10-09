cwlVersion: v1.2
class: CommandLineTool
baseCommand: unique-kmers.py
label: khmer_unique-kmers.py
doc: |-
  Estimate number of unique k-mers, with precision <= ERROR_RATE. A HyperLogLog counter is used to do cardinality estimation. Informational output is sent to STDERR, but a report file can be generated with --report.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_sequence_filename
    type: File[]
    doc: Input FAST[AQ] sequence filename(s).
    inputBinding:
      position: 1
  - id: info
    type: ['null', boolean]
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: quiet
    type: ['null', boolean]
    doc: quiet
    inputBinding:
      position: 103
      prefix: --quiet
  - id: ksize
    type: ['null', int]
    doc: k-mer size to use
    inputBinding:
      position: 103
      prefix: --ksize
  - id: error_rate
    type: ['null', float]
    doc: Acceptable error rate
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: report
    type: ['null', string]
    doc: generate informational report and write to filename
    inputBinding:
      position: 103
      prefix: --report
  - id: stream_records
    type: ['null', boolean]
    doc: write input sequences to STDOUT
    inputBinding:
      position: 103
      prefix: --stream-records
  - id: diagnostics
    type: ['null', boolean]
    doc: print out recommended tablesize arguments and restrictions
    inputBinding:
      position: 103
      prefix: --diagnostics
outputs:
  - id: report_output
    type: ['null', File]
    doc: Informational report written with --report
    outputBinding:
      glob: "$(inputs.report)"
  - id: stdout
    type: stdout
    doc: Input sequences (when --stream-records is used)
  - id: stderr_output
    type: stderr
    doc: Informational output, including the estimated number of unique k-mers
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_unique-kmers.py.out
stderr: khmer_unique-kmers.py.err
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
