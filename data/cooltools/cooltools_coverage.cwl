cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - coverage
label: cooltools_coverage
doc: "Calculate the sums of cis and genome-wide contacts (aka coverage aka marginals)
  for a sparse Hi-C contact map in Cooler HDF5 format. Note that the sum(tot_cov)
  from this function is two times the number of reads contributing to the cooler,
  as each side contributes to the coverage.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: The paths to a .cool file with a balanced Hi-C map.
    inputBinding:
      position: 1
  - id: bigwig
    type:
      - 'null'
      - boolean
    doc: Also save output as bigWig files for cis and total coverage with the 
      names <output>.<cis/tot>.bw
    inputBinding:
      position: 102
      prefix: --bigwig
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Split the contact matrix pixel records into equally sized chunks to 
      save memory and/or parallelize. Default is 10^7
    default: 10000000.0
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Name of the weight column. Specify to calculate coverage of balanced 
      cooler.
    inputBinding:
      position: 102
      prefix: --clr_weight_name
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: The number of diagonals to ignore. By default, equals the number of 
      diagonals ignored during IC balancing.
    inputBinding:
      position: 102
      prefix: --ignore-diags
  - id: nproc
    type:
      - 'null'
      - int
    doc: 'Number of processes to split the work between. [default: 1, i.e. no process
      pool]'
    default: 1
    inputBinding:
      position: 102
      prefix: --nproc
  - id: store
    type:
      - 'null'
      - boolean
    doc: Append columns with coverage (cov_cis_raw, cov_tot_raw), or 
      (cov_cis_clr_weight_name, cov_tot_clr_weight_name) if calculating balanced
      coverage, to the cooler bin table. If clr_weight_name=None, also stores 
      total cis counts in the cooler info
    inputBinding:
      position: 102
      prefix: --store
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file name to store the coverage in a tsv format.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
