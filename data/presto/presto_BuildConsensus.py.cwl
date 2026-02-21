cwlVersion: v1.2
class: CommandLineTool
baseCommand: BuildConsensus.py
label: presto_BuildConsensus.py
doc: "Reconstructs a consensus sequence from a set of sequences (e.g., reads with
  the same UMI).\n\nTool homepage: http://presto.readthedocs.io"
inputs:
  - id: action
    type:
      - 'null'
      - string
    doc: The consensus method to use (majority, consensus, or set).
    default: majority
    inputBinding:
      position: 101
      prefix: --act
  - id: barcode_field
    type:
      - 'null'
      - string
    doc: The field name containing the barcode/UMI identifier.
    inputBinding:
      position: 101
      prefix: --bf
  - id: copy_field
    type:
      - 'null'
      - string
    doc: The field name containing the copy count of the sequence.
    inputBinding:
      position: 101
      prefix: --cf
  - id: input_file
    type: File
    doc: Input FASTQ file containing sequences to be consensus built.
    inputBinding:
      position: 101
      prefix: -s
  - id: max_error
    type:
      - 'null'
      - float
    doc: The maximum error rate allowed for a sequence to be included in the consensus.
    inputBinding:
      position: 101
      prefix: --maxerror
  - id: max_gap
    type:
      - 'null'
      - float
    doc: The maximum gap fraction allowed for a position to be included in the consensus.
    inputBinding:
      position: 101
      prefix: --maxgap
  - id: min_count
    type:
      - 'null'
      - int
    doc: The minimum number of sequences required to build a consensus.
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: min_freq
    type:
      - 'null'
      - float
    doc: The minimum frequency for a character to be considered for the consensus.
    inputBinding:
      position: 101
      prefix: -p
  - id: min_qual
    type:
      - 'null'
      - int
    doc: The minimum quality score for a position to be included in the consensus.
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: out_name
    type:
      - 'null'
      - File
    doc: The prefix for the output file name.
    outputBinding:
      glob: $(inputs.out_name)
  - id: log_file
    type:
      - 'null'
      - File
    doc: The name of the log file.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
