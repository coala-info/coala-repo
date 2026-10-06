cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - pubmlstget
label: ariba_pubmlstget
doc: "Download typing scheme for a given species from PubMLST, and make an ARIBA db\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: species
    type: string
    doc: "Species to download. Put it in quotes"
    inputBinding:
      position: 10
  - id: outdir
    type: string
    doc: "Name of output directory to be made (must not already exist)"
    default: pubmlst_out
    inputBinding:
      position: 11
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be verbose"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: mlst_db
    type: Directory
    doc: Downloaded PubMLST scheme and prepared ARIBA database (ref_db subfolder)
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
