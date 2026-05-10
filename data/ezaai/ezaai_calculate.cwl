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
    inputBinding:
      position: 101
      prefix: -blastp
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum query coverage threshold for AAI calculations [0 - 1.0]
    inputBinding:
      position: 101
      prefix: -cov
  - id: diamond_path
    type:
      - 'null'
      - File
    doc: Custom path to DIAMOND binary
    inputBinding:
      position: 101
      prefix: -diamond
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimum identity threshold for AAI calculations [0 - 1.0]
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
    inputBinding:
      position: 101
      prefix: -blastdb
  - id: mmseqs_path
    type:
      - 'null'
      - File
    doc: Custom path to MMSeqs2 binary
    inputBinding:
      position: 101
      prefix: -mmseqs
  - id: program
    type:
      - 'null'
      - string
    doc: Customize calculation program [mmseqs / diamond / blastp]
    inputBinding:
      position: 101
      prefix: -p
  - id: self_comparison
    type:
      - 'null'
      - int
    doc: Assume self-comparison; -i and -j must be identical [0 / 1]
    inputBinding:
      position: 101
      prefix: -self
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Custom temporary directory
    inputBinding:
      position: 101
      prefix: -tmp
  - id: match_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `match_output_path`
    inputBinding:
      position: 102
      prefix: --match-output
  - id: mtx_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `mtx_output_path`
    inputBinding:
      position: 103
      prefix: --mtx-output
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output result file
    outputBinding:
      glob: $(inputs.output_path)
  - id: match_output
    type:
      - 'null'
      - File
    doc: Path to write a result of matched CDS names
    outputBinding:
      glob: $(inputs.match_output_path)
  - id: mtx_output
    type:
      - 'null'
      - File
    doc: Path to write a Matrix Market formatted output
    outputBinding:
      glob: $(inputs.mtx_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
