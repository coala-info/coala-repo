cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbam2bam
label: ptools_bin_pbam2bam
doc: "Convert a pBAM back to a BAM using the reference and a compressed diff file. SAM records of the pBAM (without header) are read from standard input and a SAM with header is written to standard output.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: mode
    type: string
    doc: Reference type, genome or transcriptome
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: Reference FASTA for the chosen mode
    inputBinding:
      position: 2
  - id: diff_file
    type: File
    doc: Compressed diff file made by compress (the tool writes the decompressed text beside it as <diff>.txt)
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: header_file
    type: File
    doc: SAM header text (output of samtools view -H)
    inputBinding:
      position: 4
  - id: pbam_sam
    type: File
    doc: pBAM records without header (output of samtools view), read from standard input
outputs:
  - id: bam_sam
    type: stdout
    doc: Restored BAM in SAM text format (header then records)
stdin: $(inputs.pbam_sam.path)
stdout: pbam2bam.sam
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.diff_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
