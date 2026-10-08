cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - update
label: freyja_update
doc: "Update to the most recent barcodes and curated lineage data\n\nTool homepage:\
  \ https://github.com/andersen-lab/Freyja"
inputs:
  - id: buildlocal
    type:
      - 'null'
      - boolean
    doc: Perform barcode building locally(only available for SARS-CoV-2)
    inputBinding:
      position: 101
      prefix: --buildlocal
  - id: noncl
    type:
      - 'null'
      - boolean
    doc: only include lineages that are confirmed by cov-lineages
    inputBinding:
      position: 101
      prefix: --noncl
  - id: outdir
    type: string
    doc: Output directory to save updated files. The barcodes are only downloaded
      to this directory (without it freyja writes into its own install folder, which
      is read-only in the container).
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pathogen
    type:
      - 'null'
      - string
    doc: Pathogen to provide update for
    inputBinding:
      position: 101
      prefix: --pathogen
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_dir
    type: Directory
    doc: Directory with the downloaded barcodes and lineage data
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
stdout: freyja_update.out
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: '${ return [{"entryname": inputs.outdir, "entry": {"class": "Directory",
      "listing": []}, "writable": true}]; }'
