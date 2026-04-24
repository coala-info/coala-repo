cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - votuderep
  - getdbs
label: votuderep_getdbs
doc: "Download geNomad, CheckV, and PHROGs databases.\nDownloads and extracts viral
  classification and quality control databases\nrequired for viral metagenomics analysis.\n\
  The command is resumable: if interrupted, it will skip already downloaded and\n\
  extracted files when re-run.\n\nTool homepage: https://github.com/quadram-institute-bioscience/votuderep"
inputs:
  - id: db
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Database(s) to download: genomad_1.9, checkv_1.5, phrogs_4, or all (default:
      all). Can be repeated or comma-separated.'
    inputBinding:
      position: 101
      prefix: --db
  - id: force
    type:
      - 'null'
      - boolean
    doc: Allow using a non-empty output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: outdir
    type: Directory
    doc: Directory where to download and extract databases
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
stdout: votuderep_getdbs.out
