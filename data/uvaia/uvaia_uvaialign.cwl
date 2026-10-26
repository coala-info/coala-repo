cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvaialign
label: uvaia_uvaialign
doc: 'Align query sequences against a reference.


  Tool homepage: https://github.com/quadram-institute-bioscience/uvaia'
inputs:
  - id: query_sequences
    type:
      - type: array
        items: File
    doc: sequences to align in fasta format, possibly compressed with gz, xz, bz2 (can be multiple files)
    inputBinding:
      position: 1
  - id: stdout_alignment
    type:
      - 'null'
      - boolean
    doc: print alignment to stdout instead of compressing to file; much faster but may generate a big output
    inputBinding:
      position: 101
      prefix: --stdout
  - id: pool
    type:
      - 'null'
      - int
    doc: Pool size, i.e. how many sequences are queued to be processed in parallel
    inputBinding:
      position: 101
      prefix: --pool
  - id: nthreads
    type:
      - 'null'
      - int
    doc: suggested number of threads
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: ambiguity
    type:
      - 'null'
      - float
    doc: maximum allowed ambiguity for sequence to be excluded (default=0.5)
    inputBinding:
      position: 101
      prefix: --ambiguity
  - id: reference
    type: File
    doc: reference sequence in fasta format, possibly compressed with gz, xz, bz2
    inputBinding:
      position: 102
      prefix: --reference
  - id: output_path
    type:
      - 'null'
      - string
    doc: prefix of the xzipped output files
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - type: array
        items: File
    doc: output files written with the given prefix
    outputBinding:
      glob: |
        ${ return inputs.output_path ? inputs.output_path + '*' : []; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
stdout: uvaia_uvaialign.out
