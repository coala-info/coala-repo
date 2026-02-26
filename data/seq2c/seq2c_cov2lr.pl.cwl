cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - cov2lr.pl
label: seq2c_cov2lr.pl
doc: "The cov2lr.pl program will convert a coverage file to copy number profile.\n\
  \nTool homepage: https://github.com/AstraZeneca-NGS/Seq2C"
inputs:
  - id: mapping_reads
    type: File
    doc: 'A file containing # of mapped or sequenced reads for samples. First is the
      sample name, 2nd is the number of mapped or sequenced reads.'
    inputBinding:
      position: 1
  - id: coverage_txt
    type:
      type: array
      items: File
    doc: The coverage output file from seq2cov.pl script. Can also take from 
      standard in or more than one file.
    inputBinding:
      position: 2
  - id: adjust_mad
    type:
      - 'null'
      - boolean
    doc: 'Indicate to adjust the MAD when transforming the distribution. Default:
      no, or just simple linear function.'
    inputBinding:
      position: 103
      prefix: -M
  - id: amplicon_calling
    type:
      - 'null'
      - boolean
    doc: Indicate this is amplicon or exon based calling. By default, it will 
      aggregate at gene level.
    inputBinding:
      position: 103
      prefix: -a
  - id: chry_ratio
    type:
      - 'null'
      - float
    doc: For gender testing, if chrY is designed. For exome, the number should 
      be higher, such as 0.3.
    default: 0.15
    inputBinding:
      position: 103
      prefix: -Y
  - id: control_samples
    type:
      - 'null'
      - string
    doc: Specify the control sample(s), if applicable. Multiple controls are 
      allowed, which are separated by ':'
    inputBinding:
      position: 103
      prefix: -c
  - id: failed_factor
    type:
      - 'null'
      - float
    doc: The failed factor for individual amplicons. If (the 80th percentile of 
      an amplicon depth)/(the global median depth) is less than the argument, 
      the amplicon is considered failed.
    default: 0.2
    inputBinding:
      position: 103
      prefix: -F
  - id: frozen_file
    type:
      - 'null'
      - File
    doc: Specify a frozen_file.
    inputBinding:
      position: 103
      prefix: -z
  - id: gender_file
    type:
      - 'null'
      - File
    doc: Take a file of gender information. Two columns, first is sample name, 
      second is either M or F.
    inputBinding:
      position: 103
      prefix: -G
outputs:
  - id: output_frozen
    type:
      - 'null'
      - File
    doc: Indicate to output the frozen_file and all parameters into file 
      Seq2C.frozen.txt
    outputBinding:
      glob: $(inputs.output_frozen)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
