cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybran
  - synergize
label: hybran_synergize
doc: "Correct annotations using hints from discordant synteny (experimental).\n\nTool homepage: https://gitlab.com/LPCDRP/hybran"
inputs:
  - id: annotations
    type:
      type: array
      items: [File, Directory]
    doc: "Hybran output directory, blocks_coords BED file, Genbank annotation files, or the directories containing them."
    inputBinding:
      position: 1
  - id: references
    type:
      - 'null'
      - type: array
        items: [File, Directory]
    doc: "Directory, list of GBK files, or a file of file names containing reference annotations. Required if not using a hybran output directory."
    inputBinding:
      position: 101
      prefix: -r
  - id: seq_dir
    type:
      - 'null'
      - Directory
    doc: "Directory containing the corresponding genome sequence files in FASTA format."
    inputBinding:
      position: 101
      prefix: -s
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Directory to output the results of the correction (default: current directory). Created before the run."
    inputBinding:
      position: 101
      prefix: -o
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Number of parallel processes to use (default: 1)."
    inputBinding:
      position: 101
      prefix: -n
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Write debug logs."
    inputBinding:
      position: 101
      prefix: -d
  - id: blast_min_identity
    type:
      - 'null'
      - float
    doc: "Minimum percent sequence identity for matching genes (default: 80)."
    inputBinding:
      position: 101
      prefix: -i
  - id: blast_min_coverage
    type:
      - 'null'
      - float
    doc: "Minimum percent sequence alignment coverage for matching genes (default: 80)."
    inputBinding:
      position: 101
      prefix: -c
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
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.outdir ? {'class': 'Directory', 'basename': inputs.outdir, 'listing': []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybran:1.10--pyhdfd78af_0
