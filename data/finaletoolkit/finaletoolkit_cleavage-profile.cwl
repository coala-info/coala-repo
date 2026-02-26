cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-cleavage-profile
label: finaletoolkit_cleavage-profile
doc: "Calculates cleavage proportion over intervals defined in a BED file based on
  alignment data from a BAM/CRAM/Fragment file.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to a BAM/CRAM/Fragment file containing fragment data.
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: Path to a BED file containing intervals to calculates cleavage 
      proportion over.
    inputBinding:
      position: 2
  - id: chrom_sizes
    type: File
    doc: A .chrom.sizes file containing chromosome names and sizes.
    inputBinding:
      position: 3
  - id: fraction_high
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included in cleavage proportion 
      calculation. Deprecated. Use --max-length instead.
    inputBinding:
      position: 104
      prefix: --fraction-high
  - id: fraction_low
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included in cleavage proportion 
      calculation. Deprecated. Use --min-length instead.
    inputBinding:
      position: 104
      prefix: --fraction_low
  - id: left
    type:
      - 'null'
      - int
    doc: Number of base pairs to subtract from start coordinate to create 
      interval. Useful when dealing with BED files with only CpG coordinates.
    default: 0
    inputBinding:
      position: 104
      prefix: --left
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included.
    inputBinding:
      position: 104
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included.
    inputBinding:
      position: 104
      prefix: --min-length
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 104
      prefix: --quality-threshold
  - id: right
    type:
      - 'null'
      - int
    doc: Number of base pairs to add to stop coordinate to create interval. 
      Useful when dealing with BED files with only CpG coordinates.
    default: 0
    inputBinding:
      position: 104
      prefix: --right
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 104
      prefix: --verbose
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 104
      prefix: --workers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: A bigWig file containing the cleavage proportion results over the 
      intervals specified in interval file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
