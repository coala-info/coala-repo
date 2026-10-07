cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dbcanlight
  - build
label: dbcanlight_build
doc: "Download and build the required databases. Clear the database files that already
  exist in the config folder, download from the dbcan website and use hmmpress to build
  the databases for hmm profile. Use the threads option to download parallelly.\n\n\
  Tool homepage: https://github.com/chtsai0105/dbcanLight/tree/main"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.db_dir, "listing": []})'
        writable: true
  - class: EnvVarRequirement
    envDef:
      DBCANLIGHT_DB: $(runtime.outdir)/$(inputs.db_dir)
inputs:
  - id: db_dir
    type:
      - 'null'
      - string
    doc: Name of the database folder to build (passed to the tool as 
      DBCANLIGHT_DB)
    default: dbcanlight_db
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode for debug
    inputBinding:
      position: 102
      prefix: --verbose
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force to rebuild the databases.
    inputBinding:
      position: 102
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of cpu to use. Will use at most 4 CPUs even if more are specified
      (default: 4)'
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: database
    type: Directory
    doc: Built database folder
    outputBinding:
      glob: $(inputs.db_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
