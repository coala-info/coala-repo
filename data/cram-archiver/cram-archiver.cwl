cwlVersion: v1.2
class: CommandLineTool
baseCommand: cram-archiver
label: cram-archiver
doc: "Archive BAM files to CRAM format recursively, with options for reference checking,
  age filtering, and cleanup.\n\nTool homepage: https://github.com/lumc/cram-archiver"
inputs:
  - id: path
    type: File
    doc: Path to BAM file or directory to be recursively searched.
    inputBinding:
      position: 1
  - id: cram_version
    type:
      - 'null'
      - string
    doc: CRAM version to use for CRAM conversion.
    inputBinding:
      position: 102
      prefix: --cram-version
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete BAM files after successful conversion.
    inputBinding:
      position: 102
      prefix: --delete
  - id: dont_write_checksums
    type:
      - 'null'
      - boolean
    doc: Do not store samtools checksum output on disk.
    inputBinding:
      position: 102
      prefix: --dont-write-checksums
  - id: dont_write_index
    type:
      - 'null'
      - boolean
    doc: Do not write index files for CRAM files.
    inputBinding:
      position: 102
      prefix: --dont-write-index
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Print the paths of the to be archived BAM files. Perform no actions.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude file or directory from conversion. Can be supplied multiple times.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: exclude_list
    type:
      - 'null'
      - File
    doc: Supply a newline-separated file with files and directories to exclude.
    inputBinding:
      position: 102
      prefix: --exclude-list
  - id: minimum_age_days
    type:
      - 'null'
      - int
    doc: The minimum last modification of the BAM file in days prior. This assumes
      the system clock timezone matches that of the file while also assuming that
      every day has 24x60x60 seconds.
    inputBinding:
      position: 102
      prefix: --minimum-age-days
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Display less logging information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference
    type:
      type: array
      items: File
    doc: Reference to be used for CRAM conversion. Can be used multiple times. Reference
      will be checked with the BAM file.
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads used for conversion and checksumming.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display more logging information.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cram-archiver:1.1.0--pyhdfd78af_0
stdout: cram-archiver.out
