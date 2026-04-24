cwlVersion: v1.2
class: CommandLineTool
baseCommand: snipit
label: snipit
doc: "snipit\n\nTool homepage: https://github.com/aineniamh/snipit"
inputs:
  - id: alignment
    type: File
    doc: Input alignment fasta file
    inputBinding:
      position: 1
  - id: ambig_mode
    type:
      - 'null'
      - string
    doc: "Controls how ambiguous bases are handled - [all]\n                     \
      \   include all ambig such as N,Y,B in all positions;\n                    \
      \    [snps] only include ambig if a snp is present at the\n                \
      \        same position; [exclude] remove all ambig, same as\n              \
      \          depreciated --exclude-ambig-pos"
    inputBinding:
      position: 102
      prefix: --ambig-mode
  - id: cds_mode
    type:
      - 'null'
      - boolean
    doc: Assumes sequence supplied is a coding sequence
    inputBinding:
      position: 102
      prefix: --cds-mode
  - id: colour_palette
    type:
      - 'null'
      - string
    doc: "Specify colour palette. Options: [classic,\n                        classic_extended,
      primary, purine-pyrimidine,\n                        greyscale, wes, verity,
      ugene]. Use ugene for protein\n                        alignments."
    inputBinding:
      position: 102
      prefix: --colour-palette
  - id: exclude_positions
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more range (closed, inclusive; one-indexed) or\n                \
      \        specific position to exclude in the output. Ex.\n                 \
      \       '100-150' or Ex. '100 101' Considered after '--\n                  \
      \      include-positions'."
    inputBinding:
      position: 102
      prefix: --exclude-positions
  - id: flip_vertical
    type:
      - 'null'
      - boolean
    doc: "Flip the orientation of the plot so sequences are\n                    \
      \    below the reference rather than above it."
    inputBinding:
      position: 102
      prefix: --flip-vertical
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format options (png, jpg, pdf, svg, tiff) Default: png'
    inputBinding:
      position: 102
      prefix: --format
  - id: height
    type:
      - 'null'
      - string
    doc: Overwrite the default figure height
    inputBinding:
      position: 102
      prefix: --height
  - id: high_to_low
    type:
      - 'null'
      - boolean
    doc: "If sorted by mutation number is selected, show the\n                   \
      \     sequences with the fewest SNPs closest to the\n                      \
      \  reference. Default: False"
    inputBinding:
      position: 102
      prefix: --high-to-low
  - id: include_positions
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more range (closed, inclusive; one-indexed) or\n                \
      \        specific position only included in the output. Ex.\n              \
      \          '100-150' or Ex. '100 101' Considered before '--\n              \
      \          exclude-positions'."
    inputBinding:
      position: 102
      prefix: --include-positions
  - id: l_header
    type:
      - 'null'
      - string
    doc: "Comma separated string of column headers in label csv. First field indicates
      sequence name column, second the label column. Default: 'name,label'"
    inputBinding:
      position: 102
      prefix: --l-header
  - id: labels
    type:
      - 'null'
      - File
    doc: "Optional csv file of labels to show in output snipit\n                 \
      \       plot. Default: sequence names"
    inputBinding:
      position: 102
      prefix: --labels
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file name stem.
    inputBinding:
      position: 102
      prefix: --output-file
  - id: recombi_mode
    type:
      - 'null'
      - boolean
    doc: "Allow colouring of query seqeunces by mutations\n                      \
      \  present in two 'recombi-references' from the input\n                    \
      \    alignment fasta file"
    inputBinding:
      position: 102
      prefix: --recombi-mode
  - id: recombi_references
    type:
      - 'null'
      - string
    doc: "Specify two comma separated sequence IDs in the input\n                \
      \        alignment to use as 'recombi-references'. Ex.\n                   \
      \     Sequence_ID_A,Sequence_ID_B"
    inputBinding:
      position: 102
      prefix: --recombi-references
  - id: reference
    type:
      - 'null'
      - string
    doc: "Indicates which sequence in the alignment is the\n                     \
      \   reference (by sequence ID). Default: first sequence in\n               \
      \         alignment"
    inputBinding:
      position: 102
      prefix: --reference
  - id: remove_site_text
    type:
      - 'null'
      - boolean
    doc: "Do not annotate text on the individual columns in the\n                \
      \        figure."
    inputBinding:
      position: 102
      prefix: --remove-site-text
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: 'Input sequence type: aa or nt'
    inputBinding:
      position: 102
      prefix: --sequence-type
  - id: show_indels
    type:
      - 'null'
      - boolean
    doc: "Include insertion and deletion mutations in snipit\n                   \
      \     plot."
    inputBinding:
      position: 102
      prefix: --show-indels
  - id: size_option
    type:
      - 'null'
      - string
    doc: 'Specify options for sizing. Options: expand, scale'
    inputBinding:
      position: 102
      prefix: --size-option
  - id: solid_background
    type:
      - 'null'
      - boolean
    doc: "Force the plot to have a solid background, rather than\n               \
      \         a transparent one."
    inputBinding:
      position: 102
      prefix: --solid-background
  - id: sort_by_id
    type:
      - 'null'
      - boolean
    doc: "Sort sequences alphabetically by sequence id. Default:\n               \
      \         False"
    inputBinding:
      position: 102
      prefix: --sort-by-id
  - id: sort_by_mutation_number
    type:
      - 'null'
      - boolean
    doc: "Render the graph with sequences sorted by the number\n                 \
      \       of SNPs relative to the reference (fewest to most).\n              \
      \          Default: False"
    inputBinding:
      position: 102
      prefix: --sort-by-mutation-number
  - id: sort_by_mutations
    type:
      - 'null'
      - string
    doc: "Sort sequences by bases at specified positions.\n                      \
      \  Positions are comma separated integers. Ex. '1,2,3'"
    inputBinding:
      position: 102
      prefix: --sort-by-mutations
  - id: width
    type:
      - 'null'
      - string
    doc: Overwrite the default figure width
    inputBinding:
      position: 102
      prefix: --width
  - id: write_snps
    type:
      - 'null'
      - boolean
    doc: Write out the SNPs in a csv file.
    inputBinding:
      position: 102
      prefix: --write-snps
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snipit:1.7--pyhdfd78af_0
stdout: snipit.out
