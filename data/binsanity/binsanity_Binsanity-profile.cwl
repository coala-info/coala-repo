cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-profile
label: binsanity_Binsanity-profile
doc: "Binsanity-profile is used to generate coverage files for input to BinSanity.
  This uses Featurecounts to generate a a coverage profile and transforms data for
  input into Binsanity, Binsanity-refine, and Binsanity-wf\n\nTool homepage: https://github.com/edgraham/BinSanity"
inputs:
  - id: contig_ids
    type: File
    doc: contig_ids.txt
    inputBinding:
      position: 101
  - id: fasta_file
    type: File
    doc: Specify fasta file being profiled
    inputBinding:
      position: 101
      prefix: -i
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: 'Specify directory for output files to be deposited [Default: Working Directory]'
    default: Working Directory
    inputBinding:
      position: 101
      prefix: -o
  - id: sam_bam_file
    type: File
    doc: "identify location of BAM files\n                            BAM files should
      be indexed and sorted"
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Specify Number of Threads For Feature Counts [Default: 1]'
    default: 1
    inputBinding:
      position: 101
      prefix: -T
  - id: transform
    type:
      - 'null'
      - string
    doc: "Indicate what type of data transformation you want in the final file [Default:log]:\n\
      \                            scale --> Scaled by multiplying by 100 and log
      transforming\n                            log --> Log transform\n          \
      \                  None --> Raw Coverage Values\n                          \
      \  X5 --> Multiplication by 5\n                            X10 --> Multiplication
      by 10\n                            X100 --> Multiplication by 100\n        \
      \                    SQR --> Square root\n                            We recommend
      using a scaled log transformation for initial testing.\n                   \
      \         Other transformations can be useful on a case by case basis"
    default: log
    inputBinding:
      position: 101
      prefix: --transform
outputs:
  - id: output_file
    type: File
    doc: Identify name of output file for coverage information
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
