cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr_extract
label: coptr_extract
doc: "Extract coverage maps from BAM files.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: in_folder
    type: Directory
    doc: Folder with BAM files.
    inputBinding:
      position: 1
  - id: bt2_k
    type:
      - 'null'
      - int
    doc: Maximum number of alignments.
    inputBinding:
      position: 102
      prefix: --bt2-k
  - id: check_regex
    type:
      - 'null'
      - boolean
    doc: Check the regular expression by counting reference genomes without 
      processing.
    inputBinding:
      position: 102
      prefix: --check-regex
  - id: ref_genome_regex
    type:
      - 'null'
      - string
    doc: Regular expression extracting a reference genome id from the sequence 
      id in a bam file.
    inputBinding:
      position: 102
      prefix: --ref-genome-regex
outputs:
  - id: out_folder
    type: Directory
    doc: Folder to store coverage maps.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
