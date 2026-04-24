cwlVersion: v1.2
class: CommandLineTool
baseCommand: cath-ssap
label: cath-tools_cath-ssap
doc: "Run a SSAP pairwise structural alignment\n\nTool homepage: https://github.com/UCLOrengoGroup/cath-tools"
inputs:
  - id: protein1
    type: string
    doc: First protein identifier
    inputBinding:
      position: 1
  - id: protein2
    type: string
    doc: Second protein identifier
    inputBinding:
      position: 2
  - id: align_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Handle region(s) <regions> as the alignment part of the structure. May be
      specified multiple times, in correspondence with the structures. Format is:
      D[5inwB02]251-348:B,408-416A:B (Put <regions> in quotes to prevent the square
      brackets confusing your shell ("No match"))'
    inputBinding:
      position: 103
      prefix: --align-regions
  - id: aligndir
    type:
      - 'null'
      - Directory
    doc: Write alignment to directory <dir>
    inputBinding:
      position: 103
      prefix: --aligndir
  - id: alignment_help
    type:
      - 'null'
      - boolean
    doc: Help on alignment format
    inputBinding:
      position: 103
      prefix: --alignment-help
  - id: all_scores
    type:
      - 'null'
      - boolean
    doc: '[DEPRECATED] Output all SSAP scores from fast and slow runs, not just the
      highest'
    inputBinding:
      position: 103
      prefix: --all-scores
  - id: citation_help
    type:
      - 'null'
      - boolean
    doc: Help on SSAP authorship & how to cite it
    inputBinding:
      position: 103
      prefix: --citation-help
  - id: clique_file
    type:
      - 'null'
      - File
    doc: Read clique from <file>
    inputBinding:
      position: 103
      prefix: --clique-file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information
    inputBinding:
      position: 103
      prefix: --debug
  - id: domin_file
    type:
      - 'null'
      - File
    doc: Read domin from <file>
    inputBinding:
      position: 103
      prefix: --domin-file
  - id: dssp_path
    type:
      - 'null'
      - Directory
    doc: Search for DSSP files using the path <path>
    inputBinding:
      position: 103
      prefix: --dssp-path
  - id: dssp_prefix
    type:
      - 'null'
      - string
    doc: Prepend the prefix <pre> to a protein's name to form its DSSP filename
    inputBinding:
      position: 103
      prefix: --dssp-prefix
  - id: dssp_suffix
    type:
      - 'null'
      - string
    doc: Append the suffix <suf> to a protein's name to form its DSSP filename
    inputBinding:
      position: 103
      prefix: --dssp-suffix
  - id: local_ssap_score
    type:
      - 'null'
      - boolean
    doc: '[DEPRECATED] Normalise the SSAP score over the length of the smallest domain
      rather than the largest'
    inputBinding:
      position: 103
      prefix: --local-ssap-score
  - id: max_score_to_fast_rerun
    type:
      - 'null'
      - float
    doc: Run a second fast SSAP with looser cutoffs if the first fast SSAP's 
      score falls below <score>
    inputBinding:
      position: 103
      prefix: --max-score-to-fast-rerun
  - id: max_score_to_slow_rerun
    type:
      - 'null'
      - float
    doc: Perform a slow SSAP if the (best) fast SSAP score falls below <score>
    inputBinding:
      position: 103
      prefix: --max-score-to-slow-rerun
  - id: min_score_for_files
    type:
      - 'null'
      - float
    doc: Only output alignment/superposition files if the SSAP score exceeds 
      <score>
    inputBinding:
      position: 103
      prefix: --min-score-for-files
  - id: min_sup_score
    type:
      - 'null'
      - float
    doc: '[DEPRECATED] Calculate superposition based on the residue-pairs with scores
      greater than <score>'
    inputBinding:
      position: 103
      prefix: --min-sup-score
  - id: pdb_path
    type:
      - 'null'
      - Directory
    doc: Search for PDB files using the path <path>
    inputBinding:
      position: 103
      prefix: --pdb-path
  - id: pdb_prefix
    type:
      - 'null'
      - string
    doc: Prepend the prefix <pre> to a protein's name to form its PDB filename
    inputBinding:
      position: 103
      prefix: --pdb-prefix
  - id: pdb_suffix
    type:
      - 'null'
      - string
    doc: Append the suffix <suf> to a protein's name to form its PDB filename
    inputBinding:
      position: 103
      prefix: --pdb-suffix
  - id: prot_src_files
    type:
      - 'null'
      - string
    doc: 'Read the protein data from the set of files <set>, of available sets: PDB,
      PDB_DSSP, PDB_DSSP_SEC, WOLF_SEC'
    inputBinding:
      position: 103
      prefix: --prot-src-files
  - id: rasmol_script
    type:
      - 'null'
      - boolean
    doc: '[DEPRECATED] Write a rasmol superposition script to load and colour the
      superposed structures'
    inputBinding:
      position: 103
      prefix: --rasmol-script
  - id: scores_help
    type:
      - 'null'
      - boolean
    doc: Help on scores format
    inputBinding:
      position: 103
      prefix: --scores-help
  - id: sec_path
    type:
      - 'null'
      - Directory
    doc: Search for sec files using the path <path>
    inputBinding:
      position: 103
      prefix: --sec-path
  - id: sec_prefix
    type:
      - 'null'
      - string
    doc: Prepend the prefix <pre> to a protein's name to form its sec filename
    inputBinding:
      position: 103
      prefix: --sec-prefix
  - id: sec_suffix
    type:
      - 'null'
      - string
    doc: Append the suffix <suf> to a protein's name to form its sec filename
    inputBinding:
      position: 103
      prefix: --sec-suffix
  - id: slow_ssap_only
    type:
      - 'null'
      - boolean
    doc: Don't try any fast SSAPs; only use slow SSAP
    inputBinding:
      position: 103
      prefix: --slow-ssap-only
  - id: supdir
    type:
      - 'null'
      - Directory
    doc: '[DEPRECATED] Output a superposition to directory <dir>'
    inputBinding:
      position: 103
      prefix: --supdir
  - id: wolf_path
    type:
      - 'null'
      - Directory
    doc: Search for wolf files using the path <path>
    inputBinding:
      position: 103
      prefix: --wolf-path
  - id: wolf_prefix
    type:
      - 'null'
      - string
    doc: Prepend the prefix <pre> to a protein's name to form its wolf filename
    inputBinding:
      position: 103
      prefix: --wolf-prefix
  - id: wolf_suffix
    type:
      - 'null'
      - string
    doc: Append the suffix <suf> to a protein's name to form its wolf filename
    inputBinding:
      position: 103
      prefix: --wolf-suffix
  - id: xmlsup
    type:
      - 'null'
      - boolean
    doc: '[DEPRECATED] Write a small xml superposition file, from which a larger superposition
      file can be reconstructed'
    inputBinding:
      position: 103
      prefix: --xmlsup
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: '[DEPRECATED] Output scores to <file> rather than to stdout'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
