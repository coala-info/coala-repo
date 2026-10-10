cwlVersion: v1.2
class: CommandLineTool
baseCommand: amrfinder_index
label: ncbi-amrfinderplus_amrfinder_index
doc: "Index the database for AMRFinder.\n\nTool homepage: https://github.com/ncbi/amr"
inputs:
  - id: database
    type: Directory
    doc: Directory with the AMRFinder database (one version directory).
    inputBinding:
      position: 101
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
  - id: indexed_database
    type: Directory
    doc: The database directory with the index files.
    outputBinding:
      glob: $(inputs.database.basename)
  - id: stdout
    type: stdout
    doc: Standard output
stdout: amrfinder_index.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-amrfinderplus:4.2.7--hf69ffd2_0
