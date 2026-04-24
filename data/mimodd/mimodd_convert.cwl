cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimodd_convert
label: mimodd_convert
doc: "Convert between various sequence file formats.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: a list of input files (alternating r1 and r2 files for paired-end data
    inputBinding:
      position: 1
  - id: header_file
    type:
      - 'null'
      - File
    doc: optional SAM file, the header information of which should be used in 
      the output (will overwrite pre-existing header information from the input 
      file); not allowed for input in SAM/BAM format
    inputBinding:
      position: 102
      prefix: --header
  - id: input_format
    type:
      - 'null'
      - string
    doc: the format of the input file(s)
    inputBinding:
      position: 102
      prefix: --iformat
  - id: output_format
    type:
      - 'null'
      - string
    doc: the output format
    inputBinding:
      position: 102
      prefix: --oformat
  - id: split_on_rgs
    type:
      - 'null'
      - boolean
    doc: if the input file has reads from different read groups, write them to 
      separate output files (using --ofile OFILE as a file name template); 
      implied for conversions to fastq format
    inputBinding:
      position: 102
      prefix: --split-on-rgs
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use (overrides config setting; ignored if not 
      applicable to the conversion)
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
