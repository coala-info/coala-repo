cwlVersion: v1.2
class: CommandLineTool
baseCommand: USalign
label: usalign_USalign
doc: "Universal Structure Alignment of Proteins and Nucleic Acids\n\nTool homepage:
  https://zhanggroup.org/US-align"
inputs:
  - id: pdb1
    type: File
    doc: First PDB file
    inputBinding:
      position: 1
  - id: pdb2
    type: File
    doc: Second PDB file
    inputBinding:
      position: 2
  - id: align_hetatm_residues
    type:
      - 'null'
      - int
    doc: "Whether to align residues marked as 'HETATM' in addition to 'ATOM  '. 0:
      (default) only align 'ATOM  ' residues, 1: align both 'ATOM  ' and 'HETATM'
      residues, 2: align both 'ATOM  ' and MSE residues."
    inputBinding:
      position: 103
      prefix: -het
  - id: align_mirror_image
    type:
      - 'null'
      - int
    doc: "Whether to align the mirror image of input structure. 0: (default) do not
      align mirrored structure, 1: align mirror of Structure_1 to origin Structure_2,
      which usually requires the '-het 1' option."
    inputBinding:
      position: 103
      prefix: -mirror
  - id: alignment_fasta_file
    type:
      - 'null'
      - File
    doc: Use the final alignment specified by FASTA file 'align.txt'
    inputBinding:
      position: 103
      prefix: -I
  - id: all_vs_all_alignment_folder
    type:
      - 'null'
      - Directory
    doc: Perform all-against-all alignment among the list of PDB chains listed 
      by 'chain_list' under 'chain_folder'.
    inputBinding:
      position: 103
      prefix: -dir
  - id: atom_name
    type:
      - 'null'
      - string
    doc: 4-character atom name used to represent a residue. Default is " C3'" 
      for RNA/DNA and " CA " for proteins (note the spaces before and after CA).
    inputBinding:
      position: 103
      prefix: -atom
  - id: chain_mapping_file
    type:
      - 'null'
      - File
    doc: (only useful for -mm 1) use the final chain mapping 'chainmap.txt' 
      specified by user. 'chainmap.txt' is a tab-seperated text with two 
      columns, one for each complex
    inputBinding:
      position: 103
      prefix: -chainmap
  - id: chains_structure1
    type:
      - 'null'
      - type: array
        items: string
    doc: Chains to parse in structure_1. Multiple chains can be separated by 
      commas, e.g., USalign -chain1 C,D,E,F 5jdo.pdb -chain2 A,B,C,D 3wtg.pdb 
      -ter 0
    inputBinding:
      position: 103
      prefix: -chain1
  - id: chains_structure2
    type:
      - 'null'
      - type: array
        items: string
    doc: Chains to parse in structure_2. Use _ for a chain without chain ID. 
      Multiple chains can be separated by commas, e.g., USalign -chain1 C,D,E,F 
      5jdo.pdb -chain2 A,B,C,D 3wtg.pdb -ter 0
    inputBinding:
      position: 103
      prefix: -chain2
  - id: do_not_perform_superposition
    type:
      - 'null'
      - boolean
    doc: Do not perform superposition. Useful for extracting alignment from 
      superposed structure pairs.
    inputBinding:
      position: 103
      prefix: -se
  - id: fast_alignment
    type:
      - 'null'
      - boolean
    doc: Fast but slightly inaccurate alignment
    inputBinding:
      position: 103
      prefix: -fast
  - id: file_suffix
    type:
      - 'null'
      - string
    doc: (Only when -dir1 and/or -dir2 are set, default is empty) add file name 
      suffix to files listed by chain1_list or chain2_list
    inputBinding:
      position: 103
      prefix: -suffix
  - id: initial_alignment_file
    type:
      - 'null'
      - File
    doc: Use alignment specified by 'align.txt' as an initial alignment
    inputBinding:
      position: 103
      prefix: -i
  - id: input_format1
    type:
      - 'null'
      - int
    doc: 'Input format for structure_1. -1: (default) automatically detect PDB or
      PDBx/mmCIF format, 0: PDB format, 1: SPICKER format, 3: PDBx/mmCIF format.'
    inputBinding:
      position: 103
      prefix: -infmt1
  - id: input_format2
    type:
      - 'null'
      - int
    doc: 'Input format for structure_2. -1: (default) automatically detect PDB or
      PDBx/mmCIF format, 0: PDB format, 1: SPICKER format, 3: PDBx/mmCIF format.'
    inputBinding:
      position: 103
      prefix: -infmt2
  - id: models_structure1
    type:
      - 'null'
      - type: array
        items: string
    doc: Models to parse in structure_1. Multiple models can be separated by 
      commas, e.g., USalign -model1 1,2 1a03.pdb -model2 3,4 1a0n.pdb -ter 0
    inputBinding:
      position: 103
      prefix: -model1
  - id: models_structure2
    type:
      - 'null'
      - type: array
        items: string
    doc: Models to parse in structure_2. Multiple models can be separated by 
      commas, e.g., USalign -model1 1,2 1a03.pdb -model2 3,4 1a0n.pdb -ter 0
    inputBinding:
      position: 103
      prefix: -model2
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: 'Type of molecule(s) to align. auto: (default) align both protein and nucleic
      acids. prot: only align proteins in a structure. RNA : only align RNA and DNA
      in a structure.'
    inputBinding:
      position: 103
      prefix: -mol
  - id: multimeric_alignment
    type:
      - 'null'
      - int
    doc: "Multimeric alignment option: 0: (default) alignment of two monomeric structures,
      1: alignment of two multi-chain oligomeric structures, 2: alignment of individual
      chains to an oligomeric structure, 3: alignment of circularly permuted structure,
      4: MSTA, i.e., alignment of multiple monomeric chains into a consensus alignment,
      5: fully non-sequential (fNS) alignment, 6: semi-non-sequential (sNS) alignment.
      To use -mm 1 or -mm 2, '-ter' option must be 0 or 1."
    inputBinding:
      position: 103
      prefix: -mm
  - id: num_chains_to_align
    type:
      - 'null'
      - int
    doc: "Number of chains to align. 0: align all chains from all models (recommended
      for aligning biological assemblies, i.e. biounits), 1: align all chains of the
      first model (recommended for aligning asymmetric units, default for -mm 1,2
      and -TMscore 2,6,7), 2: (default for other cases) only align the first chain,
      3: only align the first chain, or the first segment of the first chain as marked
      by the 'TER' string in PDB file."
    inputBinding:
      position: 103
      prefix: -ter
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'Output format. 0: (default) full output, 1: fasta format compact output,
      2: tabular format very compact output, -1: full output, but without version
      or citation information.'
    inputBinding:
      position: 103
      prefix: -outfmt
  - id: perform_tmscore_superposition
    type:
      - 'null'
      - int
    doc: 'Whether to perform TM-score superposition without structure-based alignment.
      The same as -byresi. 0: (default) sequence independent structure alignment,
      1: superpose two structures by assuming that a pair of residues with the same
      residue index are equivalent between the two structures, 2: superpose two complex
      structures, assuming that a pair of residues with the same residue index and
      the same chain ID are equivalent between the two structures, 5: sequence dependent
      alignment: perform glocal sequence alignment followed by TM-score superposition.
      -byresi 5 is the same as -seq, 6: superpose two complex structures by first
      deriving optimal chain mapping, followed by TM-score superposition for residues
      with the same residue ID, 7: sequence dependent alignment of two complex structures:
      perform global sequence alignment of each chain pair, derive optimal chain mapping,
      and then superpose two complex structures by TM-score.'
    inputBinding:
      position: 103
      prefix: -TMscore
  - id: rotation_matrix_output
    type:
      - 'null'
      - File
    doc: Output rotation matrix for superposition, e.g., '-m matrix.txt' prints 
      the matrix to 'matrix.txt'; '-m -' prints to stdout.
    inputBinding:
      position: 103
      prefix: -m
  - id: search_list_folder
    type:
      - 'null'
      - Directory
    doc: Use chain2 to search a list of PDB chains listed by 'chain1_list' under
      'chain1_folder'.
    inputBinding:
      position: 103
      prefix: -dir1
  - id: search_list_folder2
    type:
      - 'null'
      - Directory
    doc: Use chain1 to search a list of PDB chains listed by 'chain2_list' under
      'chain2_folder'.
    inputBinding:
      position: 103
      prefix: -dir2
  - id: show_full_pairwise_alignment
    type:
      - 'null'
      - boolean
    doc: Whether to show full pairwise alignment of individual chains for -mm 2 
      or 4. T or F, (default F).
    inputBinding:
      position: 103
      prefix: -full
  - id: split_pdb
    type:
      - 'null'
      - int
    doc: 'Whether to split PDB file into multiple chains. 0: treat the whole structure
      as one single chain (default for -TMscore 2), 1: treat each MODEL as a separate
      chain, 2: (default for other cases) treat each chain as a separate chain.'
    inputBinding:
      position: 103
      prefix: -split
  - id: tmcut_threshold
    type:
      - 'null'
      - float
    doc: '-1: (default) do not consider TMcut. Values in [0.5,1): Do not proceed with
      TM-align for this structure pair if TM-score is unlikely to reach TMcut. TMcut
      is normalized as set by -a option: -2: normalized by longer structure length,
      -1: normalized by shorter structure length, 0: (default, same as F) normalized
      by second structure, 1: same as T, normalized by average structure length.'
    inputBinding:
      position: 103
      prefix: -TMcut
  - id: tmscore_normalized_avg_length
    type:
      - 'null'
      - boolean
    doc: TM-score normalized by the average length of two structures. T or F, 
      (default F). -a does not change the final alignment.
    inputBinding:
      position: 103
      prefix: -a
  - id: tmscore_normalized_length
    type:
      - 'null'
      - float
    doc: TM-score normalized by an assigned length. It should be >= length of 
      protein to avoid TM-score >1. -u does not change final alignment.
    inputBinding:
      position: 103
      prefix: -u
  - id: tmscore_scaled_d0
    type:
      - 'null'
      - float
    doc: TM-score scaled by an assigned d0, e.g., '-d 3.5' reports MaxSub score,
      where d0 is 3.5 Angstrom. -d does not change final alignment.
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: output_superposed_structure1
    type:
      - 'null'
      - File
    doc: Output superposed structure1 to sup.* for PyMOL viewing.
    outputBinding:
      glob: $(inputs.output_superposed_structure1)
  - id: output_superposed_structure1_rasmol
    type:
      - 'null'
      - File
    doc: Output superposed structure1 to sup.* for RasMol viewing.
    outputBinding:
      glob: $(inputs.output_superposed_structure1_rasmol)
  - id: output_superposed_structure1_chimerax
    type:
      - 'null'
      - File
    doc: Output superposed structure1 to sup.* for ChimeraX viewing.
    outputBinding:
      glob: $(inputs.output_superposed_structure1_chimerax)
  - id: output_aligned_residue_distances
    type:
      - 'null'
      - File
    doc: Output distance of aligned residue pairs
    outputBinding:
      glob: $(inputs.output_aligned_residue_distances)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
