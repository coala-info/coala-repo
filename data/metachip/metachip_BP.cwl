cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MetaCHIP
  - BP
label: metachip_BP
doc: "Run the best-match and phylogenetic approaches on the files prepared by the PI
  module, and report detected horizontal gene transfers.\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: "$(inputs.prefix)_MetaCHIP_wd"
        entry: $(inputs.pi_working_dir)
        writable: true
inputs:
  - id: pi_working_dir
    type: Directory
    doc: "<prefix>_MetaCHIP_wd folder made by MetaCHIP PI (staged writable under that name)"
  - id: output_folder
    type: ['null', string]
    doc: 'output folder (default: current working directory)'
    inputBinding:
      prefix: -o
  - id: prefix
    type: string
    doc: output prefix
    inputBinding:
      prefix: -p
  - id: rank
    type: ['null', string]
    doc: grouping rank
    inputBinding:
      prefix: -r
  - id: grouping
    type: ['null', File]
    doc: grouping file
    inputBinding:
      prefix: -g
  - id: coverage_cutoff
    type: ['null', int]
    doc: 'coverage cutoff, default: 75'
    inputBinding:
      prefix: -cov
  - id: alignment_length_cutoff
    type: ['null', int]
    doc: 'alignment length cutoff, default: 200'
    inputBinding:
      prefix: -al
  - id: flanking_length
    type: ['null', int]
    doc: 'the length of flanking sequences to plot (Kbp), default: 10'
    inputBinding:
      prefix: -flk
  - id: plot_flanking_regions
    type: ['null', boolean]
    doc: plot flanking_regions of identified HGTs
    inputBinding:
      prefix: -pfr
  - id: identity_percentile
    type: ['null', int]
    doc: 'identity percentile cutoff, default: 90'
    inputBinding:
      prefix: -ip
  - id: end_match_identity
    type: ['null', int]
    doc: 'end match identity cutoff, default: 80'
    inputBinding:
      prefix: -ei
  - id: threads
    type: ['null', int]
    doc: 'number of threads, default: 1'
    inputBinding:
      prefix: -t
  - id: no_end_break_check
    type: ['null', boolean]
    doc: disable end break and contig match check for fast processing, not recommend
      for metagenome-assembled genomes (MAGs)
    inputBinding:
      prefix: -NoEbCheck
  - id: force
    type: ['null', boolean]
    doc: overwrite previous results
    inputBinding:
      prefix: -force
  - id: quiet
    type: ['null', boolean]
    doc: Do not report progress
    inputBinding:
      prefix: -quiet
  - id: keep_tmp
    type: ['null', boolean]
    doc: keep temporary files
    inputBinding:
      prefix: -tmp
outputs:
  - id: working_dir
    type: Directory
    doc: MetaCHIP working directory with the detected HGT tables and sequences
    outputBinding:
      glob: "$(inputs.output_folder ? inputs.output_folder + '/' : '')$(inputs.prefix)_MetaCHIP_wd"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
