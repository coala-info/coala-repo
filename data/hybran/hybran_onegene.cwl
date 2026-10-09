cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybran
  - onegene
label: hybran_onegene
doc: "Unify names of gene duplicates in annotations.\n\nTool homepage: https://gitlab.com/LPCDRP/hybran"
inputs:
  - id: annotations
    type:
      type: array
      items: [File, Directory]
    doc: "Directory, list of GBK files, or a file of file names containing all annotated genomes."
    inputBinding:
      position: 1
  - id: orf_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for unifying gene names (not locus tags); it is placed between REF and X (default: HYBRA)."
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
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: "Percent sequence identity threshold for considering sequences as redundant (default: 99)."
    inputBinding:
      position: 101
      prefix: -i
  - id: coverage_threshold
    type:
      - 'null'
      - float
    doc: "Percent alignment coverage threshold for considering sequences as redundant (default: 99)."
    inputBinding:
      position: 101
      prefix: -c
  - id: first_reference
    type:
      - 'null'
      - string
    doc: "Reference name or file name whose locus tags are used as unified names for conserved copies in the others (default: the annotation with the most named CDSs)."
    inputBinding:
      position: 101
      prefix: -t
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
    doc: New annotation files and the unifications table written to the working directory.
    outputBinding:
      glob:
        - '*.gbk'
        - '*.gff'
        - '*.tsv'
        - '*.faa'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.output ? {'class': 'Directory', 'basename': inputs.output, 'listing': []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
