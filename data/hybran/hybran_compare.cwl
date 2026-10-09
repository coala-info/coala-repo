cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybran
  - compare
label: hybran_compare
doc: "Compare two annotations of the same genome.\n\nTool homepage: https://gitlab.com/LPCDRP/hybran"
inputs:
  - id: annotations
    type:
      type: array
      items: File
    doc: "The two annotation files to compare, in genbank format."
    inputBinding:
      position: 1
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Directory to output the results of the comparison (default: current directory). Created before the run."
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: "The output directory and all files in it."
    outputBinding:
      glob: $(inputs.outdir)
  - id: reports
    type:
      type: array
      items: File
    doc: Comparison reports written to the working directory.
    outputBinding:
      glob:
        - '*.tsv'
        - '*.txt'
        - '*.csv'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.outdir ? {'class': 'Directory', 'basename': inputs.outdir, 'listing': []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
