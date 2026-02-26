cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - bameof
label: sqt_bameof
doc: "Check whether the EOF marker is present in BAM files. If it's not, this may
  be a sign that the BAM file was corrupted.\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: BAM files to check
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print anything, just set the exit code.
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_bameof.out
