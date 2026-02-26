cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq capillary_to_pairs
label: fastaq_capillary_to_pairs
doc: "Given a file of capillary reads, makes an interleaved file of read pairs (where
  more than read from same ligation, takes the longest read) and a file of unpaired
  reads. Replaces the .p1k/.q1k part of read names to denote fwd/rev reads with /1
  and /2\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input fasta/q file
    inputBinding:
      position: 1
  - id: outfiles_prefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
stdout: fastaq_capillary_to_pairs.out
