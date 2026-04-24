cwlVersion: v1.2
class: CommandLineTool
baseCommand: belvu
label: belvu
doc: "View multiple alignments in pretty colours.\n\nTool homepage: https://github.com/nathanhaigh/docker-seqtools"
inputs:
  - id: multiple_alignment
    type: File
    doc: file or pipe in Stockholm/Selex/MSF/Fasta format (see below).
    inputBinding:
      position: 1
  - id: bootstrap_samples
    type:
      - 'null'
      - int
    doc: Apply boostrap analysis with <n> bootstrap samples
    inputBinding:
      position: 102
      prefix: -b
  - id: conservation_table
    type:
      - 'null'
      - boolean
    doc: Print Conservation table.
    inputBinding:
      position: 102
      prefix: -c
  - id: gappy_column_cutoff
    type:
      - 'null'
      - float
    doc: Remove columns more gappy than <cutoff>.
    inputBinding:
      position: 102
      prefix: -Q
  - id: gappy_sequence_cutoff
    type:
      - 'null'
      - float
    doc: Remove sequences more gappy than <cutoff>.
    inputBinding:
      position: 102
      prefix: -q
  - id: ignore_gaps_conservation
    type:
      - 'null'
      - boolean
    doc: Ignore gaps in conservation calculation.
    inputBinding:
      position: 102
      prefix: -i
  - id: markup_organism_color_code_file
    type:
      - 'null'
      - File
    doc: "Load markup and organism color code file.\n             Colour the markup
      text by residue or colour organism in tree.\n\n\t     Example to set color of
      letters A and B:\n\t     A GREEN\n\t     B YELLOW\n\n\t     Example to set color
      of organism human:\n\t     #=OS BLUE human"
    inputBinding:
      position: 102
      prefix: -L
  - id: matching_sequences_segments_file
    type:
      - 'null'
      - File
    doc: "Read file with matching sequences segments. This is used to\n          \
      \    display a match of  a query sequence to a family.  The format\n       \
      \       of the match is :\n\n              Line 1: Name/start-end score\n  \
      \            Line 2: Query sequence in matching segment, no pads!\n        \
      \      Line 3: Sequence of matching segments (qstart1 qend1 fstart1\n      \
      \        fend2 qstart2 qend2 fstart2 fend2  etc...). \n\n              Example:\n\
      \n              ZK673.9/238-260 21.58\n              CPENWVQFTGNGTQYGVCLRGFT\n\
      \              1 2 1 2  4 7 8 11  \n\n              NOTE: A sometimes easier
      way of doing this is to concatenate\n              the match to the end of the
      alignment, after a line with\n              exactly this string within the quotes:
      # matchFooter"
    inputBinding:
      position: 102
      prefix: -m
  - id: no_coordinate_parsing
    type:
      - 'null'
      - boolean
    doc: Do not parse coordinates when reading alignment.
    inputBinding:
      position: 102
      prefix: -R
  - id: no_coordinates_to_file
    type:
      - 'null'
      - boolean
    doc: Don't write coordinates to saved file.
    inputBinding:
      position: 102
      prefix: -C
  - id: non_redundant_cutoff
    type:
      - 'null'
      - float
    doc: Make non-redundant to <cutoff> %identity at startup.
    inputBinding:
      position: 102
      prefix: -n
  - id: organism_info_label
    type:
      - 'null'
      - string
    doc: Read organism info after this label (default OS)
    inputBinding:
      position: 102
      prefix: -O
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Write alignment or tree to stdout in this format and exit.\n           \
      \     Valid formats: Mul(Stockholm), Selex, MSF, \n                FastaAlign,
      Fasta, tree."
    inputBinding:
      position: 102
      prefix: -o
  - id: output_hmmr_probabilities
    type:
      - 'null'
      - boolean
    doc: "Output random model probabilites for HMMER.\n              (Based on all
      residues.)"
    inputBinding:
      position: 102
      prefix: -p
  - id: penalize_gaps
    type:
      - 'null'
      - boolean
    doc: Penalize gaps in pairwise comparisons.
    inputBinding:
      position: 102
      prefix: -G
  - id: print_bootstrap_trees
    type:
      - 'null'
      - boolean
    doc: "Print out bootstrap trees and exit\n              (Negative value -> display
      bootstrap trees on screen)"
    inputBinding:
      position: 102
      prefix: -B
  - id: raw_format
    type:
      - 'null'
      - boolean
    doc: "Read alignment in 'raw' format (Name sequence).\n\n              Example
      of raw alignment file: \n\n                  seq1_name MFILKTP\n           \
      \       seq1_name MYI.RTP"
    inputBinding:
      position: 102
      prefix: -r
  - id: remove_partial_sequences
    type:
      - 'null'
      - boolean
    doc: Remove partial sequences at startup.
    inputBinding:
      position: 102
      prefix: -P
  - id: residue_color_code_file
    type:
      - 'null'
      - File
    doc: "Load residue color code file.\n\n              Format: <symbol> <color>\n\
      \              (Lines starting with # are ignored (comment lines))\n\n     \
      \         Example of color code file:\n\n                  # Aroma\n       \
      \           F YELLOW\n                  Y YELLOW\n                  W YELLOW\n\
      \n                  # Yuck\n                  D RED \n                  N GREEN\n\
      \                  X BLUE\n\n              Available colors:\n\n           \
      \         WHITE \n                    BLACK \n                    LIGHTGRAY\n\
      \                    DARKGRAY\n                    RED \n                  \
      \  GREEN\n                    BLUE\n                    YELLOW\n           \
      \         CYAN \n                    MAGENTA\n                    LIGHTRED \n\
      \                    LIGHTGREEN \n                    LIGHTBLUE\n          \
      \          DARKRED \n                    DARKGREEN \n                    DARKBLUE\n\
      \                    PALERED \n                    PALEGREEN \n            \
      \        PALEBLUE\n                    PALEYELLOW \n                    PALECYAN\
      \ \n                    PALEMAGENTA\n                    BROWN \n          \
      \          ORANGE \n                    PALEORANGE\n                    PURPLE\
      \ \n                    VIOLET \n                    PALEVIOLET\n          \
      \          GRAY \n                    PALEGRAY\n                    CERISE \n\
      \                    MIDBLUE"
    inputBinding:
      position: 102
      prefix: -l
  - id: scores_file
    type:
      - 'null'
      - File
    doc: "Read in file of scores.A column with scores will\n              automatically
      appear after the coordinates.\n\n              Format: <score> <sequence_id>\n\
      \n              Example of score file:\n\n                  2.78 seq_1/180-206\n\
      \                  2.78 seq_2/180-206\n                  3.79 seq_3/42-94"
    inputBinding:
      position: 102
      prefix: -s
  - id: separator_char
    type:
      - 'null'
      - string
    doc: Separator char between name and coordinates in saved file.
    inputBinding:
      position: 102
      prefix: -z
  - id: sequence_order
    type:
      - 'null'
      - string
    doc: "Sort sequences in this order.\n                a -> alphabetically\n   \
      \             o -> by Swissprot organism, alphabetically\n                s
      -> by score\n                n -> by Neighbor-joining tree\n               \
      \ u -> by UPGMA tree\n                S -> by similarity to first sequence\n\
      \                i -> by identity to first sequence"
    inputBinding:
      position: 102
      prefix: -S
  - id: show_alignment_annotations
    type:
      - 'null'
      - boolean
    doc: Show alignment annotations on screen (Stockholm format only).
    inputBinding:
      position: 102
      prefix: -a
  - id: tree_options
    type:
      - 'null'
      - string
    doc: "Tree options:\n                i -> Start up showing tree\n            \
      \    I -> Start up showing only tree\n                d -> Show distances in
      tree\n                n -> Neighbor-joining\n                u -> UPGMA\n  \
      \              c -> Don't color tree by organism\n                o -> Don't
      display sequence coordinates in tree\n                b -> Use Scoredist distance
      correction (default)\n                j -> Use Jukes-Cantor distance correction\n\
      \                k -> Use Kimura distance correction\n                s -> Use
      Storm & Sonnhammer distance correction\n                r -> Use uncorrected
      distances\n                p -> Print distance matrix and exit\n           \
      \     R -> Read distance matrix instead of alignment\n                     (only
      in combination with Tree routines)"
    inputBinding:
      position: 102
      prefix: -T
  - id: uncoloured_alignment
    type:
      - 'null'
      - boolean
    doc: Start up with uncoloured alignment (faster).
    inputBinding:
      position: 102
      prefix: -u
  - id: upgma_cutoff
    type:
      - 'null'
      - float
    doc: Print UPGMA-based subfamilies at cutoff <cutoff>.
    inputBinding:
      position: 102
      prefix: -X
  - id: window_title
    type:
      - 'null'
      - string
    doc: Set window title.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/belvu:v4.44.1dfsg-3-deb_cv1
stdout: belvu.out
