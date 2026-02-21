cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamaddrg
label: bamaddrg
doc: "Merges the alignments in the supplied BAM files, using the supplied sample names
  and read groups to specifically add read group (RG) tags to each alignment. The
  output is uncompressed, and is suitable for input into downstream alignment systems
  which require RG tag information.\n\nTool homepage: https://github.com/ekg/bamaddrg"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: use this BAM as input
    inputBinding:
      position: 101
      prefix: --bam
  - id: clear
    type:
      - 'null'
      - boolean
    doc: removes all RGs which were in the old file
    inputBinding:
      position: 101
      prefix: --clear
  - id: delete
    type:
      - 'null'
      - string
    doc: removes this sample name and all associated RGs from the header
    inputBinding:
      position: 101
      prefix: --delete
  - id: read_group
    type:
      - 'null'
      - type: array
        items: string
    doc: optionally apply this read group to the preceeding BAM file
    inputBinding:
      position: 101
      prefix: --read-group
  - id: region
    type:
      - 'null'
      - string
    doc: limit alignments to those in this region (chr:start..end)
    inputBinding:
      position: 101
      prefix: --region
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: optionally apply this sample name to the preceeding BAM file
    inputBinding:
      position: 101
      prefix: --sample
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: write uncompressed BAM output
    inputBinding:
      position: 101
      prefix: --uncompressed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/bamaddrg:9baba65f88228e55639689a3cea38dd150e6284f--h4dc6686_2
stdout: bamaddrg.out
