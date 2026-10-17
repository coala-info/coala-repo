cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbam_mapped_transcriptome
label: ptools_bin_pbam_mapped_transcriptome
doc: "Convert a BAM mapped to a transcriptome into a pBAM: replace read sequences with the reference sequence taken from the transcriptome or, through the GTF, from the genome. SAM records (without header) are read from standard input.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: transcriptome_fasta
    type: File
    doc: Reference transcriptome FASTA
    inputBinding:
      position: 1
  - id: genome_fasta
    type: File
    doc: Reference genome FASTA
    inputBinding:
      position: 2
  - id: header_file
    type: File
    doc: SAM header text (output of samtools view -H)
    inputBinding:
      position: 3
  - id: gtf_file
    type: File
    doc: Gene annotation in GTF format
    inputBinding:
      position: 4
  - id: sam_file
    type: File
    doc: SAM records without header (output of samtools view), read from standard input
outputs:
  - id: pbam_sam
    type: stdout
    doc: pBAM in SAM text format (header then records)
stdin: $(inputs.sam_file.path)
stdout: pbam_mapped_transcriptome.p.sam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
