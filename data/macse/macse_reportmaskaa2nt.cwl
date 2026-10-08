cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - reportMaskAA2NT
label: macse_reportmaskaa2nt
doc: "uses a filtered amino acid alignment to filter a nucleotide alignment.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: align
    type: File
    doc: "input FASTA file containing aligned nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -align
  - id: align_AA
    type: File
    doc: "input FASTA file containing aligned amino acid sequences"
    inputBinding:
      position: 102
      prefix: -align_AA
  - id: allow_NT
    type:
      - 'null'
      - string
    doc: "extra nucleotide characters to consider as N (example: -allow_NT \"#?\")"
    inputBinding:
      position: 102
      prefix: -allow_NT
  - id: dist_isolate_AA
    type:
      - 'null'
      - int
    doc: "if the nearest non-gap character is farther away, the residue is considered to be an isolated one and will be removed/masked (-1 no filtering) (default: -1)"
    inputBinding:
      position: 102
      prefix: -dist_isolate_AA
  - id: mask_AA
    type: string
    default: "?"
    doc: "character used to indicate a filtered amino acid"
    inputBinding:
      position: 102
      prefix: -mask_AA
  - id: min_NT_to_keep_seq
    type:
      - 'null'
      - float
    doc: "minimal number of unmasked nucleotides a sequence should have to be kept (number of NT when >1 or fraction of initial sequence alignment length when <=1) (default: 0.0)"
    inputBinding:
      position: 102
      prefix: -min_NT_to_keep_seq
  - id: min_homology_to_keep_seq
    type:
      - 'null'
      - float
    doc: "minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (including non-homologous NT at the beginning/end of the sequence) (default: 0.1)"
    inputBinding:
      position: 102
      prefix: -min_homology_to_keep_seq
  - id: min_internal_homology_to_keep_seq
    type:
      - 'null'
      - float
    doc: "minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (excluding non-homologous NT at the beginning/end of the sequence) (default: 0.5)"
    inputBinding:
      position: 102
      prefix: -min_internal_homology_to_keep_seq
  - id: min_percent_NT_at_ends
    type:
      - 'null'
      - float
    doc: "trims alignmnent by removing sites from the end of the alignment up to the first site for which the percentage of nucleotides is greater than this value (default: 0.0)"
    inputBinding:
      position: 102
      prefix: -min_percent_NT_at_ends
  - id: min_seq_to_keep_site
    type:
      - 'null'
      - int
    doc: "if a site has less non informative characters than this value, this site will be removed (default: 1)"
    inputBinding:
      position: 102
      prefix: -min_seq_to_keep_site
  - id: out_NT
    type: string
    default: "macse_NT.fasta"
    doc: "output FASTA file containing aligned nucleotide sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_NT
  - id: out_mask_detail
    type: string
    default: "macse_mask_detail.fasta"
    doc: "output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE (output file name)"
    inputBinding:
      position: 102
      prefix: -out_mask_detail
outputs:
  - id: out_NT_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing aligned nucleotide sequences"
    outputBinding:
      glob: $(inputs.out_NT)
  - id: out_mask_detail_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE"
    outputBinding:
      glob: $(inputs.out_mask_detail)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
