cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vmatchselect
label: vmatch_vmatchselect
doc: "Select, sort and cluster the matches of a Vmatch match file.

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.index_files ? inputs.index_files : [])'
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
    dockerOutputDirectory: /vmatch_work
inputs:
  - id: matchfile
    type: File
    doc: "Match file written by vmatch (it names the index it was computed with)"
    inputBinding:
      position: 200
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Index files written by mkvtree (staged in the working directory)"
  - id: dbcluster
    type:
      - 'null'
      - string[]
    doc: "cluster the database sequences: percentage of shorter string, percentage of larger string, optional filename prefix, optional (minclustersize,maxclustersize)"
    inputBinding:
      position: 101
      prefix: -dbcluster
  - id: nonredundant
    type:
      - 'null'
      - boolean
    doc: "generate file with non-redundant set of sequences; only works together with -dbcluster"
    inputBinding:
      position: 101
      prefix: -nonredundant
  - id: selfun
    type:
      - 'null'
      - File
    doc: "shared object file containing selection function"
    inputBinding:
      position: 101
      prefix: -selfun
  - id: match_length
    type:
      - 'null'
      - int
    doc: "specify that match must have the given length"
    inputBinding:
      position: 101
      prefix: -l
  - id: leastscore
    type:
      - 'null'
      - int
    doc: "specify the minimum score of a match"
    inputBinding:
      position: 101
      prefix: -leastscore
  - id: evalue
    type:
      - 'null'
      - float
    doc: "specify the maximum E-value of a match"
    inputBinding:
      position: 101
      prefix: -evalue
  - id: identity
    type:
      - 'null'
      - int
    doc: "specify minimum identity of match in range [1..100%]"
    inputBinding:
      position: 101
      prefix: -identity
  - id: sort
    type:
      - 'null'
      - string
    doc: "sort the matches, mode la, ld, ia, id, ja, jd, ea, ed, sa, sd, ida or idd"
    inputBinding:
      position: 101
      prefix: -sort
  - id: best
    type:
      - 'null'
      - int
    doc: "show the best matches (those with smallest E-values); default is best 50"
    inputBinding:
      position: 101
      prefix: -best
  - id: show_alignment
    type:
      - 'null'
      - boolean
    doc: "show the alignment of matching sequences"
    inputBinding:
      position: 101
      prefix: -s
  - id: showdesc
    type:
      - 'null'
      - int
    doc: "show sequence description of match (number of characters, 0 for the whole description)"
    inputBinding:
      position: 101
      prefix: -showdesc
  - id: show_filename
    type:
      - 'null'
      - boolean
    doc: "show filename where match occurs"
    inputBinding:
      position: 101
      prefix: -f
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: "show absolute positions"
    inputBinding:
      position: 101
      prefix: -absolute
  - id: nodist
    type:
      - 'null'
      - boolean
    doc: "do not show distance of match"
    inputBinding:
      position: 101
      prefix: -nodist
  - id: noevalue
    type:
      - 'null'
      - boolean
    doc: "do not show E-value of match"
    inputBinding:
      position: 101
      prefix: -noevalue
  - id: noscore
    type:
      - 'null'
      - boolean
    doc: "do not show score of match"
    inputBinding:
      position: 101
      prefix: -noscore
  - id: noidentity
    type:
      - 'null'
      - boolean
    doc: "do not show identity of match"
    inputBinding:
      position: 101
      prefix: -noidentity
  - id: v
    type:
      - 'null'
      - boolean
    doc: "verbose mode"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
stdout: vmatch_vmatchselect.out
