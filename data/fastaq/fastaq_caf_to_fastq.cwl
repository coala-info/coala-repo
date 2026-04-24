cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_caf_to_fastq
label: fastaq_caf_to_fastq
doc: "Converts CAF file to FASTQ format\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input CAF file.
    inputBinding:
      position: 1
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Use clipping info to clip reads, if present in the input CAF file (as 
      lines of the form "Clipping QUAL start end"). Default is to not clip
    inputBinding:
      position: 102
      prefix: --clip
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of sequence to output
    inputBinding:
      position: 102
      prefix: --min_length
outputs:
  - id: outfile
    type: File
    doc: Name of output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
