cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaftools_sort
label: gaftools_sort
doc: "Sort the GAF alignments using BO and NO tags of the corresponding graph.\n\n\
  Tool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: gaf_file
    type: File
    doc: GAF File (can be bgzip-compressed)
    inputBinding:
      position: 1
  - id: gfa_file
    type: File
    doc: GFA file with the sort keys (BO and NO tagged). This is done with 
      gaftools order_gfa
    inputBinding:
      position: 2
  - id: outind
    type:
      - 'null'
      - File
    doc: Output GAF Sorting Index file. When --outgaf is not given, no index is 
      created. If it is given and --outind is not specified, it will have same 
      file name with .gsi extension)
    inputBinding:
      position: 103
      prefix: --outind
outputs:
  - id: outgaf
    type:
      - 'null'
      - File
    doc: Output GAF (bgzipped if the file ends with .gz). If omitted, use 
      standard output.
    outputBinding:
      glob: $(inputs.outgaf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
