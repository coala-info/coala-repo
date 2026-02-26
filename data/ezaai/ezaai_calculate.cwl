cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ezaai
  - calculate
label: ezaai_calculate
doc: "Calculate AAI value from protein databases\n\nTool homepage: http://leb.snu.ac.kr/ezaai"
inputs:
  - id: blastp_path
    type:
      - 'null'
      - File
    doc: Custom path to BLASTp+ binary
    default: blastp
    inputBinding:
      position: 101
      prefix: -blastp
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum query coverage threshold for AAI calculations [0 - 1.0]
    default: 0.5
    inputBinding:
      position: 101
      prefix: -cov
  - id: diamond_path
    type:
      - 'null'
      - File
    doc: Custom path to DIAMOND binary
    default: diamond
    inputBinding:
      position: 101
      prefix: -diamond
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimum identity threshold for AAI calculations [0 - 1.0]
    default: 0.4
    inputBinding:
      position: 101
      prefix: -id
  - id: input_1
    type: File
    doc: First input protein DB / directory with protein DBs
    inputBinding:
      position: 101
      prefix: -i
  - id: input_2
    type: File
    doc: Second input protein DB / directory with protein DBs
    inputBinding:
      position: 101
      prefix: -j
  - id: makeblastdb_path
    type:
      - 'null'
      - File
    doc: Custom path to makeblastdb binary
    default: makeblastdb
    inputBinding:
      position: 101
      prefix: -blastdb
  - id: mmseqs_path
    type:
      - 'null'
      - File
    doc: Custom path to MMSeqs2 binary
    default: mmseqs
    inputBinding:
      position: 101
      prefix: -mmseqs
  - id: program
    type:
      - 'null'
      - string
    doc: Customize calculation program [mmseqs / diamond / blastp]
    default: mmseqs
    inputBinding:
      position: 101
      prefix: -p
  - id: self_comparison
    type:
      - 'null'
      - int
    doc: Assume self-comparison; -i and -j must be identical [0 / 1]
    default: 0
    inputBinding:
      position: 101
      prefix: -self
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    default: 10
    inputBinding:
      position: 101
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Custom temporary directory
    default: /tmp/ezaai
    inputBinding:
      position: 101
      prefix: -tmp
outputs:
  - id: output
    type: File
    doc: Output result file
    outputBinding:
      glob: $(inputs.output)
  - id: match_output
    type:
      - 'null'
      - File
    doc: Path to write a result of matched CDS names
    outputBinding:
      glob: $(inputs.match_output)
  - id: mtx_output
    type:
      - 'null'
      - File
    doc: Path to write a Matrix Market formatted output
    outputBinding:
      glob: $(inputs.mtx_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
