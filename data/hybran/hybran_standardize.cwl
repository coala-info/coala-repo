cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybran
  - standardize
label: hybran_standardize
doc: "Apply standard naming conventions to Hybran output: remove generic gene names, using reference or ab initio names where possible.\n\nTool homepage: https://gitlab.com/LPCDRP/hybran"
inputs:
  - id: annotations
    type:
      type: array
      items: [File, Directory]
    doc: "Directory, list of GBK files, or a file of file names containing all annotated genomes. A hybran output directory needs no other argument; otherwise give unifications_file."
    inputBinding:
      position: 1
  - id: orf_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for generic gene names (not locus tags) (default: HYBRA)."
    inputBinding:
      position: 101
      prefix: -p
  - id: output
    type:
      - 'null'
      - string
    doc: "Directory to output all new annotation files (default: current directory). Created before the run."
    inputBinding:
      position: 101
      prefix: -o
  - id: unifications_file
    type:
      - 'null'
      - File
    doc: "Reference annotation's unifications.tsv file produced by hybran onegene."
    inputBinding:
      position: 101
      prefix: -u
  - id: ref_names_only
    type:
      - 'null'
      - boolean
    doc: "Do not use gene names supplied by the ab initio caller."
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "The output directory and all files in it."
    outputBinding:
      glob: $(inputs.output)
  - id: annotation_files
    type:
      type: array
      items: File
    doc: New annotation files written to the working directory.
    outputBinding:
      glob:
        - '*.gbk'
        - '*.gff'
        - '*.tsv'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.output ? {'class': 'Directory', 'basename': inputs.output, 'listing': []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
