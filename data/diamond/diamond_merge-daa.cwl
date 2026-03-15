cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - merge-daa
label: diamond_merge-daa
doc: Merge DAA files into a single file
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: output_file
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --out
  - id: input_files
    type:
      type: array
      items: File
    doc: input reference file in FASTA format/input DAA files for merge-daa
    inputBinding:
      position: 101
      prefix: --in
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
