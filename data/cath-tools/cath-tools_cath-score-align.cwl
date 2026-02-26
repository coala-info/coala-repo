cwlVersion: v1.2
class: CommandLineTool
baseCommand: cath-score-align
label: cath-tools_cath-score-align
doc: "Score an existing alignment using structural data\n\nTool homepage: https://github.com/UCLOrengoGroup/cath-tools"
inputs:
  - id: alignment_source
    type: string
    doc: Alignment source
    inputBinding:
      position: 1
  - id: protein_file_source
    type: string
    doc: Protein file source
    inputBinding:
      position: 2
  - id: superposition_outputs
    type:
      - 'null'
      - type: array
        items: string
    doc: Superposition outputs
    inputBinding:
      position: 3
  - id: align_refining
    type:
      - 'null'
      - string
    doc: "Apply refining to the alignment, one of available values: NO - Don't refine
      the alignment, LIGHT - Refine any alignments with few entries; glue alignments
      one more entry at a time, HEAVY - Perform heavy (slow) refining on the alignment,
      including when gluing alignments together. This can change the method of gluing
      alignments under --ssap-scores-infile and --do-the-ssaps"
    default: NO
    inputBinding:
      position: 104
      prefix: --align-refining
  - id: cora_aln_infile
    type:
      - 'null'
      - File
    doc: Read CORA alignment from file
    inputBinding:
      position: 104
      prefix: --cora-aln-infile
  - id: do_the_ssaps
    type:
      - 'null'
      - Directory
    doc: Do the required SSAPs in directory; use results as with 
      --ssap-scores-infile. Use a suitable temp directory if none is specified
    default: '""'
    inputBinding:
      position: 104
      prefix: --do-the-ssaps
  - id: fasta_aln_infile
    type:
      - 'null'
      - File
    doc: Read FASTA alignment from file
    inputBinding:
      position: 104
      prefix: --fasta-aln-infile
  - id: pdb_infile
    type:
      - 'null'
      - type: array
        items: File
    doc: Read PDB from file (may be specified multiple times)
    inputBinding:
      position: 104
      prefix: --pdb-infile
  - id: pdbs_from_stdin
    type:
      - 'null'
      - boolean
    doc: 'Read PDBs from stdin (separated by line: "END   ")'
    inputBinding:
      position: 104
      prefix: --pdbs-from-stdin
  - id: res_name_align
    type:
      - 'null'
      - boolean
    doc: Align residues by simply matching their names (numbers+insert) (for 
      multiple models of the same structure)
    inputBinding:
      position: 104
      prefix: --res-name-align
  - id: ssap_aln_infile
    type:
      - 'null'
      - File
    doc: Read SSAP alignment from file
    inputBinding:
      position: 104
      prefix: --ssap-aln-infile
  - id: ssap_scores_infile
    type:
      - 'null'
      - File
    doc: Glue pairwise alignments together using SSAP scores in file. Assumes 
      all .list alignment files in same directory
    inputBinding:
      position: 104
      prefix: --ssap-scores-infile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
stdout: cath-tools_cath-score-align.out
