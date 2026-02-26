cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr_phase_alleles
label: secapr_phase_alleles
doc: "Phase remapped reads form reference-based assembly into two separate alleles.
  Then produce consensus sequence for each allele.\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: input
    type: Directory
    doc: Call the folder that contains the results of the reference based 
      assembly (output of reference_assembly function, containing the 
      bam-files).
    inputBinding:
      position: 101
      prefix: --input
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Set the minimum read coverage. Only positions that are covered by this 
      number of reads will be called in the consensus sequence, otherwise the 
      program will add an ambiguity at this position.
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: reference
    type:
      - 'null'
      - File
    doc: Provide the reference that was used for read-mapping. If you used the 
      alignment-consensus method, provide the joined_fasta_library.fasta which 
      is found in the reference_seqs folder within the reference-assembly 
      output.
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
