cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - caf_to_fastq
label: pyfastaq_fastaq_caf_to_fastq
doc: "Converts CAF file to FASTQ format\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: clip
    type:
      - 'null'
      - boolean
    doc: "Use clipping info to clip reads, if present in the input CAF file (as lines of the form \"Clipping QUAL start end\"). Default is to not clip"
    inputBinding:
      position: 1
      prefix: --clip
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of sequence to output [1]"
    inputBinding:
      position: 2
      prefix: --min_length
  - id: infile
    type: File
    doc: "Name of input CAF file."
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output FASTQ file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output FASTQ file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
