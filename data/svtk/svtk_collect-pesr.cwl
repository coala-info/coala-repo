cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk collect-pesr
label: svtk_collect-pesr
doc: "Collect split read and discordant pair data from a bam alignment.\n\nTool homepage:
  https://github.com/talkowski-lab/svtk"
inputs:
  - id: bam
    type: File
    doc: Local or S3 path to bam
    inputBinding:
      position: 1
  - id: sample
    type: string
    doc: ID to append to each line of output files.
    inputBinding:
      position: 2
  - id: splitfile
    type: File
    doc: Output split counts.
    inputBinding:
      position: 3
  - id: discfile
    type: File
    doc: Output discordant pairs.
    inputBinding:
      position: 4
  - id: bgzip
    type:
      - 'null'
      - boolean
    doc: bgzip and tabix index output
    inputBinding:
      position: 105
      prefix: --bgzip
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: Directory of local BAM indexes if accessing a remote S3 bam.
    inputBinding:
      position: 105
      prefix: --index-dir
  - id: region
    type:
      - 'null'
      - string
    doc: Tabix-formatted region to parse
    inputBinding:
      position: 105
      prefix: --region
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
stdout: svtk_collect-pesr.out
