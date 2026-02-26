cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle_extract
label: eagle_extract
doc: "Extracts regions from BAM/SAM/CRAM files based on a capture kit file.\n\nTool
  homepage: https://bitbucket.org/christopherschroeder/eagle"
inputs:
  - id: bam
    type: File
    doc: a bam/sam/cram file
    inputBinding:
      position: 1
  - id: capturekit
    type: File
    doc: a capturekit gff or bed file
    inputBinding:
      position: 2
  - id: samplerate
    type:
      - 'null'
      - float
    doc: only use this fraction of regions
    inputBinding:
      position: 103
      prefix: --samplerate
outputs:
  - id: write_stats_to_file
    type:
      - 'null'
      - File
    doc: directly write the stats to this eagle file
    outputBinding:
      glob: $(inputs.write_stats_to_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
