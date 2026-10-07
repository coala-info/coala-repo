cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crispritz.py
  - search
label: crispritz_search
doc: "Perform searches on a genome (indexed or plain FASTA). A search with -bDNA or
  -bRNA needs an indexed genome directory (.bin files); a mismatch-only search needs
  a FASTA genome directory.\n\nTool homepage: https://github.com/InfOmics/CRISPRitz"
inputs:
  - id: genome_dir
    type: Directory
    doc: Directory containing a genome in .fa or .fasta format (.bin format if 
      bulges present), need to be separated into single chromosome files
    inputBinding:
      position: 1
  - id: pam_file
    type: File
    doc: Text file containing the PAM sequence (including a number of Ns equal 
      to the guide length) and a space separated number indicating the length 
      of the PAM sequence
    inputBinding:
      position: 2
  - id: guides_file
    type: File
    doc: Text file containing one or more guides (including a number of Ns 
      equal to the length of the PAM sequence)
    inputBinding:
      position: 3
  - id: output_name
    type: string
    doc: Name of output file
    inputBinding:
      position: 4
  - id: mismatches
    type: int
    doc: Number of allowed mismatches
    inputBinding:
      position: 5
      prefix: -mm
  - id: bulge_rna
    type:
      - 'null'
      - int
    doc: Size of RNA bulges
    inputBinding:
      position: 5
      prefix: -bRNA
  - id: bulge_dna
    type:
      - 'null'
      - int
    doc: Size of DNA bulges
    inputBinding:
      position: 5
      prefix: -bDNA
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default uses all of the available threads 
      (ONE for bulge search)
    inputBinding:
      position: 5
      prefix: -th
  - id: scores_genome_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the genome in .fa or .fasta format, necessary to 
      extract sequences for Doench Score Function
    inputBinding:
      position: 5
      prefix: -scores
  - id: off_targets_only
    type:
      - 'null'
      - boolean
    doc: Output type -r, off-targets list only
    inputBinding:
      position: 6
      prefix: -r
  - id: profile_only
    type:
      - 'null'
      - boolean
    doc: Output type -p, profile only
    inputBinding:
      position: 6
      prefix: -p
  - id: targets_and_profile
    type:
      - 'null'
      - boolean
    doc: Output type -t, off-targets AND profile
    inputBinding:
      position: 6
      prefix: -t
outputs:
  - id: targets
    type:
      - 'null'
      - File
    doc: Off-targets list
    outputBinding:
      glob: $(inputs.output_name).targets.txt
  - id: result_files
    type:
      type: array
      items: File
    doc: All result files (targets, profiles, extended profile, scores)
    outputBinding:
      glob: $(inputs.output_name)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
