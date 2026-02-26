cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-end-motifs
label: finaletoolkit_end-motifs
doc: "Measures frequency of k-mer 5' end motifs.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
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
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Length of k-mer.
    inputBinding:
      position: 103
      prefix: --k
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included.
    inputBinding:
      position: 103
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included.
    default: 50
    inputBinding:
      position: 103
      prefix: --min-length
  - id: negative_strand
    type:
      - 'null'
      - boolean
    doc: Set flag in conjunction with -B to only consider 5' end motifs on the 
      negative strand.
    inputBinding:
      position: 103
      prefix: --negative-strand
  - id: no_both_strands
    type:
      - 'null'
      - boolean
    doc: Set flag to only consider one strand for end-motifs.
    inputBinding:
      position: 103
      prefix: --no-both-strands
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
    doc: TSV to print k-mer frequencies. If "-", will write to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
