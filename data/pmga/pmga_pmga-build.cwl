cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmga-build
label: pmga_pmga-build
doc: "Create local BLAST databases from the PubMLST alleles used by pmga (needs network
  access to rest.pubmlst.org).\n\nTool homepage: https://github.com/rpetit3/pmga"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: outdir
    type: string
    default: pubmlst_dbs_all
    doc: 'Directory to save BLAST databases to (Default: ./pubmlst_dbs_all)'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directories.
    inputBinding:
      position: 101
      prefix: --force
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed.
    inputBinding:
      position: 101
      prefix: --silent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug related text.
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: blast_db_dir
    type: Directory
    doc: Directory with the BLAST databases built from PubMLST alleles
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmga:3.0.2--hdfd78af_0
