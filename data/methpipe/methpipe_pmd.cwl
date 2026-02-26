cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmd
label: methpipe_pmd
doc: "Identify PMDs in methylomes. Methylation must be provided in the methcounts
  file format (chrom, position, strand, context, methylation, reads). This program
  assumes only data at CpG sites and that strands are collapsed so only the positive
  site appears in the file, but reads counts are from both strands.\n\nTool homepage:
  https://github.com/smithlabcode/methpipe"
inputs:
  - id: methcount_files
    type:
      type: array
      items: File
    doc: Methylation provided in the methcounts file format
    inputBinding:
      position: 1
  - id: array_mode
    type:
      - 'null'
      - boolean
    doc: All samples are array
    inputBinding:
      position: 102
      prefix: -arraymode
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -debug
  - id: fixed_bin_size
    type:
      - 'null'
      - int
    doc: Fixed bin size
    inputBinding:
      position: 102
      prefix: -fixedbin
  - id: max_dist_bins
    type:
      - 'null'
      - int
    doc: max dist between bins with data in PMD
    inputBinding:
      position: 102
      prefix: -desert
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: max iterations
    inputBinding:
      position: 102
      prefix: -itr
  - id: params_in
    type:
      - 'null'
      - type: array
        items: File
    doc: HMM parameter files for individual methylomes (separated with comma)
    inputBinding:
      position: 102
      prefix: -params-in
  - id: posteriors_out
    type:
      - 'null'
      - boolean
    doc: write out posterior probabilities in methcounts format
    inputBinding:
      position: 102
      prefix: -posteriors-out
  - id: seed
    type:
      - 'null'
      - int
    doc: specify random seed
    inputBinding:
      position: 102
      prefix: -seed
  - id: starting_bin_size
    type:
      - 'null'
      - int
    doc: Starting bin size
    inputBinding:
      position: 102
      prefix: -bin
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
  - id: params_out
    type:
      - 'null'
      - File
    doc: write HMM parameters to this file
    outputBinding:
      glob: $(inputs.params_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
