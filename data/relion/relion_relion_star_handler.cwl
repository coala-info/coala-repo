cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_star_handler
label: relion_relion_star_handler
doc: "Operate on STAR files: select, split, combine, compare, centre, edit columns, histogram and remove\
  \ duplicate particles.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: Input STAR file(s)
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output STAR file (RELION default: out.star)'
    inputBinding:
      position: 101
      prefix: --o
    default: out.star
  - id: ignore_optics
    type:
      - 'null'
      - boolean
    doc: Provide this option for relion-3.0 functionality, without optics groups
    inputBinding:
      position: 101
      prefix: --ignore_optics
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in Angstrom, for when ignoring the optics groups in the input star file (RELION default:
      1.)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: i_tablename
    type:
      - 'null'
      - string
    doc: If ignoring optics, then read table with this name
    inputBinding:
      position: 101
      prefix: --i_tablename
  - id: compare_star
    type:
      - 'null'
      - File
    doc: STAR file name to compare the input STAR file with
    inputBinding:
      position: 101
      prefix: --compare
  - id: label1
    type:
      - 'null'
      - string
    doc: 1st metadata label for the comparison (may be string, int or RFLOAT)
    inputBinding:
      position: 101
      prefix: --label1
  - id: label2
    type:
      - 'null'
      - string
    doc: 2nd metadata label for the comparison (RFLOAT only) for 2D/3D-distance)
    inputBinding:
      position: 101
      prefix: --label2
  - id: label3
    type:
      - 'null'
      - string
    doc: 3rd metadata label for the comparison (RFLOAT only) for 3D-distance)
    inputBinding:
      position: 101
      prefix: --label3
  - id: max_dist
    type:
      - 'null'
      - float
    doc: 'Maximum distance to consider a match (for int and RFLOAT only) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --max_dist
  - id: select
    type:
      - 'null'
      - string
    doc: Metadata label (number) to base output selection on (e.g. rlnCtfFigureOfMerit)
    inputBinding:
      position: 101
      prefix: --select
  - id: minval
    type:
      - 'null'
      - float
    doc: 'Minimum acceptable value for this label (inclusive) (RELION default: -99999999.)'
    inputBinding:
      position: 101
      prefix: --minval
  - id: maxval
    type:
      - 'null'
      - float
    doc: 'Maximum acceptable value for this label (inclusive) (RELION default: 99999999.)'
    inputBinding:
      position: 101
      prefix: --maxval
  - id: select_by_str
    type:
      - 'null'
      - string
    doc: Metadata label (string) to base output selection on (e.g. rlnMicrographname)
    inputBinding:
      position: 101
      prefix: --select_by_str
  - id: select_include
    type:
      - 'null'
      - string
    doc: select rows that contains this string in --select_by_str
    inputBinding:
      position: 101
      prefix: --select_include
  - id: select_exclude
    type:
      - 'null'
      - string
    doc: exclude rows that contains this string in --select_by_str
    inputBinding:
      position: 101
      prefix: --select_exclude
  - id: discard_on_stats
    type:
      - 'null'
      - boolean
    doc: Discard images if their average/stddev deviates too many sigma from the ensemble average
    inputBinding:
      position: 101
      prefix: --discard_on_stats
  - id: discard_label
    type:
      - 'null'
      - string
    doc: 'MetaDataLabel that points to the images to be used for discarding based on statistics (RELION
      default: rlnImageName)'
    inputBinding:
      position: 101
      prefix: --discard_label
  - id: discard_sigma
    type:
      - 'null'
      - float
    doc: 'Discard images with average or stddev values that lie this many sigma away from the ensemble
      average (RELION default: 4.)'
    inputBinding:
      position: 101
      prefix: --discard_sigma
  - id: combine
    type:
      - 'null'
      - boolean
    doc: Combine input STAR files (multiple individual filenames, all within double-quotes after --i)
    inputBinding:
      position: 101
      prefix: --combine
  - id: combine_picks
    type:
      - 'null'
      - boolean
    doc: Combine input manual/autopick STAR files (multiple individual filenames, all within double-quotes
      after --i)
    inputBinding:
      position: 101
      prefix: --combine_picks
  - id: check_duplicates
    type:
      - 'null'
      - string
    doc: MetaDataLabel (for a string only!) to check for duplicates, e.g. rlnImageName
    inputBinding:
      position: 101
      prefix: --check_duplicates
  - id: split
    type:
      - 'null'
      - boolean
    doc: Split the input STAR file into one or more smaller output STAR files
    inputBinding:
      position: 101
      prefix: --split
  - id: random_order
    type:
      - 'null'
      - boolean
    doc: Perform splits on randomised order of the input STAR file
    inputBinding:
      position: 101
      prefix: --random_order
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random seed for randomisation. (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: nr_split
    type:
      - 'null'
      - int
    doc: 'Split into this many equal-sized STAR files (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --nr_split
  - id: size_split
    type:
      - 'null'
      - int
    doc: 'AND/OR split into subsets of this many lines (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --size_split
  - id: operate
    type:
      - 'null'
      - string
    doc: Operate on this metadata label
    inputBinding:
      position: 101
      prefix: --operate
  - id: operate2
    type:
      - 'null'
      - string
    doc: Operate also on this metadata label
    inputBinding:
      position: 101
      prefix: --operate2
  - id: operate3
    type:
      - 'null'
      - string
    doc: Operate also on this metadata label
    inputBinding:
      position: 101
      prefix: --operate3
  - id: set_to
    type:
      - 'null'
      - string
    doc: Set all the values for the --operate label(s) to this value
    inputBinding:
      position: 101
      prefix: --set_to
  - id: multiply_by
    type:
      - 'null'
      - float
    doc: 'Multiply all the values for the --operate label(s) by this value (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --multiply_by
  - id: add_to
    type:
      - 'null'
      - float
    doc: 'Add this value to all the values for the --operate label(s) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --add_to
  - id: center
    type:
      - 'null'
      - boolean
    doc: Perform centering of particles according to a position in the reference.
    inputBinding:
      position: 101
      prefix: --center
  - id: center_X
    type:
      - 'null'
      - float
    doc: 'X-coordinate in the reference to center particles on (in pix) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --center_X
  - id: center_Y
    type:
      - 'null'
      - float
    doc: 'Y-coordinate in the reference to center particles on (in pix) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --center_Y
  - id: center_Z
    type:
      - 'null'
      - float
    doc: 'Z-coordinate in the reference to center particles on (in pix) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --center_Z
  - id: remove_column
    type:
      - 'null'
      - string
    doc: Remove the column with this metadata label from the input STAR file.
    inputBinding:
      position: 101
      prefix: --remove_column
  - id: add_column
    type:
      - 'null'
      - string
    doc: Add a column with this metadata label from the input STAR file.
    inputBinding:
      position: 101
      prefix: --add_column
  - id: add_column_value
    type:
      - 'null'
      - string
    doc: Set this value in all rows for the added column
    inputBinding:
      position: 101
      prefix: --add_column_value
  - id: copy_column_from
    type:
      - 'null'
      - string
    doc: Copy values in this column to the added column
    inputBinding:
      position: 101
      prefix: --copy_column_from
  - id: hist_column
    type:
      - 'null'
      - string
    doc: Calculate histogram of values in the column with this metadata label
    inputBinding:
      position: 101
      prefix: --hist_column
  - id: in_percent
    type:
      - 'null'
      - boolean
    doc: Show a histogram in percent (need --hist_column)
    inputBinding:
      position: 101
      prefix: --in_percent
  - id: show_cumulative
    type:
      - 'null'
      - boolean
    doc: Show a histogram of cumulative distribution (need --hist_column)
    inputBinding:
      position: 101
      prefix: --show_cumulative
  - id: hist_bins
    type:
      - 'null'
      - int
    doc: 'Number of bins for the histogram. By default, determined automatically by Freedman–Diaconis
      rule. (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --hist_bins
  - id: hist_min
    type:
      - 'null'
      - string
    doc: 'Minimum value for the histogram (needs --hist_bins) (RELION default: -inf)'
    inputBinding:
      position: 101
      prefix: --hist_min
  - id: hist_max
    type:
      - 'null'
      - string
    doc: 'Maximum value for the histogram (needs --hist_bins) (RELION default: inf)'
    inputBinding:
      position: 101
      prefix: --hist_max
  - id: remove_duplicates
    type:
      - 'null'
      - float
    doc: 'Remove duplicated particles within this distance [Angstrom]. Negative values disable this. (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --remove_duplicates
  - id: image_angpix
    type:
      - 'null'
      - float
    doc: 'For down-sampled particles, specify the pixel size [A/pix] of the original images used in the
      Extract job (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --image_angpix
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: star_files
    type: &id001
      type: array
      items: File
    doc: 'Output STAR file(s): main output, split parts and compare results'
    outputBinding:
      glob:
        - $(inputs.output)
        - $(inputs.output.replace(/\.star$/, ''))_*.star
  - id: plots
    type: *id001
    doc: Histogram plot (with --hist_column)
    outputBinding:
      glob: '*.eps'
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_star_handler.out
