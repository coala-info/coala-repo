cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoQC
label: nanoqc_nanoQC
doc: "Investigate nucleotide composition and base quality.\n\nTool homepage: https://github.com/wdecoster/nanoQC"
inputs:
  - id: fastq
    type: File
    doc: Reads data in fastq.gz format.
    inputBinding:
      position: 1
  - id: min_len
    type:
      - 'null'
      - int
    doc: Filters the reads on a minimal length of the given range. Also plots 
      the given length/2 of the begin and end of the reads.
    inputBinding:
      position: 102
      prefix: --minlen
  - id: rna
    type:
      - 'null'
      - boolean
    doc: Fastq is from direct RNA-seq and contains U nucleotides.
    inputBinding:
      position: 102
      prefix: --rna
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory in which output has to be created.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoqc:0.10.0--pyhdfd78af_0
