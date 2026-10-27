cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mkdna6idx
label: vmatch_mkdna6idx
doc: "Construct the index of the six frame translation of DNA sequence files for Vmatch.

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: db
    type: File[]
    doc: "specify database files (mandatory)"
    inputBinding:
      position: 101
      prefix: -db
  - id: smap
    type:
      - 'null'
      - File
    doc: "specify file containing a symbol mapping"
    inputBinding:
      position: 101
      prefix: -smap
  - id: transnum
    type:
      - 'null'
      - int
    doc: "perform six frame translation; codon translation table number in [1,23] (default 1)"
    inputBinding:
      position: 100
      prefix: -transnum
  - id: indexname
    type: string
    doc: "specify name for index to be generated"
    inputBinding:
      position: 101
      prefix: -indexname
  - id: cpl
    type:
      - 'null'
      - boolean
    doc: "use reverse complement of the input sequence"
    inputBinding:
      position: 101
      prefix: -cpl
  - id: tis
    type:
      - 'null'
      - boolean
    doc: "output transformed input sequences (tistab) to file"
    inputBinding:
      position: 101
      prefix: -tis
  - id: ois
    type:
      - 'null'
      - boolean
    doc: "output original input sequences (oistab) to file"
    inputBinding:
      position: 101
      prefix: -ois
  - id: maxdepth
    type:
      - 'null'
      - int
    doc: "restrict the sorting to prefixes of the given length"
    inputBinding:
      position: 101
      prefix: -maxdepth
  - id: v
    type:
      - 'null'
      - boolean
    doc: "verbose mode"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written for the given index name
    outputBinding:
      glob: $(inputs.indexname).*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_mkdna6idx.out
