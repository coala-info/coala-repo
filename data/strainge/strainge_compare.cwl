cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge_compare
label: strainge_compare
doc: "Compare strains and variant calls in two different samples. Reads of both samples
  must be aligned to the same reference.\n\nIt's possible to generate a TSV with summary
  stats as well as a file with more detailed information on which alleles are called
  at what positions.\n\nTool homepage: The package home page"
inputs:
  - id: sample_hdf5
    type:
      type: array
      items: File
    doc: HDF5 files with variant calling data for each sample. Number of samples
      should be exactly two, except when used with --baseline.
    inputBinding:
      position: 1
  - id: all_vs_all
    type:
      - 'null'
      - boolean
    doc: Perform all-vs-all pairwise comparisons between the given samples. 
      Can't be used together with --baseline.
    inputBinding:
      position: 102
      prefix: --all-vs-all
  - id: baseline
    type:
      - 'null'
      - File
    doc: Path to a sample to use as baseline, and compare all other given 
      samples to this one. Outputs a shell script that runs all individual 
      pairwise comparisons. Can't be used together with --all-vs-all.
    inputBinding:
      position: 102
      prefix: --baseline
  - id: min_gap
    type:
      - 'null'
      - int
    doc: Only compare gaps larger than the given size.
    inputBinding:
      position: 102
      prefix: --min-gap
  - id: verbose_details
    type:
      - 'null'
      - boolean
    doc: Output detailed information for every position in the genome instead of
      only for positions where alleles differ.
    inputBinding:
      position: 102
      prefix: --verbose-details
outputs:
  - id: summary_out
    type:
      - 'null'
      - File
    doc: Output file for summary statistics. Defaults to stdout.
    outputBinding:
      glob: $(inputs.summary_out)
  - id: details_out
    type:
      - 'null'
      - File
    doc: Output file for detailed base level differences between samples 
      (optional).
    outputBinding:
      glob: $(inputs.details_out)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The output directory of all comparison files when using --baseline or 
      --all-vs-all.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
