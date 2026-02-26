cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge_view
label: strainge_view
doc: "View call statistics stored in a HDF5 file and output results to different file
  formats\n\nTool homepage: The package home page"
inputs:
  - id: hdf5
    type: File
    doc: HDF5 file with StrainGR call statistics.
    inputBinding:
      position: 1
  - id: min_gap
    type:
      - 'null'
      - int
    doc: Minimum size of gap to be considered as such. If not set, will use the 
      value used in the original `straingr call` run. If set, gaps will need to 
      be at least the given size to be reported. Will be scaled depending on 
      coverage.
    inputBinding:
      position: 102
      prefix: --min-gap
  - id: track_min_size
    type:
      - 'null'
      - int
    doc: 'For all --track-* options above, only include features (regions) of at least
      the given size. Default: 1.'
    default: 1
    inputBinding:
      position: 102
      prefix: --track-min-size
  - id: track_prefix
    type:
      - 'null'
      - string
    doc: Specifiy filename prefix for all track files. By default it will use 
      the path of the HDF5 file without the '.hdf5' extension.
    inputBinding:
      position: 102
      prefix: --track-prefix
  - id: tracks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Write track files that can be visualized in a genome viewer, use this option
      multiple times to generate multiple track types. Use 'all' to generate all tracks.
      Available track types: coverage, callable, multimapped, lowmq, bad, high_coverage,
      gaps"
    inputBinding:
      position: 102
      prefix: --tracks
  - id: verbose_vcf_level
    type:
      - 'null'
      - int
    doc: To be used with --vcf. Increase the verboseness of the generated VCF. 
      By default it only outputs strong SNPs. A value of 1 will also output any 
      weak calls.
    inputBinding:
      position: 102
      prefix: --verbose-vcf
outputs:
  - id: summary_file
    type:
      - 'null'
      - File
    doc: Output a TSV with a summary of variant calling statistics to the given 
      file.
    outputBinding:
      glob: $(inputs.summary_file)
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: Output a VCF file with SNP's. Please be aware that we do not have a 
      good insertion/deletion calling mechanism, but some information on 
      possible indels is written to the VCF file.
    outputBinding:
      glob: $(inputs.vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
