cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crac-index
  - index
label: crac_crac-index_index
doc: "Create a CRAC index (.ssa compressed sequences and .conf sequence names and
  lengths) on the specified FASTA or MultiFASTA file(s)\n\nTool homepage: http://crac.gforge.inria.fr/"
inputs:
  - id: bucket_size
    type:
      - 'null'
      - int
    doc: the size of the bucket for the index construction (default 100000000)
    inputBinding:
      position: 101
      prefix: -b
  - id: diff_cover
    type:
      - 'null'
      - int
    doc: parameter for the index construction (default 1024)
    inputBinding:
      position: 101
      prefix: -d
  - id: sample_dist
    type:
      - 'null'
      - int
    doc: sample distance (default 64)
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
  - id: index_name
    type: string
    doc: output index name; the tool writes <index_name>.ssa and <index_name>.conf
    inputBinding:
      position: 102
  - id: input_files
    type:
      type: array
      items: File
    doc: FASTA or MultiFASTA file(s) to index
    inputBinding:
      position: 103
outputs:
  - id: index
    type: File
    doc: index storing the compressed sequences (.ssa), with the .conf file 
      (sequence names and lengths) beside it
    secondaryFiles:
      - ^.conf
    outputBinding:
      glob: $(inputs.index_name).ssa
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crac:v2.5.0dfsg-3-deb_cv1
