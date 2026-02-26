cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - insulation
label: cooltools_insulation
doc: "Calculate the diamond insulation scores and call insulating boundaries.\n\n\
  Tool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: in_path
    type: File
    doc: The path to a .cool file with a Hi-C map.
    inputBinding:
      position: 1
  - id: window
    type:
      type: array
      items: string
    doc: The window size for the insulation score calculations. Multiple 
      space-separated values can be provided.
    inputBinding:
      position: 2
  - id: append_raw_scores
    type:
      - 'null'
      - boolean
    doc: Append columns with raw scores (sum_counts, sum_balanced, n_pixels) to 
      the output table.
    inputBinding:
      position: 103
      prefix: --append-raw-scores
  - id: bigwig
    type:
      - 'null'
      - boolean
    doc: Also save insulation tracks as a bigWig files for different window 
      sizes with the names output.<window-size>.bw
    inputBinding:
      position: 103
      prefix: --bigwig
  - id: chunksize
    type:
      - 'null'
      - int
    default: 20000000
    inputBinding:
      position: 103
      prefix: --chunksize
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Use balancing weight with this name. Provide empty argument to 
      calculate insulation on raw data (no masking bad pixels).
    default: weight
    inputBinding:
      position: 103
      prefix: --clr-weight-name
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: The number of diagonals to ignore. By default, equals the number of 
      diagonals ignored during IC balancing.
    inputBinding:
      position: 103
      prefix: --ignore-diags
  - id: min_dist_bad_bin
    type:
      - 'null'
      - int
    doc: The minimal allowed distance to a bad bin. Use to mask bins after 
      insulation calculation and during boundary detection.
    default: 0
    inputBinding:
      position: 103
      prefix: --min-dist-bad-bin
  - id: min_frac_valid_pixels
    type:
      - 'null'
      - float
    doc: The minimal fraction of valid pixels in a sliding diamond. Used to mask
      bins during boundary detection.
    default: 0.66
    inputBinding:
      position: 103
      prefix: --min-frac-valid-pixels
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to split the work between.
    default: 1
    inputBinding:
      position: 103
      prefix: --nproc
  - id: regions
    type:
      - 'null'
      - File
    doc: Path to a BED file containing genomic regions for which insulation 
      scores will be calculated. Region names can be provided in a 4th column 
      and should match regions and their names in expected. Note that 
      '--regions' is the deprecated name of the option. Use '--view' instead.
    inputBinding:
      position: 103
      prefix: --regions
  - id: threshold
    type:
      - 'null'
      - string
    doc: Rule used to threshold the histogram of boundary strengths to exclude 
      weak boundaries. 'Li' or 'Otsu' use corresponding methods from 
      skimage.thresholding. Providing a float value will filter by a fixed 
      threshold.
    default: '0'
    inputBinding:
      position: 103
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Report real-time progress.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: view
    type:
      - 'null'
      - File
    doc: Path to a BED file containing genomic regions for which insulation 
      scores will be calculated. Region names can be provided in a 4th column 
      and should match regions and their names in expected.
    inputBinding:
      position: 103
      prefix: --view
  - id: window_pixels
    type:
      - 'null'
      - boolean
    doc: If set then the window sizes are provided in units of pixels.
    inputBinding:
      position: 103
      prefix: --window-pixels
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Specify output file name to store the insulation in a tsv format.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
