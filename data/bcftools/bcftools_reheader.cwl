cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - reheader
label: bcftools_reheader
doc: "Modify header of VCF/BCF files, change sample names.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: fai
    type:
      - 'null'
      - File
    doc: Update sequences and their lengths from the .fai file
    inputBinding:
      position: 102
      prefix: --fai
  - id: header
    type:
      - 'null'
      - File
    doc: New header
    inputBinding:
      position: 102
      prefix: --header
  - id: samples_file
    type:
      - 'null'
      - File
    doc: New sample names in a file, see the man page for details
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: samples_list
    type:
      - 'null'
      - string
    doc: New sample names given as a comma-separated list
    inputBinding:
      position: 102
      prefix: --samples-list
  - id: temp_prefix
    type:
      - 'null'
      - Directory
    doc: Ignored; was template for temporary file name
    inputBinding:
      position: 102
      prefix: --temp-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with INT worker threads (BCF only)
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to a file [standard output]
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
