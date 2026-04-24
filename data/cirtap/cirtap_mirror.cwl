cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cirtap
  - mirror
label: cirtap_mirror
doc: "Mirror all data from ftp.patricbrc.org in the specified DB_DIR\n\nTool homepage:
  https://github.com/MGXlab/cirtap/"
inputs:
  - id: db_dir
    type: Directory
    doc: Directory to store mirrored data
    inputBinding:
      position: 1
  - id: archive_notes
    type:
      - 'null'
      - boolean
    doc: Create an tar.gz archive of the RELEASE_NOTES files in the DB_DIR
    inputBinding:
      position: 102
      prefix: --archive-notes
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Directory where cirtap will store some info for its execution. 
      Subsequent executions rely on it so be careful when you delete
    inputBinding:
      position: 102
      prefix: --cache-dir
  - id: force_check
    type:
      - 'null'
      - boolean
    doc: Force update the genomes directory regardless of RELEASE_NOTES outcome
    inputBinding:
      position: 102
      prefix: --force-check
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of parallel processes to start for downloading
    inputBinding:
      position: 102
      prefix: --jobs
  - id: logfile
    type:
      - 'null'
      - string
    doc: Write logging information in this file
    inputBinding:
      position: 102
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Define loglevel
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: notify
    type:
      - 'null'
      - string
    doc: Comma (,) separated list of emails provided as a string. E.g. 
      'user1@mail.com,user2@anothermail.com'
    inputBinding:
      position: 102
      prefix: --notify
  - id: progress
    type:
      - 'null'
      - boolean
    doc: (Experimental) Print a progress bar when downloading genomes. This 
      option cannot be set with `--loglevel debug`. If they are both supplied, 
      progress will not be shown and the more descriptive debugging messages 
      will be printed to stderr instead
    inputBinding:
      position: 102
      prefix: --progress
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Use this to set both --skip-release-check and --skip-processed-genomes 
      on. Useful for resuming a failed run
    inputBinding:
      position: 102
      prefix: --resume
  - id: skip_processed_genomes
    type:
      - 'null'
      - boolean
    doc: Skip checks for already processed genomes as found in the cache.
    inputBinding:
      position: 102
      prefix: --skip-processed-genomes
  - id: skip_release_check
    type:
      - 'null'
      - boolean
    doc: Skip checking for RELEASE_NOTES based updates
    inputBinding:
      position: 102
      prefix: --skip-release-check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
stdout: cirtap_mirror.out
