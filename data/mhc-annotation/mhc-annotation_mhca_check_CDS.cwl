cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhca
  - check_CDS
label: mhc-annotation_mhca_check_CDS
doc: "Check whether the transcripts in an annotation GFF would produce meaningful coding products.\n\n\
  Tool homepage: https://github.com/DiltheyLab/MHC-annotation"
inputs:
  - id: haplotype
    type: File
    doc: Input haplotype in fasta format.
    inputBinding:
      position: 1
  - id: annotation_gff
    type: File
    doc: Annotation GFF file produced by mhca annotate.
    inputBinding:
      position: 2
outputs:
  - id: report
    type: stdout
    doc: CDS check report (standard output).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
stdout: mhc-annotation_mhca_check_CDS.out
