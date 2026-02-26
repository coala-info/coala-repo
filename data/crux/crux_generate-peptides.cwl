cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux generate-peptides
label: crux_generate-peptides
doc: "Generate peptides from a protein FASTA file.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: protein_fasta_file
    type: File
    doc: The name of the file in FASTA format from which to retrieve proteins.
    inputBinding:
      position: 1
  - id: clip_nterm_methionine
    type:
      - 'null'
      - string
    doc: When set to T, for each protein that begins with methionine, tide-index
      will put two copies of the leading peptide into the index, with and 
      without the N-terminal methionine.
    default: 'false'
    inputBinding:
      position: 102
      prefix: --clip-nterm-methionine
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
    default: ''
    inputBinding:
      position: 102
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
    default: shuffle
    inputBinding:
      position: 102
      prefix: --decoy-format
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicate a decoy.
    default: decoy_
    inputBinding:
      position: 102
      prefix: --decoy-prefix
  - id: digestion
    type:
      - 'null'
      - string
    doc: Specify whether every peptide in the database must have two enzymatic 
      termini (full-digest) or if peptides with only one enzymatic terminus are 
      also included (partial-digest).
    default: full-digest
    inputBinding:
      position: 102
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
    default: trypsin
    inputBinding:
      position: 102
      prefix: --enzyme
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    default: ''
    inputBinding:
      position: 102
      prefix: --fileroot
  - id: isotopic_mass
    type:
      - 'null'
      - string
    doc: Specify the type of isotopic masses to use when calculating the peptide
      mass.
    default: mono
    inputBinding:
      position: 102
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
    default: NC
    inputBinding:
      position: 102
      prefix: --keep-terminal-aminos
  - id: max_length
    type:
      - 'null'
      - int
    doc: The maximum length of peptides to consider.
    default: 50
    inputBinding:
      position: 102
      prefix: --max-length
  - id: max_mass
    type:
      - 'null'
      - float
    doc: The maximum mass (in Da) of peptides to consider.
    default: 7200.0
    inputBinding:
      position: 102
      prefix: --max-mass
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of peptides to consider.
    default: 6
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_mass
    type:
      - 'null'
      - float
    doc: The minimum mass (in Da) of peptides to consider.
    default: 200.0
    inputBinding:
      position: 102
      prefix: --min-mass
  - id: missed_cleavages
    type:
      - 'null'
      - int
    doc: Maximum number of missed cleavages per peptide to allow in enzymatic 
      digestion.
    default: 0
    inputBinding:
      position: 102
      prefix: --missed-cleavages
  - id: mod_precision
    type:
      - 'null'
      - int
    doc: Set the precision for modifications as written to .txt files.
    default: 2
    inputBinding:
      position: 102
      prefix: --mod-precision
  - id: output_dir
    type:
      - 'null'
      - string
    doc: The name of the directory where output files will be created.
    default: crux-output
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - string
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    default: 'false'
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - string
    doc: A file containing parameters.
    default: ''
    inputBinding:
      position: 102
      prefix: --parameter-file
  - id: seed
    type:
      - 'null'
      - string
    doc: When given a unsigned integer value seeds the random number generator 
      with that value. When given the string "time" seeds the random number 
      generator with the system time.
    default: '1'
    inputBinding:
      position: 102
      prefix: --seed
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    default: 30
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_generate-peptides.out
