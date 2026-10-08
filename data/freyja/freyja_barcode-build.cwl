cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - barcode-build
label: freyja_barcode-build
doc: "Build barcodes from a custom protobuf tree.\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: pb
    type: File
    doc: protobuf tree
    inputBinding:
      position: 1
      prefix: --pb
  - id: outdir
    type: string
    doc: Output directory save updated files
    inputBinding:
      position: 2
      prefix: --outdir
  - id: redo
    type:
      - 'null'
      - boolean
    doc: Allow for overwriting of output directory
    inputBinding:
      position: 3
      prefix: --redo
  - id: noncl
    type:
      - 'null'
      - boolean
    doc: 'only include lineages that are confirmed by cov-lineages [default: True]'
    inputBinding:
      position: 4
      prefix: --noncl
  - id: pathogen
    type:
      - 'null'
      - string
    doc: 'Pathogen of interest: SARS-CoV-2, MPX, H5Nx, H5Nx-cattle, H1N1, FLU-B-VIC,
      H3N2, MEASLESgenome, RSVa, RSVb, DENV1, DENV2, DENV3, DENV4, MTB or manual [default:
      SARS-CoV-2]'
    inputBinding:
      position: 5
      prefix: --pathogen
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: feather or csv [default: feather]'
    inputBinding:
      position: 6
      prefix: --format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_dir
    type: Directory
    doc: Directory with the built barcodes
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
stdout: freyja_barcode-build.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return [{"entryname": inputs.outdir, "entry": {"class": "Directory",
      "listing": []}, "writable": true}]; }'
