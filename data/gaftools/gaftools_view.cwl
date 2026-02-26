cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaftools_view
label: gaftools_view
doc: "View, subset or convert a GAF file (GAF file should be indexed first, using
  gaftools index).\n\nThe view command allows subsetting the GAF file based on node
  IDs or regions available.\n\nTool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: gaf_file
    type: File
    doc: GAF file (can be bgzip-compressed)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: format of output path (unstable | stable)
    inputBinding:
      position: 102
      prefix: --format
  - id: gfa_file
    type:
      - 'null'
      - File
    doc: GFA file (can be bggzip-compressed). Required when converting from one 
      coordinate system to another.
    inputBinding:
      position: 102
      prefix: --gfa
  - id: index
    type:
      - 'null'
      - File
    doc: Path to GAF Viewing Index file. This index is created using gaftools 
      index. If path is not provided, it is assumed to be in the same directory 
      as GAF file with the same name and .gvi extension (default location of the
      index script)
    inputBinding:
      position: 102
      prefix: --index
  - id: node
    type:
      - 'null'
      - type: array
        items: string
    doc: Nodes to search. Multiple can be provided (Eg. gaftools view .... -n s1
      -n s2 -n s3 .....).
    inputBinding:
      position: 102
      prefix: --node
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Regions to search. Multiple can be provided (Eg. gaftools view .... -r 
      chr1:10-20 -r chr1:50-60 .....).
    inputBinding:
      position: 102
      prefix: --region
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output GAF (bgzipped if the file ends with .gz). If omitted, use 
      standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
