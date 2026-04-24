cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pauvre
  - synplot
label: pauvre_synplot
doc: "Generate synteny plots from GFF annotations and alignments.\n\nTool homepage:
  https://github.com/conchoecia/gloTK"
inputs:
  - id: aln_dir
    type:
      - 'null'
      - Directory
    doc: The directory where all the fasta alignments are contained.
    inputBinding:
      position: 101
      prefix: --aln_dir
  - id: center_on
    type:
      - 'null'
      - string
    doc: "Centers the plot around the gene that you pass as an argument. For example,
      if there is a locus called 'COI' in the gff file and in the alignments directory,
      center using: --center_on COI"
    inputBinding:
      position: 101
      prefix: --center_on
  - id: dpi
    type:
      - 'null'
      - int
    doc: Change the dpi from the default 600 if you need it higher
    inputBinding:
      position: 101
      prefix: --dpi
  - id: fileform
    type:
      - 'null'
      - type: array
        items: string
    doc: Which output format would you like? Def.=png
    inputBinding:
      position: 101
      prefix: --fileform
  - id: gff_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: In case the gff names and sequence names don't match, change the labels that
      will appear over the text.
    inputBinding:
      position: 101
      prefix: --gff_labels
  - id: gff_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: The input filepath. for the gff annotation to plot. Individual filepaths
      separated by spaces. For example, --gff_paths sp1.gff sp2.gff sp3.gff
    inputBinding:
      position: 101
      prefix: --gff_paths
  - id: no_timestamp
    type:
      - 'null'
      - boolean
    doc: Turn off time stamps in the filename output.
    inputBinding:
      position: 101
      prefix: --no_timestamp
  - id: optimum_order
    type:
      - 'null'
      - boolean
    doc: If selected, this doesn't plot the optimum arrangement of things as they
      are input into gff_paths. Instead, it uses the first gff file as the top-most
      sequence in the plot, and reorganizes the remaining gff files to minimize the
      number of intersections.
    inputBinding:
      position: 101
      prefix: --optimum_order
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ratio
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Enter the dimensions (arbitrary units) to plot the figure. For example a
      figure that is seven times wider than tall is: --ratio 7 1'
    inputBinding:
      position: 101
      prefix: --ratio
  - id: sandwich
    type:
      - 'null'
      - boolean
    doc: Put an additional copy of the first gff file on the bottom of the plot for
      comparison.
    inputBinding:
      position: 101
      prefix: --sandwich
  - id: start_with_aligned_genes
    type:
      - 'null'
      - boolean
    doc: Minimizes the number of intersections but only selects combos where the first
      gene in each sequence is aligned.
    inputBinding:
      position: 101
      prefix: --start_with_aligned_genes
  - id: stop_codons
    type:
      - 'null'
      - boolean
    doc: Performs some internal corrections if the gff annotation includes the stop
      codons in the coding sequences.
    inputBinding:
      position: 101
      prefix: --stop_codons
  - id: transparent
    type:
      - 'null'
      - boolean
    doc: Specify this option if you DON'T want a transparent background. Default is
      on.
    inputBinding:
      position: 101
      prefix: --transparent
outputs:
  - id: output_basename
    type:
      - 'null'
      - File
    doc: Specify a base name for the output file(s). The input file base name is the
      default.
    outputBinding:
      glob: $(inputs.output_basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pauvre:0.1924--py_0
