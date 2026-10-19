cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasirecomb
label: quasirecomb
doc: "QuasiRecomb is a tool for the inference of viral quasispecies from next-generation sequencing data, accounting for recombination.\n\nTool homepage: https://github.com/cbg-ethz/QuasiRecomb"
inputs:
  - id: input_file
    type: File
    doc: "Alignment file in BAM or SAM format."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: -i
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Path to the output directory (default: current directory)."
    inputBinding:
      position: 101
      prefix: -o
  - id: k
    type:
      - 'null'
      - string
    doc: "The interval or fixed number of sequence generators, i.e. 1-4 or 2."
    inputBinding:
      position: 101
      prefix: -K
  - id: em_restarts_model_selection
    type:
      - 'null'
      - int
    doc: "The number of EM restarts during model selection (default: 5)."
    inputBinding:
      position: 101
      prefix: -m
  - id: em_restarts_best_k
    type:
      - 'null'
      - int
    doc: "The number of EM restarts for best K to find optimum (default: 50)."
    inputBinding:
      position: 101
      prefix: -t
  - id: region
    type:
      - 'null'
      - string
    doc: "Only reconstruct a specific region, INT-INT."
    inputBinding:
      position: 101
      prefix: -r
  - id: no_recomb
    type:
      - 'null'
      - boolean
    doc: "Do not allow recombination."
    inputBinding:
      position: 101
      prefix: -noRecomb
  - id: quality
    type:
      - 'null'
      - boolean
    doc: "Account phred quality scores (slower runtime)."
    inputBinding:
      position: 101
      prefix: -quality
  - id: print_alignment
    type:
      - 'null'
      - boolean
    doc: "Save alignment.txt in a human readable format."
    inputBinding:
      position: 101
      prefix: -printAlignment
  - id: sample_proteins
    type:
      - 'null'
      - boolean
    doc: "Sample full-length protein sequences in three reading frames."
    inputBinding:
      position: 101
      prefix: -sampleProteins
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: "Report regions with a minimum coverage of 100x, 500x, 1,000x and 10,000x for a single region of interest."
    inputBinding:
      position: 101
      prefix: -coverage
  - id: refine
    type:
      - 'null'
      - boolean
    doc: "Only after QuasiRecomb has been executed once before on the same dataset in the same directory; thins the number of haplotypes."
    inputBinding:
      position: 101
      prefix: -refine
  - id: no_gaps
    type:
      - 'null'
      - boolean
    doc: "Ignore gaps; useful if data is 454 and gaps are only technical errors."
    inputBinding:
      position: 101
      prefix: -noGaps
  - id: conservative
    type:
      - 'null'
      - boolean
    doc: "Use this if the major haplotypes are only of interest."
    inputBinding:
      position: 101
      prefix: -conservative
  - id: max_del
    type:
      - 'null'
      - int
    doc: "Remove reads with more than INT consecutive deletions."
    inputBinding:
      position: 101
      prefix: -maxDel
  - id: max_perc_del
    type:
      - 'null'
      - float
    doc: "Remove reads with more than DOUBLE ratio of deletions, between 0.0 - 1.0."
    inputBinding:
      position: 101
      prefix: -maxPercDel
  - id: unpaired
    type:
      - 'null'
      - boolean
    doc: "If read names are not unique and reads are single-end, prevent pairing and merging."
    inputBinding:
      position: 101
      prefix: -unpaired
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: result_files
    type:
      type: array
      items: File
    doc: Result files written to the working directory
    outputBinding:
      glob: ['*.fasta', '*.csv', '*.txt', '*.html']
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: '${ return inputs.output_dir ? inputs.output_dir : "_unused_out"; }'
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasirecomb:1.2--0
stdout: quasirecomb.out
