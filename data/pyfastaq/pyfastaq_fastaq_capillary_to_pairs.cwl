cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - capillary_to_pairs
label: pyfastaq_fastaq_capillary_to_pairs
doc: "Given a file of capillary reads, makes an interleaved file of read pairs (where more than read from same ligation, takes the longest read) and a file of unpaired reads. Replaces the .p1k/.q1k part of read names to denote fwd/rev reads with /1 and /2\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: "Name of input fasta/q file"
    inputBinding:
      position: 20
  - id: outprefix
    type: string
    doc: "Prefix of output files"
    inputBinding:
      position: 21
outputs:
  - id: paired_reads
    type: File
    doc: Interleaved file of read pairs.
    outputBinding:
      glob: $(inputs.outprefix).paired.gz
  - id: unpaired_reads
    type: File
    doc: File of unpaired reads.
    outputBinding:
      glob: $(inputs.outprefix).unpaired.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
