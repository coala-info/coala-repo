cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux tide-index
label: crux_tide-index
doc: "Create a peptide index for the tide search engine.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: protein_fasta_file
    type: File
    doc: The name of the file in FASTA format from which to retrieve proteins.
    inputBinding:
      position: 1
  - id: index_name
    type: string
    doc: The desired name of the binary index.
    inputBinding:
      position: 2
  - id: allow_dups
    type:
      - 'null'
      - boolean
    doc: Prevent duplicate peptides between the target and decoy databases. When
      set to "F", the program keeps all target and previously generated decoy 
      peptides in memory. A shuffled decoy will be re-shuffled multiple times to
      avoid duplication. If a non-duplicated peptide cannot be generated, the 
      decoy is skipped entirely. When set to "T", every decoy is added to the 
      database without checking for duplication. This option reduces the memory 
      requirements significantly.
    inputBinding:
      position: 103
      prefix: --allow-dups
  - id: clip_nterm_methionine
    type:
      - 'null'
      - boolean
    doc: When set to T, for each protein that begins with methionine, tide-index
      will put two copies of the leading peptide into the index, with and 
      without the N-terminal methionine.
    inputBinding:
      position: 103
      prefix: --clip-nterm-methionine
  - id: cterm_peptide_mods_spec
    type:
      - 'null'
      - string
    doc: 'Specifies C-terminal static and variable mass modifications on peptides.
      Specify a comma-separated list of C-terminal modification sequences of the form:
      X+21.9819'
    inputBinding:
      position: 103
      prefix: --cterm-peptide-mods-spec
  - id: custom_enzyme
    type:
      - 'null'
      - string
    doc: Specify rules for in silico digestion of protein sequences. Overrides 
      the enzyme option. Two lists of residues are given enclosed in square 
      brackets or curly braces and separated by a |. The first list contains 
      residues required/prohibited before the cleavage site and the second list 
      is residues after the cleavage site. If the residues are required for 
      digestion, they are in square brackets, '[' and ']'. If the residues 
      prevent digestion, then they are enclosed in curly braces, '{' and '}'. 
      Use X to indicate all residues. For example, trypsin cuts after R or K but
      not before P which is represented as [RK]|{P}. AspN cuts after any residue
      but only before D which is represented as [X]|[D]. To prevent the 
      sequences from being digested at all, use [Z]|[Z].
    inputBinding:
      position: 103
      prefix: --custom-enzyme
  - id: decoy_format
    type:
      - 'null'
      - string
    doc: Include a decoy version of every peptide by shuffling or reversing the 
      target sequence or protein. In shuffle or peptide-reverse mode, each 
      peptide is either reversed or shuffled, leaving the N-terminal and 
      C-terminal amino acids in place. Note that peptides appear multiple times 
      in the target database are only shuffled once. In peptide-reverse mode, 
      palindromic peptides are shuffled. Also, if a shuffled peptide produces an
      overlap with the target or decoy database, then the peptide is re-shuffled
      up to 5 times. Note that, despite this repeated shuffling, homopolymers 
      will appear in both the target and decoy database. The protein-reverse 
      mode reverses the entire protein sequence, irrespective of the composite 
      peptides.
    inputBinding:
      position: 103
      prefix: --decoy-format
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicate a decoy.
    inputBinding:
      position: 103
      prefix: --decoy-prefix
  - id: digestion
    type:
      - 'null'
      - string
    doc: Specify whether every peptide in the database must have two enzymatic 
      termini (full-digest) or if peptides with only one enzymatic terminus are 
      also included (partial-digest).
    inputBinding:
      position: 103
      prefix: --digestion
  - id: enzyme
    type:
      - 'null'
      - string
    doc: 'Specify the enzyme used to digest the proteins in silico. Available enzymes
      (with the corresponding digestion rules indicated in parentheses) include no-enzyme
      ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin ([FWYL]|{P}),
      elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide ([M]|[]), iodosobenzoate
      ([W]|[]), proline-endopeptidase ([P]|[]), staph-protease ([E]|[]), asp-n ([]|[D]),
      lys-c ([K]|{P}), lys-n ([]|[K]), arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a
      ([FL]|{P}), elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
      no-enzyme yields a non-enzymatic digest. Warning: the resulting index may be
      quite large.'
    inputBinding:
      position: 103
      prefix: --enzyme
  - id: isotopic_mass
    type:
      - 'null'
      - string
    doc: Specify the type of isotopic masses to use when calculating the peptide
      mass.
    inputBinding:
      position: 103
      prefix: --isotopic-mass
  - id: keep_terminal_aminos
    type:
      - 'null'
      - string
    doc: When creating decoy peptides using decoy-format=shuffle or 
      decoy-format=peptide-reverse, this option specifies whether the N-terminal
      and C-terminal amino acids are kept in place or allowed to be shuffled or 
      reversed. For a target peptide "EAMPK" with decoy-format=peptide-reverse, 
      setting keep-terminal-aminos to "NC" will yield "EPMAK"; setting it to "C"
      will yield "PMAEK"; setting it to "N" will yield "EKPMA"; and setting it 
      to "none" will yield "KPMAE".
    inputBinding:
      position: 103
      prefix: --keep-terminal-aminos
  - id: mass_precision
    type:
      - 'null'
      - int
    doc: Set the precision for masses and m/z written to sqt and text files.
    inputBinding:
      position: 103
      prefix: --mass-precision
  - id: max_length
    type:
      - 'null'
      - int
    doc: The maximum length of peptides to consider.
    inputBinding:
      position: 103
      prefix: --max-length
  - id: max_mass
    type:
      - 'null'
      - float
    doc: The maximum mass (in Da) of peptides to consider.
    inputBinding:
      position: 103
      prefix: --max-mass
  - id: max_mods
    type:
      - 'null'
      - int
    doc: The maximum number of modifications that can be applied to a single 
      peptide.
    inputBinding:
      position: 103
      prefix: --max-mods
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of peptides to consider.
    inputBinding:
      position: 103
      prefix: --min-length
  - id: min_mass
    type:
      - 'null'
      - float
    doc: The minimum mass (in Da) of peptides to consider.
    inputBinding:
      position: 103
      prefix: --min-mass
  - id: min_mods
    type:
      - 'null'
      - int
    doc: The minimum number of modifications that can be applied to a single 
      peptide.
    inputBinding:
      position: 103
      prefix: --min-mods
  - id: missed_cleavages
    type:
      - 'null'
      - int
    doc: Maximum number of missed cleavages per peptide to allow in enzymatic 
      digestion.
    inputBinding:
      position: 103
      prefix: --missed-cleavages
  - id: mod_precision
    type:
      - 'null'
      - int
    doc: Set the precision for modifications as written to .txt files.
    inputBinding:
      position: 103
      prefix: --mod-precision
  - id: mods_spec
    type:
      - 'null'
      - string
    doc: 'Expression for static and variable mass modifications to include. Specify
      a comma-separated list of modification sequences of the form: C+57.02146,2M+15.9949,1STY+79.966331,...'
    inputBinding:
      position: 103
      prefix: --mods-spec
  - id: nterm_peptide_mods_spec
    type:
      - 'null'
      - string
    doc: 'Specifies N-terminal static and variable mass modifications on peptides.
      Specify a comma-separated list of N-terminal modification sequences of the form:
      1E-18.0106,C-17.0265'
    inputBinding:
      position: 103
      prefix: --nterm-peptide-mods-spec
  - id: output_dir
    type:
      - 'null'
      - string
    doc: The name of the directory where output files will be created.
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - string
    doc: A file containing parameters.
    inputBinding:
      position: 103
      prefix: --parameter-file
  - id: peptide_list
    type:
      - 'null'
      - boolean
    doc: Create in the output directory a text file listing of all the peptides 
      in the database, along with their neutral masses, one per line. If decoys 
      are generated, then a second file will be created containing the decoy 
      peptides. Decoys that also appear in the target database are marked with 
      an asterisk in a third column.
    inputBinding:
      position: 103
      prefix: --peptide-list
  - id: seed
    type:
      - 'null'
      - string
    doc: When given a unsigned integer value seeds the random number generator 
      with that value. When given the string "time" seeds the random number 
      generator with the system time.
    inputBinding:
      position: 103
      prefix: --seed
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: The name of the directory where temporary files will be created. If 
      this parameter is blank, then the system temporary directory will be used
    inputBinding:
      position: 103
      prefix: --temp-dir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_tide-index.out
