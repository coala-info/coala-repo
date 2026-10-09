cwlVersion: v1.2
class: CommandLineTool
baseCommand: HmnRandomRead
label: hmnrandomread_HmnRandomRead
doc: "Generate random reads from reference sequences with specified insert sizes and
  error profiles.\n\nTool homepage: https://github.com/guillaume-gricourt/HmnRandomRead"
inputs:
  - id: length_reads
    type:
      - 'null'
      - int
    doc: Reads Size
    inputBinding:
      position: 101
      prefix: --length-reads
  - id: mean_insert_size
    type:
      - 'null'
      - int
    doc: Mean Insert Size
    inputBinding:
      position: 101
      prefix: --mean-insert-size
  - id: profile_diversity
    type:
      - 'null'
      - File
    doc: Name file with profile diversity
    inputBinding:
      position: 101
      prefix: --profile-diversity
  - id: profile_error
    type:
      - 'null'
      - File
    doc: Name file with profile error
    inputBinding:
      position: 101
      prefix: --profile-error
  - id: profile_error_id
    type:
      - 'null'
      - string
    doc: Id error profile to apply (required if -profileError)
    inputBinding:
      position: 101
      prefix: --profile-error-id
  - id: reference
    type: File
    doc: Reference fasta file; the tool passes it as `<path>,<number of reads>`
    inputBinding:
      position: 101
      prefix: --reference
      valueFrom: |-
        ${
          var p = self.basename;
          if (inputs.number_reads !== null && inputs.number_reads !== undefined) {
            p = p + "," + inputs.number_reads;
          }
          return p;
        }
  - id: number_reads
    type:
      - 'null'
      - int
    doc: Number of sequences (read pairs) to generate from the reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed number
    inputBinding:
      position: 101
      prefix: --seed
  - id: std_insert_size
    type:
      - 'null'
      - int
    doc: Standard Deviation Insert Size
    inputBinding:
      position: 101
      prefix: --std-insert-size
  - id: read_forward_path
    type:
      - 'null'
      - string
    doc: Name Read Forward output (required)
    inputBinding:
      position: 102
      prefix: --read-forward
  - id: read_reverse_path
    type:
      - 'null'
      - string
    doc: Name Read Reverse output (required)
    inputBinding:
      position: 103
      prefix: --read-reverse
outputs:
  - id: read_forward
    type: File
    doc: Name Read Forward output
    outputBinding:
      glob: $(inputs.read_forward_path)
  - id: read_reverse
    type: File
    doc: Name Read Reverse output
    outputBinding:
      glob: $(inputs.read_reverse_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnrandomread:0.10.0--h9948957_4
