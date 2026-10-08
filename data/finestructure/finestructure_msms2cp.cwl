cwlVersion: v1.2
class: CommandLineTool
baseCommand: msms2cp.pl
label: finestructure_msms2cp
doc: 'Converts MSMS/SCRM/MS output to ChromoPainter-style input files.


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: c1
    type:
      - 'null'
      - boolean
    doc: Output ChromoPainter version 1 format
    inputBinding:
      position: 1
      prefix: -c1
  - id: location_multiplier
    type:
      - 'null'
      - float
    doc: Multiplier for the SNP locations (default 1000000)
    inputBinding:
      position: 1
      prefix: -n
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy (default 2 for diploid; needed only for ChromoPainter version 1)
    inputBinding:
      position: 1
      prefix: -p
  - id: ms_haplotypes
    type:
      - 'null'
      - int
    doc: Specify ms mode, and give the number of haplotypes in it (ms does not include
      this in the header)
    inputBinding:
      position: 1
      prefix: -ms
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 1
      prefix: -v
  - id: msmsoutput
    type: File
    doc: MSMS/SCRM/MS output file
    inputBinding:
      position: 2
  - id: output_filename_prefix
    type: string
    doc: Filename prefix for the ChromoPainter input files
    inputBinding:
      position: 3
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files written with the prefix
    outputBinding:
      glob: $(inputs.output_filename_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
