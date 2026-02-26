cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligoMatch
label: ucsc-oligomatch
doc: "Find perfect matches of oligos in a sequence. The tool searches for occurrences
  of short DNA sequences (oligos) within a larger genomic sequence and outputs the
  results in BED format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: oligo_file
    type: File
    doc: Input file containing oligos (one per line or in FASTA format)
    inputBinding:
      position: 1
  - id: sequence_file
    type: File
    doc: Sequence file to search in (FASTA, nib, or 2bit format)
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: Output file (usually in BED format)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-oligomatch:482--h0b57e2e_0
