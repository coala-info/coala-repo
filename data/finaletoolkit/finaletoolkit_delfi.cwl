cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-delfi
label: finaletoolkit_delfi
doc: "Calculates DELFI features over genome, returning information about (GC-corrected)
  short fragments, long fragments, DELFI ratio, and total fragments.\n\nTool homepage:
  https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to a BAM/CRAM/Fragment file containing fragment data.
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: Tab-delimited file containing (1) chrom name and (2) integer length of 
      chromosome in base pairs. Should contain only autosomes ifYou want to 
      replicate the original scripts.
    inputBinding:
      position: 2
  - id: reference_file
    type: File
    doc: The .2bit file for the associate reference genome sequence used during 
      alignment.
    inputBinding:
      position: 3
  - id: bins_file
    type: File
    doc: A BED file containing bins over which to calculate DELFI. To replicate 
      Cristiano et al.'s methodology, use 100kb bins over human autosomes.
    inputBinding:
      position: 4
  - id: blacklist_file
    type:
      - 'null'
      - File
    doc: BED file containing regions to ignore when calculating DELFI.
    inputBinding:
      position: 105
      prefix: --blacklist-file
  - id: gap_file
    type:
      - 'null'
      - File
    doc: BED4 format file containing columns for "chrom", "start","stop", and 
      "type". The "type" column should denote whether the entry corresponds to a
      "centromere", "telomere", or "short arm", and entries not falling into 
      these categories are ignored. This information corresponds to the "gap" 
      track for hg19 in the UCSC Genome Browser.
    inputBinding:
      position: 105
      prefix: --gap-file
  - id: keep_nocov
    type:
      - 'null'
      - boolean
    doc: Skip removal two regions in hg19 with no coverage. Use this flag when 
      not using hg19 human reference genome.
    inputBinding:
      position: 105
      prefix: --keep-nocov
  - id: no_gc_correct
    type:
      - 'null'
      - boolean
    doc: Skip GC correction.
    inputBinding:
      position: 105
      prefix: --no-gc-correct
  - id: no_merge_bins
    type:
      - 'null'
      - boolean
    doc: Keep 100kb bins and do not merge to 5Mb size.
    inputBinding:
      position: 105
      prefix: --no-merge-bins
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 105
      prefix: --quality-threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 105
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Specify size of large genomic intervals to merge smaller 100kb 
      intervals (or whatever the user specified in bins_file) into. Defaultis 
      5000000
    inputBinding:
      position: 105
      prefix: --window-size
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 105
      prefix: --workers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: BED, bed.gz, TSV, or CSV file to write DELFI data to. If "-", writes to
      stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
