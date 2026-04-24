cwlVersion: v1.2
class: CommandLineTool
baseCommand: alv
label: alv
doc: "Alignment Viewer (alv) - a tool for viewing and analyzing sequence alignments
  in the terminal.\n\nTool homepage: https://github.com/arvestad/alv"
inputs:
  - id: infile
    type:
      - 'null'
      - File
    doc: The infile is the path to a file, or '-' if reading from stdin.
    inputBinding:
      position: 1
  - id: acc_abbreviate
    type:
      - 'null'
      - int
    doc: Keep only the first N and last N characters of the accession
    inputBinding:
      position: 102
      prefix: --acc-abbreviate
  - id: acc_substring
    type:
      - 'null'
      - type: array
        items: int
    doc: Specify what substring of an accession to keep. '-as 10 15' discards all
      but position 10 to 14 in any accession.
    inputBinding:
      position: 102
      prefix: --acc-substring
  - id: alignment_index
    type:
      - 'null'
      - int
    doc: 'If reading file with many alignments, choose which one to output with this
      zero-based index. Default: first alignment in file.'
    inputBinding:
      position: 102
      prefix: --alignment-index
  - id: cite
    type:
      - 'null'
      - boolean
    doc: 'Write citation example: plain text and a BibTeX item.'
    inputBinding:
      position: 102
      prefix: --cite
  - id: code
    type:
      - 'null'
      - int
    doc: Genetic code to use, based on NCBI's code list.
    inputBinding:
      position: 102
      prefix: --code
  - id: color_scheme
    type:
      - 'null'
      - string
    doc: Color scheme for AA and coding DNA/RNA. The clustal coloring scheme is an
      approximation of the original, due to the limited color choices for consoles.
      The "hydrophobicity" gives red to hydrophobic, blue to polar, and green to charged
      residues.
    inputBinding:
      position: 102
      prefix: --color-scheme
  - id: dotted
    type:
      - 'null'
      - boolean
    doc: Let the first sequence in output alignment be a template and, for other sequences,
      show identity to template using a period. Useful for alignments with high similarity.
    inputBinding:
      position: 102
      prefix: --dotted
  - id: format
    type:
      - 'null'
      - string
    doc: Specify what sequence type to assume. Be specific if the file is not recognized
      automatically. When reading from stdin, the format is always guessed to be FASTA.
    inputBinding:
      position: 102
      prefix: --format
  - id: glimpse
    type:
      - 'null'
      - boolean
    doc: Give a glimpse of an alignment. If the alignment fits without any scrolling
      and without line breaks, then just view the alignment. Otherwise, identify a
      conserved part of the MSA and show a random sample of the sequences that fits
      the screen.
    inputBinding:
      position: 102
      prefix: --glimpse
  - id: info
    type:
      - 'null'
      - boolean
    doc: Append basic information about the alignment at the end.
    inputBinding:
      position: 102
      prefix: --info
  - id: just_info
    type:
      - 'null'
      - boolean
    doc: Write basic information about the alignment and exit.
    inputBinding:
      position: 102
      prefix: --just-info
  - id: keep_colors_when_redirecting
    type:
      - 'null'
      - boolean
    doc: Do not strip colors when redirecting to stdout, or similar. In particular
      useful with the command 'less -R'.
    inputBinding:
      position: 102
      prefix: --keep-colors-when-redirecting
  - id: list_codes
    type:
      - 'null'
      - boolean
    doc: List the available genetic codes and exit.
    inputBinding:
      position: 102
      prefix: --list-codes
  - id: majority
    type:
      - 'null'
      - boolean
    doc: Only color those column where the most common amino acid is found in 50 percent
      of sequences.
    inputBinding:
      position: 102
      prefix: --majority
  - id: method
    type:
      - 'null'
      - boolean
    doc: Write a suggested text to add to a methods section.
    inputBinding:
      position: 102
      prefix: --method
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: Only color column without indels.
    inputBinding:
      position: 102
      prefix: --no-indels
  - id: only_variable
    type:
      - 'null'
      - boolean
    doc: Only color columns that contain variation.
    inputBinding:
      position: 102
      prefix: --only-variable
  - id: only_variable_excluding_indels
    type:
      - 'null'
      - boolean
    doc: Only color columns that contain variation, ignoring indels.
    inputBinding:
      position: 102
      prefix: --only-variable-excluding-indels
  - id: pipe_to_less
    type:
      - 'null'
      - boolean
    doc: Do not break the alignment into blocks. Implies -k. Suitable when piping
      to commands like 'less -RS'.
    inputBinding:
      position: 102
      prefix: --pipe-to-less
  - id: random_accessions
    type:
      - 'null'
      - int
    doc: Only view a random sample of the alignment sequences.
    inputBinding:
      position: 102
      prefix: --random-accessions
  - id: select_matching
    type:
      - 'null'
      - string
    doc: Only show sequences with accessions containing ACCESSION_PATTERN.
    inputBinding:
      position: 102
      prefix: --select-matching
  - id: sort_by_id
    type:
      - 'null'
      - string
    doc: Sort the output alignment by similarity (percent identity) to named sequence.
      Overrides -s.
    inputBinding:
      position: 102
      prefix: --sort-by-id
  - id: sorting
    type:
      - 'null'
      - string
    doc: Sort the sequences as given in the infile or alphabetically (by accession).
    inputBinding:
      position: 102
      prefix: --sorting
  - id: sorting_order
    type:
      - 'null'
      - string
    doc: Comma-separated list of accessions. Sequences will be presented in this order.
      Also note that one can choose which sequences to present with this opion. Overrides
      -s and -si.
    inputBinding:
      position: 102
      prefix: --sorting-order
  - id: type
    type:
      - 'null'
      - string
    doc: Specify what sequence type to assume. Coding DNA/RNA is assumed with the
      'codon' option. Guessing the format only chooses between 'aa' and 'dna', but
      assumes the standard genetic code.
    inputBinding:
      position: 102
      prefix: --type
  - id: width
    type:
      - 'null'
      - int
    doc: Width of alignment blocks. Defaults to terminal width minus accession width,
      essentially.
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alv:1.7.2--pyhdfd78af_0
stdout: alv.out
