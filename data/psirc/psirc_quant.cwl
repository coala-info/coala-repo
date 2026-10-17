cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psirc-quant
  - quant
label: psirc_quant
doc: "Computes equivalence classes for reads and quantifies abundances\n\nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: "FASTQ file(s) (a read pair, or single-end reads with --single)"
    inputBinding:
      position: 30
  - id: index
    type: File
    doc: "Index to be used for quantification"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_dir
    type: string
    doc: "Directory to write output to"
    inputBinding:
      position: 2
      prefix: -o
  - id: bias
    type:
      - 'null'
      - boolean
    doc: "Perform sequence based bias correction"
    inputBinding:
      position: 3
      prefix: --bias
  - id: plaintext
    type:
      - 'null'
      - boolean
    doc: "Output plaintext instead of HDF5"
    inputBinding:
      position: 6
      prefix: --plaintext
  - id: fusion
    type:
      - 'null'
      - boolean
    doc: "Search for fusions for Pizzly"
    inputBinding:
      position: 7
      prefix: --fusion
  - id: single
    type:
      - 'null'
      - boolean
    doc: "Quantify single-end reads"
    inputBinding:
      position: 8
      prefix: --single
  - id: single_overhang
    type:
      - 'null'
      - boolean
    doc: "Include reads where unobserved rest of fragment is predicted to lie outside a transcript"
    inputBinding:
      position: 9
      prefix: --single-overhang
  - id: fr_stranded
    type:
      - 'null'
      - boolean
    doc: "Strand specific reads, first read forward"
    inputBinding:
      position: 10
      prefix: --fr-stranded
  - id: rf_stranded
    type:
      - 'null'
      - boolean
    doc: "Strand specific reads, first read reverse"
    inputBinding:
      position: 11
      prefix: --rf-stranded
  - id: pseudobam
    type:
      - 'null'
      - boolean
    doc: "Save pseudoalignments to transcriptome to BAM file"
    inputBinding:
      position: 19
      prefix: --pseudobam
  - id: genomebam
    type:
      - 'null'
      - boolean
    doc: "Project pseudoalignments to genome sorted BAM file"
    inputBinding:
      position: 20
      prefix: --genomebam
  - id: bootstrap_samples
    type:
      - 'null'
      - int
    doc: "Number of bootstrap samples (default: 0)"
    inputBinding:
      position: 4
      prefix: -b
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for the bootstrap sampling (default: 42)"
    inputBinding:
      position: 5
      prefix: --seed
  - id: fragment_length
    type:
      - 'null'
      - float
    doc: "Estimated average fragment length"
    inputBinding:
      position: 12
      prefix: -l
  - id: sd
    type:
      - 'null'
      - float
    doc: "Estimated standard deviation of fragment length"
    inputBinding:
      position: 13
      prefix: -s
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: "Minimum length of a valid fragment"
    inputBinding:
      position: 14
      prefix: -x
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: "Maximum length of a valid fragment"
    inputBinding:
      position: 15
      prefix: -X
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 1)"
    inputBinding:
      position: 16
      prefix: -t
  - id: gtf
    type:
      - 'null'
      - File
    doc: "GTF file for transcriptome information (required for --genomebam)"
    inputBinding:
      position: 17
      prefix: -g
  - id: chromosomes
    type:
      - 'null'
      - File
    doc: "Tab separated file with chromosome names and lengths (optional for --genomebam)"
    inputBinding:
      position: 18
      prefix: -c
outputs:
  - id: output
    type: Directory
    doc: "Output directory with abundance and run info files"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
