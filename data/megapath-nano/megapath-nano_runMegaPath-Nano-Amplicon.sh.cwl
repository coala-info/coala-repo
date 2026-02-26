cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/runMegaPath-Nano-Amplicon.sh
label: megapath-nano_runMegaPath-Nano-Amplicon.sh
doc: "Runs the MegaPath-Nano amplicon pipeline.\n\nTool homepage: https://github.com/HKU-BAL/MegaPath-Nano"
inputs:
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the database.
    default: /usr/local/MegaPath-Nano/bin/db
    inputBinding:
      position: 101
      prefix: -d
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    default: megapath-nano-amplicon
    inputBinding:
      position: 101
      prefix: -p
  - id: read_fq
    type: File
    doc: Input FASTQ file containing reads.
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 24
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
stdout: megapath-nano_runMegaPath-Nano-Amplicon.sh.out
