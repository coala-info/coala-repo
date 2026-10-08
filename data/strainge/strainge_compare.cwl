cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- strainge
- compare
label: strainge_compare
doc: 'Compare strains and variant calls in two different samples. Reads of both samples must be aligned to the same reference.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: sample_hdf5
  type: File[]
  doc: HDF5 files with variant calling data for each sample. Number of samples should be exactly two, except when used with --baseline.
  inputBinding:
    position: 100
- id: summary_out
  type:
  - 'null'
  - string
  doc: Output file for summary statistics. Defaults to stdout.
  inputBinding:
    position: 1
    prefix: --summary-out
- id: details_out
  type:
  - 'null'
  - string
  doc: Output file for detailed base level differences between samples (optional).
  inputBinding:
    position: 1
    prefix: --details-out
- id: verbose_details
  type:
  - 'null'
  - boolean
  doc: Output detailed information for every position in the genome instead of only for positions where alleles differ.
  inputBinding:
    position: 1
    prefix: --verbose-details
- id: min_gap
  type:
  - 'null'
  - int
  doc: Only compare gaps larger than the given size.
  inputBinding:
    position: 1
    prefix: --min-gap
- id: all_vs_all
  type:
  - 'null'
  - boolean
  doc: Perform all-vs-all pairwise comparisons between the given samples. Can't be used together with --baseline.
  inputBinding:
    position: 1
    prefix: --all-vs-all
- id: baseline
  type:
  - 'null'
  - File
  doc: Path to a sample to use as baseline, and compare all other given samples to this one. Outputs a shell script that runs all individual pairwise comparisons. Can't be used together with --all-vs-all.
  inputBinding:
    position: 1
    prefix: --baseline
- id: output_dir
  type:
  - 'null'
  - string
  doc: The output directory of all comparison files when using --baseline or --all-vs-all.
  inputBinding:
    position: 1
    prefix: --output-dir
outputs:
- id: summary_out_result
  type:
  - 'null'
  - File
  doc: Output file for summary statistics. Defaults to stdout.
  outputBinding:
    glob: $(inputs.summary_out)
- id: details_out_result
  type:
  - 'null'
  - File
  doc: Output file for detailed base level differences between samples (optional).
  outputBinding:
    glob: $(inputs.details_out)
- id: output_dir_result
  type:
  - 'null'
  - Directory
  doc: The output directory of all comparison files when using --baseline or --all-vs-all.
  outputBinding:
    glob: $(inputs.output_dir)
- id: stdout
  type: stdout
  doc: Standard output
stdout: strainge_compare.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
