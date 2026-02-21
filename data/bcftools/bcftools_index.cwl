cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - index
label: bcftools_index
doc: "Index bgzip compressed VCF/BCF files for random access.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type: File
    doc: Input bgzip compressed VCF or BCF file
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: with --stats, print stats for all contigs even when zero
    inputBinding:
      position: 102
      prefix: --all
  - id: csi
    type:
      - 'null'
      - boolean
    doc: generate CSI-format index for VCF/BCF files [default]
    inputBinding:
      position: 102
      prefix: --csi
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite index if it already exists
    inputBinding:
      position: 102
      prefix: --force
  - id: min_shift
    type:
      - 'null'
      - int
    doc: set minimal interval size for CSI indices to 2^INT
    default: 14
    inputBinding:
      position: 102
      prefix: --min-shift
  - id: nrecords
    type:
      - 'null'
      - boolean
    doc: print number of records based on existing index file
    inputBinding:
      position: 102
      prefix: --nrecords
  - id: stats
    type:
      - 'null'
      - boolean
    doc: print per contig stats based on existing index file
    inputBinding:
      position: 102
      prefix: --stats
  - id: tbi
    type:
      - 'null'
      - boolean
    doc: generate TBI-format index for VCF files
    inputBinding:
      position: 102
      prefix: --tbi
  - id: threads
    type:
      - 'null'
      - int
    doc: use multithreading with INT worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: optional output index file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
