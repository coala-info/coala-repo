cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rsidx
  - search
label: rsidx_search
doc: "Search a sorted, indexed VCF file for rsIDs.\n\nTool homepage: https://github.com/bioforensics/rsidx/"
arguments:
  - position: 3
    valueFrom: "$(inputs.rsid_file ? '--file' : null)"
inputs:
  - id: vcf
    type: File
    doc: sorted and indexed VCF file (with its .tbi tabix index)
    secondaryFiles:
      - pattern: .tbi
        required: true
    inputBinding:
      position: 1
  - id: idx
    type: File
    doc: rsidx index file
    inputBinding:
      position: 2
  - id: rsid
    type:
      - 'null'
      - type: array
        items: string
    doc: rsID(s) to search
    inputBinding:
      position: 3
  - id: rsid_file
    type:
      - 'null'
      - File
    doc: text file with the rsIDs to search, one per line (used instead of rsid)
    inputBinding:
      position: 4
  - id: header
    type:
      - 'null'
      - boolean
    doc: print VCF headers
    inputBinding:
      position: 101
      prefix: --header
  - id: out
    type:
      - 'null'
      - string
    doc: write output to specified FILE; default is terminal (stdout)
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file given with --out
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsidx:0.3.1--pyhdfd78af_0
stdout: rsidx_search.out
