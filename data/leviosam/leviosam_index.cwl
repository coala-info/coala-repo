cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam
  - index
label: leviosam_index
doc: "Index a lift-over map using either a VCF or a chain file.\n\nTool homepage: https://github.com/alshai/levioSAM"
inputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: 'Index a lift-over map from a VCF file.'
    inputBinding:
      position: 1
      prefix: -v
  - id: sample
    type:
      - 'null'
      - string
    doc: 'The sample used to build leviosam index (-v needs to be set).'
    inputBinding:
      position: 2
      prefix: -s
  - id: haplotype
    type:
      - 'null'
      - int
    doc: 'The haplotype used to index leviosam (0 or 1). [0]'
    inputBinding:
      position: 3
      prefix: -g
  - id: name_map
    type:
      - 'null'
      - File
    doc: 'Path to a name map file. This can be used to map 1 to chr1, or vice versa.'
    inputBinding:
      position: 4
      prefix: -n
  - id: chain
    type:
      - 'null'
      - File
    doc: 'Index a lift-over map from a chain file.'
    inputBinding:
      position: 5
      prefix: -c
  - id: dest_fai
    type: File
    doc: 'Path to the FAI (FASTA index) file of the dest reference.'
    inputBinding:
      position: 6
      prefix: -F
  - id: prefix
    type: string
    doc: 'The prefix of the output file.'
    inputBinding:
      position: 7
      prefix: -p
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Verbose level [0]'
    inputBinding:
      position: 8
      prefix: -V
outputs:
  - id: index_file
    type: File
    doc: 'The lift-over map index (.lft for a VCF map, .clft for a chain map)'
    outputBinding:
      glob: $(inputs.prefix).*lft
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
