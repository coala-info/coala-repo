cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vstree2tex
label: vmatch_vstree2tex
doc: "Write tables of a Vmatch index (suffix array and related tables) as LaTeX.

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.index_files ? inputs.index_files : [])'
inputs:
  - id: index_name
    type: string
    doc: "Name of the index (the mkvtree -indexname value)"
    inputBinding:
      position: 200
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Index files written by mkvtree (staged in the working directory)"
  - id: s
    type:
      - 'null'
      - boolean
    doc: "output suffixes"
    inputBinding:
      position: 101
      prefix: -s
  - id: tis
    type:
      - 'null'
      - boolean
    doc: "output tistab"
    inputBinding:
      position: 101
      prefix: -tis
  - id: ois
    type:
      - 'null'
      - boolean
    doc: "output oistab"
    inputBinding:
      position: 101
      prefix: -ois
  - id: suf
    type:
      - 'null'
      - boolean
    doc: "output suftab"
    inputBinding:
      position: 101
      prefix: -suf
  - id: sti1
    type:
      - 'null'
      - boolean
    doc: "output small inverse suftab"
    inputBinding:
      position: 101
      prefix: -sti1
  - id: bwt
    type:
      - 'null'
      - boolean
    doc: "output bwttab"
    inputBinding:
      position: 101
      prefix: -bwt
  - id: bck
    type:
      - 'null'
      - boolean
    doc: "output bcktab in vertical mode"
    inputBinding:
      position: 101
      prefix: -bck
  - id: bckhz
    type:
      - 'null'
      - boolean
    doc: "output bcktab in horizontal mode"
    inputBinding:
      position: 101
      prefix: -bckhz
  - id: lcp
    type:
      - 'null'
      - boolean
    doc: "output lcptab"
    inputBinding:
      position: 101
      prefix: -lcp
  - id: skp
    type:
      - 'null'
      - boolean
    doc: "output skptab"
    inputBinding:
      position: 101
      prefix: -skp
  - id: cfr
    type:
      - 'null'
      - boolean
    doc: "output cfrtab"
    inputBinding:
      position: 101
      prefix: -cfr
  - id: crf
    type:
      - 'null'
      - boolean
    doc: "output crftab"
    inputBinding:
      position: 101
      prefix: -crf
  - id: lsf
    type:
      - 'null'
      - boolean
    doc: "output lsftab"
    inputBinding:
      position: 101
      prefix: -lsf
  - id: sti
    type:
      - 'null'
      - boolean
    doc: "output inverse suftab"
    inputBinding:
      position: 101
      prefix: -sti
  - id: cld
    type:
      - 'null'
      - boolean
    doc: "output cldtab"
    inputBinding:
      position: 101
      prefix: -cld
  - id: iso
    type:
      - 'null'
      - boolean
    doc: "output isotab"
    inputBinding:
      position: 101
      prefix: -iso
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_vstree2tex.out
