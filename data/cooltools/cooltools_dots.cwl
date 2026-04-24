cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - dots
label: cooltools_dots
doc: "Call dots on a Hi-C heatmap that are not larger than max_loci_separation.\n\n\
  Tool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: The paths to a .cool file with a balanced Hi-C map.
    inputBinding:
      position: 1
  - id: expected_path
    type: File
    doc: The paths to a tsv-like file with expected signal, including a header. 
      Use the '::' syntax to specify a column name.
    inputBinding:
      position: 2
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Use cooler balancing weight with this name.
    inputBinding:
      position: 103
      prefix: --clr-weight-name
  - id: clustering_radius
    type:
      - 'null'
      - int
    doc: Radius for clustering dots that have been called too close to each 
      other.Typically on order of 40 kilo-bases, and >= binsize.
    inputBinding:
      position: 103
      prefix: --clustering-radius
  - id: fdr
    type:
      - 'null'
      - float
    doc: False discovery rate (FDR) to control in the multiple hypothesis 
      testing BH-FDR procedure.
    inputBinding:
      position: 103
      prefix: --fdr
  - id: max_loci_separation
    type:
      - 'null'
      - int
    doc: Limit loci separation for dot-calling, i.e., do not call dots for loci 
      that are further than max_loci_separation basepair apart. 2-20MB is 
      reasonable and would capture most of CTCF-dots.
    inputBinding:
      position: 103
      prefix: --max-loci-separation
  - id: max_nans_tolerated
    type:
      - 'null'
      - int
    doc: Maximum number of NaNs tolerated in a footprint of every used filter. 
      Must be controlled with caution, as large max-nans-tolerated, might lead 
      to pixels scored in the padding area of the tiles to "penetrate" to the 
      list of scored pixels for the statistical testing. [max-nans-tolerated <= 
      2*w ]
    inputBinding:
      position: 103
      prefix: --max-nans-tolerated
  - id: nproc
    type:
      - 'null'
      - int
    doc: 'Number of processes to split the work between. [default: 1, i.e. no process
      pool]'
    inputBinding:
      position: 103
      prefix: --nproc
  - id: num_lambda_bins
    type:
      - 'null'
      - int
    doc: Number of log-spaced bins to divide your adjusted expected between. 
      Same as HiCCUPS_W1_MAX_INDX (40) in the original HiCCUPS.
    inputBinding:
      position: 103
      prefix: --num-lambda-bins
  - id: regions
    type:
      - 'null'
      - File
    doc: Path to a BED file with the definition of viewframe (regions) used in 
      the calculation of EXPECTED_PATH. Dot-calling will be performed for these 
      regions independently e.g. chromosome arms. Note that '--regions' is the 
      deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 103
      prefix: --regions
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Tile size for the Hi-C heatmap tiling. Typically on order of several 
      mega-bases, and <= max_loci_separation.
    inputBinding:
      position: 103
      prefix: --tile-size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
  - id: view_regions
    type:
      - 'null'
      - File
    doc: Path to a BED file with the definition of viewframe (regions) used in 
      the calculation of EXPECTED_PATH. Dot-calling will be performed for these 
      regions independently e.g. chromosome arms. Note that '--regions' is the 
      deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 103
      prefix: --view
outputs:
  - id: output
    type: File
    doc: Specify output file name to store called dots in a BEDPE-like format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
