cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - pileup
label: cooltools_pileup
doc: "Perform retrieval of the snippets from .cool file.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: The paths to a .cool file with a balanced Hi-C map. Use the '::' syntax
      to specify a group path in a multicooler file.
    inputBinding:
      position: 1
  - id: features_path
    type: File
    doc: the path to a BED or BEDPE-like file that contains features for 
      snipping windows. If BED, then the features are on-diagonal. If BEDPE, 
      then the features can be off-diagonal (but not in trans or between 
      different regions in the view).
    inputBinding:
      position: 2
  - id: aggregate
    type:
      - 'null'
      - string
    doc: Function for calculating aggregate signal.
    default: none
    inputBinding:
      position: 103
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Use balancing weight with this name.
    default: weight
    inputBinding:
      position: 103
  - id: expected
    type:
      - 'null'
      - string
    doc: Path to the expected table. If provided, outputs OOE pileup. if not 
      provided, outputs regular pileup.
    inputBinding:
      position: 103
  - id: features_format
    type:
      - 'null'
      - string
    doc: Input features format.
    default: auto
    inputBinding:
      position: 103
  - id: flank
    type:
      - 'null'
      - int
    doc: Size of flanks.
    default: 100000
    inputBinding:
      position: 103
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: The number of diagonals to ignore. By default, equals the number of 
      diagonals ignored during IC balancing.
    inputBinding:
      position: 103
      prefix: --ignore-diags
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to split the work between.
    default: 1
    inputBinding:
      position: 103
      prefix: --nproc
  - id: out_format
    type:
      - 'null'
      - string
    doc: Type of output.
    default: NPZ
    inputBinding:
      position: 103
  - id: store_snips
    type:
      - 'null'
      - boolean
    doc: Flag indicating whether snips should be stored.
    inputBinding:
      position: 103
      prefix: --store-snips
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
    doc: Path to a BED file which defines which regions of the chromosomes to 
      use. Required if EXPECTED_PATH is provided Note that '--regions' is the 
      deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 103
      prefix: --view
outputs:
  - id: out
    type: File
    doc: Save output pileup as NPZ/HDF5 file.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
