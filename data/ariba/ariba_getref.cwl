cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - getref
label: ariba_getref
doc: "Download reference data from one of a few supported public resources\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: db
    type: string
    doc: "Database to download. Must be one of: argannot card megares ncbi plasmidfinder resfinder srst2_argannot vfdb_core vfdb_full virulencefinder"
    inputBinding:
      position: 10
  - id: outprefix
    type: string
    doc: "Prefix of output filenames"
    default: ref
    inputBinding:
      position: 11
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Do not delete temporary downloaded files"
    inputBinding:
      position: 1
      prefix: --debug
  - id: db_version
    type:
      - 'null'
      - string
    doc: "Version of reference data to download. If not used, gets the latest version. Applies to: card, megares, ncbi, plasmidfinder, resfinder, srst2_argannot, virulencefinder"
    inputBinding:
      position: 1
      prefix: --version
outputs:
  - id: ref_files
    type: File[]
    doc: Downloaded reference files (outprefix.fa, outprefix.tsv, outprefix.log, ...)
    outputBinding:
      glob: $(inputs.outprefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
