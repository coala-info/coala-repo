cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimm
label: slimm
doc: "SLIMM: Species Level Identification of Microbes from Metagenomes. Gets a
  taxonomic profile from a SAM/BAM alignment file (or a directory of them) using a
  .sldb database built with slimm_build.\n\nTool homepage: https://github.com/seqan/slimm/blob/master/README.md"
inputs:
  - id: database
    type: File
    doc: 'SLIMM database (valid filetype is: .sldb)'
    inputBinding:
      position: 100
  - id: alignment_input
    type: [File, Directory]
    doc: Input SAM/BAM file (or a directory of SAM/BAM files with --directory)
    inputBinding:
      position: 101
  - id: output_dir
    type: string
    default: slimm_reports
    doc: Output directory for the profile reports (the --output-prefix path; it is created before the run)
    inputBinding:
      position: 1
      prefix: --output-prefix
      valueFrom: $(self)/
  - id: bin_width
    type: ['null', int]
    doc: Set the width of a single bin in nucleotides
    inputBinding:
      position: 1
      prefix: --bin-width
  - id: min_reads
    type: ['null', int]
    doc: Minimum number of matching reads to consider a reference present
    inputBinding:
      position: 1
      prefix: --min-reads
  - id: rank
    type: ['null', string]
    doc: The taxonomic rank of identification; one of strains, species, genus, family, order, class, phylum, and superkingdom
    inputBinding:
      position: 1
      prefix: --rank
  - id: cov_cut_off
    type: ['null', float]
    doc: The quantile of coverages to use as a cutoff; smaller value means bigger threshold. In range [0.0..1.0]
    inputBinding:
      position: 1
      prefix: --cov-cut-off
  - id: abundance_cut_off
    type: ['null', float]
    doc: Do not report abundances below this value. In range [0.0..10.0]
    inputBinding:
      position: 1
      prefix: --abundance-cut-off
  - id: directory
    type: ['null', boolean]
    doc: Input is a directory
    inputBinding:
      position: 1
      prefix: --directory
  - id: raw_output
    type: ['null', boolean]
    doc: Output raw reference statistics
    inputBinding:
      position: 1
      prefix: --raw-output
  - id: coverage_output
    type: ['null', boolean]
    doc: Output raw coverage statistics
    inputBinding:
      position: 1
      prefix: --coverage-output
  - id: verbose
    type: ['null', boolean]
    doc: Enable verbose output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: version_check
    type: ['null', string]
    doc: Turn this option off to disable version update notifications. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO
    inputBinding:
      position: 1
      prefix: --version-check
outputs:
  - id: reports
    type: Directory
    doc: Directory with the SLIMM profile reports (and raw statistics if requested)
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_dir, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
