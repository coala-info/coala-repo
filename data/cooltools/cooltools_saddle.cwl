cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooltools saddle
label: cooltools_saddle
doc: "Calculate saddle statistics and generate saddle plots for an arbitrary signal
  track on the genomic bins of a contact matrix.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: The paths to a .cool file with a balanced Hi-C map. Use the '::' syntax
      to specify a group path in a multicooler file.
    inputBinding:
      position: 1
  - id: track_path
    type: File
    doc: The path to bedGraph-like file with a binned compartment track 
      (eigenvector), including a header. Use the '::' syntax to specify a column
      name.
    inputBinding:
      position: 2
  - id: expected_path
    type: File
    doc: The paths to a tsv-like file with expected signal, including a header. 
      Use the '::' syntax to specify a column name.
    inputBinding:
      position: 3
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Use balancing weight with this name.
    default: weight
    inputBinding:
      position: 104
      prefix: --clr-weight-name
  - id: cmap
    type:
      - 'null'
      - string
    doc: Name of matplotlib colormap
    default: coolwarm
    inputBinding:
      position: 104
      prefix: --cmap
  - id: compute_strength
    type:
      - 'null'
      - boolean
    doc: Compute and save compartment 'saddle strength' profile
    inputBinding:
      position: 104
      prefix: --strength
  - id: contact_type
    type:
      - 'null'
      - string
    doc: Type of the contacts to aggregate
    default: cis
    inputBinding:
      position: 104
      prefix: --contact-type
  - id: fig
    type:
      - 'null'
      - type: array
        items: string
    doc: Generate a figure and save to a file of the specified format. If not 
      specified - no image is generated. Repeat for multiple output formats.
    inputBinding:
      position: 104
      prefix: --fig
  - id: hist_color
    type:
      - 'null'
      - string
    doc: Face color of histogram bar chart
    inputBinding:
      position: 104
      prefix: --hist-color
  - id: max_dist
    type:
      - 'null'
      - int
    doc: Maximal distance between bins to consider, bp. Ignored, if negative. 
      Ignored with --contact-type trans.
    default: -1
    inputBinding:
      position: 104
      prefix: --max-dist
  - id: min_dist
    type:
      - 'null'
      - int
    doc: Minimal distance between bins to consider, bp. If negative, removesthe 
      first two diagonals of the data. Ignored with --contact-type trans.
    default: -1
    inputBinding:
      position: 104
      prefix: --min-dist
  - id: n_bins
    type:
      - 'null'
      - int
    doc: Number of bins for digitizing track values.
    default: 50
    inputBinding:
      position: 104
      prefix: --n-bins
  - id: no_strength
    type:
      - 'null'
      - boolean
    doc: Compute and save compartment 'saddle strength' profile
    inputBinding:
      position: 104
      prefix: --no-strength
  - id: out_prefix
    type: string
    doc: Dump 'saddledata', 'binedges' and 'hist' arrays in a numpy-specific 
      .npz container. Use numpy.load to load these arrays into a dict-like 
      object. The digitized signal values are saved to a bedGraph-style TSV.
    inputBinding:
      position: 104
      prefix: --out-prefix
  - id: qrange
    type:
      - 'null'
      - type: array
        items: float
    doc: Low and high values used for quantile bins of genome-wide track 
      values,e.g. if `qrange`=(0.02, 0.98) the lower bin would start at the 2nd 
      percentile and the upper bin would end at the 98th percentile of the 
      genome-wide signal. Use to prevent the extreme track values from exploding
      the bin range.
    default:
      - None
      - None
    inputBinding:
      position: 104
      prefix: --qrange
  - id: regions
    type:
      - 'null'
      - File
    doc: Path to a BED file containing genomic regions for which saddleplot will
      be calculated. Region names can be provided in a 4th column and should 
      match regions and their names in expected. Note that '--regions' is the 
      deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 104
      prefix: --regions
  - id: scale
    type:
      - 'null'
      - string
    doc: Value scale for the heatmap
    default: log
    inputBinding:
      position: 104
      prefix: --scale
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 104
      prefix: --verbose
  - id: view
    type:
      - 'null'
      - File
    doc: Path to a BED file containing genomic regions for which saddleplot will
      be calculated. Region names can be provided in a 4th column and should 
      match regions and their names in expected. Note that '--regions' is the 
      deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 104
      prefix: --view
  - id: vmax
    type:
      - 'null'
      - float
    doc: High value of the saddleplot colorbar
    inputBinding:
      position: 104
      prefix: --vmax
  - id: vmin
    type:
      - 'null'
      - float
    doc: 'Low value of the saddleplot colorbar. Note: value in original units irrespective
      of used scale, and therefore should be positive for both vmin and vmax.'
    inputBinding:
      position: 104
      prefix: --vmin
  - id: vrange
    type:
      - 'null'
      - type: array
        items: float
    doc: Low and high values used for binning genome-wide track values, e.g. if 
      `range`=(-0.05, 0.05), `n-bins` equidistant bins would be generated. Use 
      to prevent extreme track values from exploding the bin range and to ensure
      consistent bins across several runs of `compute_saddle` command using 
      different track files.
    inputBinding:
      position: 104
      prefix: --vrange
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
stdout: cooltools_saddle.out
