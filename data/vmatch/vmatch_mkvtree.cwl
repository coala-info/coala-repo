cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mkvtree
label: vmatch_mkvtree
doc: "Construct the enhanced suffix array index (virtual suffix tree) of one or more sequence files for Vmatch.\n\nTool homepage: http://www.vmatch.de/"
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
    doc: "specify file containing a symbol mapping; this describes the grouping of symbols"
    inputBinding:
      position: 101
      prefix: -smap
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "input is DNA sequence"
    inputBinding:
      position: 101
      prefix: -dna
  - id: protein
    type:
      - 'null'
      - boolean
    doc: "input is Protein sequence"
    inputBinding:
      position: 101
      prefix: -protein
  - id: indexname
    type: string
    doc: "specify name for index to be generated"
    inputBinding:
      position: 101
      prefix: -indexname
  - id: pl
    type:
      - 'null'
      - int
    doc: "specify prefix length for bucket sort; without argument a reasonable prefix length is determined automatically"
    inputBinding:
      position: 101
      prefix: -pl
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
  - id: suf
    type:
      - 'null'
      - boolean
    doc: "output suffix array (suftab) to file"
    inputBinding:
      position: 101
      prefix: -suf
  - id: sti1
    type:
      - 'null'
      - boolean
    doc: "output reduced inverse suffix array (sti1tab) to file"
    inputBinding:
      position: 101
      prefix: -sti1
  - id: bwt
    type:
      - 'null'
      - boolean
    doc: "output Burrows-Wheeler Transformation (bwttab) to file"
    inputBinding:
      position: 101
      prefix: -bwt
  - id: bck
    type:
      - 'null'
      - boolean
    doc: "output bucket boundaries (bcktab) to file"
    inputBinding:
      position: 101
      prefix: -bck
  - id: lcp
    type:
      - 'null'
      - boolean
    doc: "output longest common prefix lengths (lcptab) to file"
    inputBinding:
      position: 101
      prefix: -lcp
  - id: skp
    type:
      - 'null'
      - boolean
    doc: "output skip values (skptab) to file"
    inputBinding:
      position: 101
      prefix: -skp
  - id: allout
    type:
      - 'null'
      - boolean
    doc: "output all index tables to files"
    inputBinding:
      position: 101
      prefix: -allout
  - id: maxdepth
    type:
      - 'null'
      - int
    doc: "restrict the sorting to prefixes of the given length"
    inputBinding:
      position: 101
      prefix: -maxdepth
  - id: verbose
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_mkvtree.out
