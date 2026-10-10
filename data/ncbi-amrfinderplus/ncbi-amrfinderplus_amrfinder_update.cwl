cwlVersion: v1.2
class: CommandLineTool
baseCommand: amrfinder_update
label: ncbi-amrfinderplus_amrfinder_update
doc: "Update the database for AMRFinder from https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/. The database directory contains subdirectories named by database versions.\n\nTool homepage: https://github.com/ncbi/amr"
inputs:
  - id: database_dir
    type: string
    doc: Directory for all versions of AMRFinder databases (created if missing).
    inputBinding:
      position: 1
      prefix: --database
  - id: blast_bin
    type:
      - 'null'
      - string
    doc: Directory for BLAST.
    inputBinding:
      position: 1
      prefix: --blast_bin
  - id: hmmer_bin
    type:
      - 'null'
      - string
    doc: Directory for HMMer.
    inputBinding:
      position: 1
      prefix: --hmmer_bin
  - id: force_update
    type:
      - 'null'
      - boolean
    doc: Force updating the AMRFinder database.
    inputBinding:
      position: 1
      prefix: --force_update
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Integrity checks.
    inputBinding:
      position: 1
      prefix: --debug
  - id: log
    type:
      - 'null'
      - string
    doc: Error log file, appended, opened on application start.
    inputBinding:
      position: 1
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress messages to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
outputs:
  - id: database
    type: Directory
    doc: Database directory with one subdirectory per database version and a latest link.
    outputBinding:
      glob: $(inputs.database_dir)
  - id: stdout
    type: stdout
    doc: Standard output
stdout: amrfinder_update.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database_dir)
        entry: "$({class: 'Directory', listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-amrfinderplus:4.2.7--hf69ffd2_0
