cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybran
  - defuse
label: hybran_defuse
doc: "Separate gene fusion annotations into single gene annotations.\n\nTool homepage: https://gitlab.com/LPCDRP/hybran"
inputs:
  - id: annotations_dir
    type: Directory
    doc: "Results directory from the Hybran run whose gene fusions you wish to defuse."
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: "Directory to output all new annotation files (default: current directory). Created before the run."
    inputBinding:
      position: 101
      prefix: -o
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
