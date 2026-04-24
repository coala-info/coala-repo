cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitem bin
label: unitem_bin
doc: "Apply binning methods to an assembly.\n\nTool homepage: https://github.com/dparks1134/UniteM"
inputs:
  - id: assembly_file
    type: File
    doc: assembled contigs to bin (FASTA format)
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 2
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM file(s) to parse for coverage profile
    inputBinding:
      position: 103
      prefix: --bam_files
  - id: cov_file
    type:
      - 'null'
      - File
    doc: file indicating coverage information
    inputBinding:
      position: 103
      prefix: --cov_file
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs
    inputBinding:
      position: 103
      prefix: --cpus
  - id: gm2
    type:
      - 'null'
      - boolean
    doc: run GroopM v2
    inputBinding:
      position: 103
      prefix: --gm2
  - id: max107
    type:
      - 'null'
      - boolean
    doc: run MaxBin with the 107 marker gene set
    inputBinding:
      position: 103
      prefix: --max107
  - id: max40
    type:
      - 'null'
      - boolean
    doc: run MaxBin with the 40 marker gene set
    inputBinding:
      position: 103
      prefix: --max40
  - id: mb2
    type:
      - 'null'
      - boolean
    doc: run MetaBAT v2
    inputBinding:
      position: 103
      prefix: --mb2
  - id: mb_sensitive
    type:
      - 'null'
      - boolean
    doc: run MetaBAT v1 with the 'sensitive' preset settings
    inputBinding:
      position: 103
      prefix: --mb_sensitive
  - id: mb_specific
    type:
      - 'null'
      - boolean
    doc: run MetaBAT v1 with the 'specific' preset settings
    inputBinding:
      position: 103
      prefix: --mb_specific
  - id: mb_superspecific
    type:
      - 'null'
      - boolean
    doc: run MetaBAT v1 with the 'superspecific' preset settings
    inputBinding:
      position: 103
      prefix: --mb_superspecific
  - id: mb_verysensitive
    type:
      - 'null'
      - boolean
    doc: run MetaBAT v1 with the 'verysensitive' preset settings
    inputBinding:
      position: 103
      prefix: --mb_verysensitive
  - id: mb_veryspecific
    type:
      - 'null'
      - boolean
    doc: run MetaBAT v1 with the 'veryspecific' preset settings
    inputBinding:
      position: 103
      prefix: --mb_veryspecific
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: minimum length of contigs to bin (>=1500 recommended)
    inputBinding:
      position: 103
      prefix: --min_contig_len
  - id: seed
    type:
      - 'null'
      - int
    doc: set random seed; default is to use a random seed
    inputBinding:
      position: 103
      prefix: --seed
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
stdout: unitem_bin.out
