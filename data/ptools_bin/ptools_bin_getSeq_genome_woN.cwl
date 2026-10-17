cwlVersion: v1.2
class: CommandLineTool
baseCommand: getSeq_genome_woN
label: ptools_bin_getSeq_genome_woN
doc: "Rebuild a pBAM from SAM records without splice gaps (no N in the CIGAR): replace the read sequence with the reference sequence and reset the MD, AS, NM, nM and MC tags. Records are read from a SAM file, the new header is printed first.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference genome FASTA (chromosome names chr1..chr22, chrX, chrY, chrM or 1..22, X, Y, M)
    inputBinding:
      position: 1
  - id: header_file
    type: File
    doc: SAM header text (output of samtools view -H)
    inputBinding:
      position: 2
  - id: sam_file
    type: File
    doc: SAM records without header (output of samtools view)
    inputBinding:
      position: 3
outputs:
  - id: pbam_sam
    type: stdout
    doc: pBAM in SAM text format (header then records)
stdout: getSeq_genome_woN.p.sam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
