cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - blast-classify
label: virprof_blast-classify
doc: "Compute LCA classification from BLAST search result\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: in_blast7
    type: File
    doc: BLAST result file in format 7. May be gzipped.
    inputBinding:
      position: 101
      prefix: --in-blast7
  - id: majority
    type:
      - 'null'
      - float
    doc: The majority required for the reported result. If 0.9, thedeepest path 
      at which 90% of all hits agree will be reported.
    inputBinding:
      position: 101
      prefix: --majority
  - id: ncbi_taxonomy
    type: Directory
    doc: Path to NCBI taxonomy (tree or raw)
    inputBinding:
      position: 101
      prefix: --ncbi-taxonomy
  - id: quorum
    type:
      - 'null'
      - float
    doc: Fraction of all hits that have to be classified to thereported depth. 
      I.e., if 0.9, 90% of all input blast hits for aquery must have been 
      classified to species level for a specieslevel result to be reported.
    inputBinding:
      position: 101
      prefix: --quorum
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output CSV file containing final calls (one row per bin)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
