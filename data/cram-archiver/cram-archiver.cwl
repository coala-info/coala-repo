cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cram-archiver
label: cram-archiver
doc: "Archive BAM files to CRAM format recursively, with options for reference checking,
  age filtering, and cleanup.\n\nTool homepage: https://github.com/lumc/cram-archiver"
inputs:
  - id: bam_file
    type: File
    doc: BAM file to convert. It is staged writable in the working directory,
      where the CRAM file is written beside it.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
        inputBinding:
          prefix: --exclude
    doc: Exclude file or directory from conversion. Can be supplied multiple times.
    inputBinding:
      position: 102
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
      inputBinding:
        prefix: --reference
    doc: Reference to be used for CRAM conversion. Can be used multiple times. Reference
      will be checked with the BAM file. Needs a .fai index beside it.
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
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
  - id: cram
    type:
      - 'null'
      - File
    doc: CRAM file converted from the BAM file
    secondaryFiles:
      - pattern: .crai
        required: false
    outputBinding:
      glob: $(inputs.bam_file.nameroot).cram
  - id: checksums
    type:
      type: array
      items: File
    doc: samtools checksum output of the BAM and CRAM files
    outputBinding:
      glob: '*.checksum'
  - id: stdout
    type: stdout
    doc: Standard output (BAM paths listed by --dry-run)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cram-archiver:1.1.0--pyhdfd78af_0
stdout: cram-archiver.out
