cwlVersion: v1.2
class: CommandLineTool
baseCommand:
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
      position: 201
  - id: coverage_txt
    type:
      type: array
      items: File
    doc: The coverage output file from seq2cov.pl script. Can also take from 
      standard in or more than one file.
    inputBinding:
      position: 202
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
  - id: output_frozen
    type:
      - 'null'
      - boolean
    doc: Indicate to output the frozen_file and all parameters into file 
      Seq2C.frozen.txt
    inputBinding:
      position: 104
      prefix: -Z
outputs:
  - id: stdout
    type: stdout
    doc: Copy number profile (log2 ratios per sample and gene or amplicon)
  - id: gender_predicted
    type:
      - 'null'
      - File
    doc: Gender prediction table (written when sample gender is not supplied with -G)
    outputBinding:
      glob: gender_predicted.txt
  - id: frozen_output
    type:
      - 'null'
      - File
    doc: Frozen file with all parameters, written when -Z is set
    outputBinding:
      glob: Seq2C.frozen.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
stdout: seq2c_cov2lr.pl.out
