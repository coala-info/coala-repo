cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimm
label: slimm
doc: "Species Level Identification of Microbes from Metagenomes\n\nTool homepage:
  https://github.com/seqan/slimm/blob/master/README.md"
inputs:
  - id: db_input_file
    type: File
    doc: 'Valid filetype is: .sldb.'
    inputBinding:
      position: 1
  - id: in_input_prefix
    type: string
    doc: Input prefix
    inputBinding:
      position: 2
  - id: abundance_cut_off
    type:
      - 'null'
      - float
    doc: do not report abundances below this value In range [0.0..10.0].
    inputBinding:
      position: 103
      prefix: --abundance-cut-off
  - id: bin_width
    type:
      - 'null'
      - int
    doc: Set the width of a single bin in neuclotides.
    inputBinding:
      position: 103
      prefix: --bin-width
  - id: cov_cut_off
    type:
      - 'null'
      - float
    doc: the quantile of coverages to use as a cutoff smaller value means bigger
      threshold. In range [0.0..1.0].
    inputBinding:
      position: 103
      prefix: --cov-cut-off
  - id: coverage_output
    type:
      - 'null'
      - boolean
    doc: Output raw coverage statstics
    inputBinding:
      position: 103
      prefix: --coverage-output
  - id: directory
    type:
      - 'null'
      - boolean
    doc: Input is a directory.
    inputBinding:
      position: 103
      prefix: --directory
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of matching reads to consider a reference present.
    inputBinding:
      position: 103
      prefix: --min-reads
  - id: rank
    type:
      - 'null'
      - string
    doc: The taxonomic rank of identification One of strains, species, genus, 
      family, order, class, phylum, and superkingdom.
    inputBinding:
      position: 103
      prefix: --rank
  - id: raw_output
    type:
      - 'null'
      - boolean
    doc: Output raw reference statstics
    inputBinding:
      position: 103
      prefix: --raw-output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: "Turn this option off to disable version update notifications of the\n  \
      \        application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO."
    inputBinding:
      position: 103
      prefix: --version-check
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: output path prefix.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
