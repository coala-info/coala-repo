cwlVersion: v1.2
class: CommandLineTool
baseCommand: cath-superpose
label: cath-tools_cath-superpose
doc: "Superpose protein structures using an existing alignment\n\nTool homepage: https://github.com/UCLOrengoGroup/cath-tools"
inputs:
  - id: alignment_source
    type: string
    doc: Alignment source
    inputBinding:
      position: 1
  - id: pdb_file_source
    type: string
    doc: PDB file source
    inputBinding:
      position: 2
  - id: superposition_outputs
    type:
      - 'null'
      - string
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
    inputBinding:
      position: 104
      prefix: --align-refining
  - id: align_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Handle region(s) as the alignment part of the structure. May be specified
      multiple times, in correspondence with the structures. Format is: D[5inwB02]251-348:B,408-416A:B
      (Put <regions> in quotes to prevent the square brackets confusing your shell
      ("No match"))'
    inputBinding:
      position: 104
      prefix: --align-regions
  - id: aln_to_cath_aln_file
    type:
      - 'null'
      - File
    doc: '[EXPERIMENTAL] Write the alignment to a CATH alignment file'
    inputBinding:
      position: 104
      prefix: --aln-to-cath-aln-file
  - id: aln_to_cath_aln_stdout
    type:
      - 'null'
      - boolean
    doc: '[EXPERIMENTAL] Print the alignment to stdout in CATH alignment format'
    inputBinding:
      position: 104
      prefix: --aln-to-cath-aln-stdout
  - id: aln_to_fasta_file
    type:
      - 'null'
      - File
    doc: Write the alignment to a FASTA file
    inputBinding:
      position: 104
      prefix: --aln-to-fasta-file
  - id: aln_to_fasta_stdout
    type:
      - 'null'
      - boolean
    doc: Print the alignment to stdout in FASTA format
    inputBinding:
      position: 104
      prefix: --aln-to-fasta-stdout
  - id: aln_to_html_file
    type:
      - 'null'
      - File
    doc: Write the alignment to a HTML file
    inputBinding:
      position: 104
      prefix: --aln-to-html-file
  - id: aln_to_html_stdout
    type:
      - 'null'
      - boolean
    doc: Print the alignment to stdout as HTML
    inputBinding:
      position: 104
      prefix: --aln-to-html-stdout
  - id: aln_to_ssap_file
    type:
      - 'null'
      - File
    doc: Write the alignment to a SSAP file
    inputBinding:
      position: 104
      prefix: --aln-to-ssap-file
  - id: aln_to_ssap_stdout
    type:
      - 'null'
      - boolean
    doc: Print the alignment to stdout as SSAP
    inputBinding:
      position: 104
      prefix: --aln-to-ssap-stdout
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
  - id: gradient_colour_alignment
    type:
      - 'null'
      - boolean
    doc: Colour the length of the alignment with a rainbow gradient (blue -> 
      red)
    inputBinding:
      position: 104
      prefix: --gradient-colour-alignment
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: Structure ids
    inputBinding:
      position: 104
      prefix: --id
  - id: json_sup_infile
    type:
      - 'null'
      - File
    doc: Read superposition from file
    inputBinding:
      position: 104
      prefix: --json-sup-infile
  - id: normalise_scores
    type:
      - 'null'
      - boolean
    doc: When showing scores, normalise them to the highest score in the 
      alignment (use with --gradient-colour-alignment and 
      --show-scores-if-present)
    inputBinding:
      position: 104
      prefix: --normalise-scores
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
  - id: pymol_program
    type:
      - 'null'
      - string
    doc: Use as the PyMOL executable for viewing; may optionally include the 
      full path
    inputBinding:
      position: 104
      prefix: --pymol-program
  - id: regions_context
    type:
      - 'null'
      - string
    doc: 'Show the alignment regions in the context, one of available options: alone
      - alone, in_chain - within the chain(s) in which the regions appear, in_pdb
      - within the PDB in which the regions appear'
    inputBinding:
      position: 104
      prefix: --regions-context
  - id: res_name_align
    type:
      - 'null'
      - boolean
    doc: Align residues by simply matching their names (numbers+insert) (for 
      multiple models of the same structure)
    inputBinding:
      position: 104
      prefix: --res-name-align
  - id: scores_to_equivs
    type:
      - 'null'
      - boolean
    doc: Show the alignment scores to equivalent positions, which increases 
      relative scores where few entries are aligned (use with 
      --gradient-colour-alignment and --show-scores-if-present)
    inputBinding:
      position: 104
      prefix: --scores-to-equivs
  - id: show_dna_within_dist
    type:
      - 'null'
      - float
    doc: Show DNA within distance of the alignment regions
    inputBinding:
      position: 104
      prefix: --show-dna-within-dist
  - id: show_organic_within_dist
    type:
      - 'null'
      - float
    doc: Show organic molecules within distance of the alignment regions
    inputBinding:
      position: 104
      prefix: --show-organic-within-dist
  - id: show_scores_if_present
    type:
      - 'null'
      - boolean
    doc: Show the alignment scores (use with gradient-colour-alignment)
    inputBinding:
      position: 104
      prefix: --show-scores-if-present
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
  - id: sup_to_pymol
    type:
      - 'null'
      - boolean
    doc: Start up PyMOL for viewing the superposition
    inputBinding:
      position: 104
      prefix: --sup-to-pymol
  - id: viewer_colours
    type:
      - 'null'
      - string
    doc: 'Use to colour successive entries in the viewer (format: colon-separated
      list of comma-separated triples of RGB values between 0 and 1) (will wrap-around
      when it runs out of colours)'
    inputBinding:
      position: 104
      prefix: --viewer-colours
outputs:
  - id: sup_to_pdb_file
    type:
      - 'null'
      - File
    doc: Write the superposed structures to a single PDB file, separated using 
      faked chain codes
    outputBinding:
      glob: $(inputs.sup_to_pdb_file)
  - id: sup_to_pdb_files_dir
    type:
      - 'null'
      - Directory
    doc: Write the superposed structures to separate PDB files in directory
    outputBinding:
      glob: $(inputs.sup_to_pdb_files_dir)
  - id: sup_to_stdout
    type:
      - 'null'
      - File
    doc: Print the superposed structures to stdout, separated using faked chain 
      codes
    outputBinding:
      glob: $(inputs.sup_to_stdout)
  - id: sup_to_pymol_file
    type:
      - 'null'
      - File
    doc: 'Write the superposition to a PyMOL script. (Recommended filename extension:
      .pml)'
    outputBinding:
      glob: $(inputs.sup_to_pymol_file)
  - id: sup_to_json_file
    type:
      - 'null'
      - File
    doc: 'Write the superposition to JSON superposition file. (Recommended filename
      extension: .sup_json)'
    outputBinding:
      glob: $(inputs.sup_to_json_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
