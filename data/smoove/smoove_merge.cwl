cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smoove
  - merge
label: smoove_merge
doc: "Merge VCF files from smoove runs.\n\nTool homepage: https://github.com/brentp/smoove"
inputs:
  - id: vcfs
    type:
      type: array
      items: File
    doc: path to vcfs.
    inputBinding:
      position: 1
  - id: fasta
    type: File
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    doc: fasta file.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: name
    type: string
    doc: project name used in output files.
    inputBinding:
      position: 102
      prefix: --name
  - id: outdir
    type:
      - 'null'
      - string
    doc: output directory.
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: log
    type: stderr
    doc: Log messages written by smoove to standard error
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: output directory.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.outdir ? {'class': 'Directory', 'basename': inputs.outdir, 'listing': []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
stderr: smoove_merge.log
