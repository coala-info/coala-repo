cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_codon_alignment
label: extract-codon-alignment_extract_codon_alignment
doc: "To extract some codon positions (1st, 2nd, 3rd) from a CDS alignment.\n\nTool
  homepage: https://github.com/linzhi2013/extract_codon_alignment"
inputs:
  - id: aligned_cds
    type: File
    doc: The CDS alignment.
    inputBinding:
      position: 101
      prefix: --alignedCDS
  - id: aln_format
    type:
      - 'null'
      - string
    doc: the file format for the CDS alignment. Anything accepted by BioPython 
      is fine
    inputBinding:
      position: 101
      prefix: --aln_format
  - id: codon_poses
    type:
      - 'null'
      - string
    doc: Codon position(s) to be extracted
    inputBinding:
      position: 101
      prefix: --codonPoses
outputs:
  - id: out_aln
    type: File
    doc: output file name
    outputBinding:
      glob: $(inputs.out_aln)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-codon-alignment:0.0.1--py_0
