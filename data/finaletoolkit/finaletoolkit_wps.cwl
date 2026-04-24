cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-wps
label: finaletoolkit_wps
doc: "Calculates Windowed Protection Score (WPS) over intervals defined in a BED file
  based on alignment data from a BAM/CRAM/Fragment file.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to a BAM/CRAM/Fragment file containing fragment data.
    inputBinding:
      position: 1
  - id: site_bed
    type: File
    doc: Path to a BED file containing sites to calculate WPS over. The 
      intervals in this BED file should be sorted, first by `contig` then 
      `start`.
    inputBinding:
      position: 2
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: A .chrom.sizes file containing chromosome names and sizes.
    inputBinding:
      position: 103
      prefix: --chrom-sizes
  - id: fraction_high
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included in WPS calculation. 
      Deprecated. Use --max-length instead.
    inputBinding:
      position: 103
      prefix: --fraction_high
  - id: fraction_low
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included in WPS calculation. 
      Deprecated. Use --min-length instead.
    inputBinding:
      position: 103
      prefix: --fraction_low
  - id: interval_size
    type:
      - 'null'
      - int
    doc: Size in bp of the intervals to calculate WPS over. Thesenew intervals 
      are centered over those specified in the site_bed.
    inputBinding:
      position: 103
      prefix: --interval-size
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included. Default is 180, 
      corresponding to L-WPS.
    inputBinding:
      position: 103
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included. Default is 120, 
      corresponding to L-WPS.
    inputBinding:
      position: 103
      prefix: --min-length
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 103
      prefix: --quality-threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the sliding window used to calculate WPS scores.
    inputBinding:
      position: 103
      prefix: --window-size
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 103
      prefix: --workers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: A bigWig file containing the WPS results over the intervals specified 
      in interval file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
