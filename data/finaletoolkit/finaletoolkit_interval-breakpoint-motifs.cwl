cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-interval-ebreakpointnd-motifs
label: finaletoolkit_interval-breakpoint-motifs
doc: "Measures frequency of k-mer 5' breakpoint motifs in each region specified in
  a BED file and writes data into a table.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to a BAM/CRAM/Fragment file containing fragment data.
    inputBinding:
      position: 1
  - id: refseq_file
    type: File
    doc: The .2bit file for the associate reference genome sequence used during 
      alignment.
    inputBinding:
      position: 2
  - id: intervals
    type: File
    doc: Path to a BED file containing intervals to retrieve breakpoint motif 
      frequencies over.
    inputBinding:
      position: 3
  - id: fraction_high
    type:
      - 'null'
      - int
    doc: Deprecated alias for --max-length
    inputBinding:
      position: 104
      prefix: --fraction-high
  - id: fraction_low
    type:
      - 'null'
      - int
    doc: Deprecated alias for --min-length
    inputBinding:
      position: 104
      prefix: --fraction-low
  - id: k
    type:
      - 'null'
      - int
    doc: Length of k-mer.
    inputBinding:
      position: 104
      prefix: -k
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
    default: 50
    inputBinding:
      position: 104
      prefix: --min-length
  - id: negative_strand
    type:
      - 'null'
      - boolean
    doc: Set flag in conjunction with -B to only consider 5' breakpoint motifs 
      on the negative strand.
    inputBinding:
      position: 104
      prefix: --negative-strand
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 104
      prefix: --quality-threshold
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Set flag to only consider one strand for breakpoint-motifs. By default,
      the positive strand is calculated, but with the -n flag, the 5' breakpoint
      motifs of the negative strand are considered instead.
    inputBinding:
      position: 104
      prefix: --single-strand
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
    doc: Path to TSV or CSV file to write breakpoint motif frequencies to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
