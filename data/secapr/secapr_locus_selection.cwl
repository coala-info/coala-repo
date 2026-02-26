cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr locus_selection
label: secapr_locus_selection
doc: "Extract the n loci with the best read-coverage from you reference-based assembly
  (bam-files)\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: input
    type: Directory
    doc: The folder with the results of the reference based assembly.
    inputBinding:
      position: 101
      prefix: --input
  - id: n
    type:
      - 'null'
      - int
    doc: The n loci that are best represented accross all samples will be 
      extracted.
    inputBinding:
      position: 101
      prefix: --n
  - id: read_cov
    type:
      - 'null'
      - float
    doc: The threshold for what average read coverage the selected target loci 
      should at least have.
    inputBinding:
      position: 101
      prefix: --read_cov
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to reference library fasta file (secapr will find it by itself if 
      the reference assembly was executed with secapr).
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: output
    type: Directory
    doc: The output directory where results will be safed.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
