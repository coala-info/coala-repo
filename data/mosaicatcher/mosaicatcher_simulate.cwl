cwlVersion: v1.2
class: CommandLineTool
baseCommand: simulate
label: mosaicatcher_simulate
doc: "Simulate binned Strand-seq data.\n\nTool homepage: https://github.com/friendsofstrandseq/mosaicatcher/"
inputs:
  - id: sv_conf_file
    type: File
    doc: SV-conf-file
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: 'noise added to all bins: mostly 0, but for a fraction alpha drawn from geometrix
      distribution'
    inputBinding:
      position: 102
      prefix: --alpha
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Chrom names & length file. Default: GRch38'
    inputBinding:
      position: 102
      prefix: --genome
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: max. read coverage per bin
    inputBinding:
      position: 102
      prefix: --maxCoverage
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: min. read coverage per bin
    inputBinding:
      position: 102
      prefix: --minCoverage
  - id: nbinom_p
    type:
      - 'null'
      - float
    doc: p parameter of the NB distirbution
    inputBinding:
      position: 102
      prefix: --nbinom_p
  - id: num_cells
    type:
      - 'null'
      - int
    doc: number of cells to simulate
    inputBinding:
      position: 102
      prefix: --numcells
  - id: phased_fraction
    type:
      - 'null'
      - float
    doc: Average number of SCEs per cell
    inputBinding:
      position: 102
      prefix: --phasedFraction
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Use this sample name in the output
    inputBinding:
      position: 102
      prefix: --sample-name
  - id: sces_per_cell
    type:
      - 'null'
      - int
    doc: Average number of SCEs per cell
    inputBinding:
      position: 102
      prefix: --scesPerCell
  - id: seed
    type:
      - 'null'
      - string
    doc: Random generator seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: tell me more
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size of fixed windows
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output count file
    outputBinding:
      glob: $(inputs.output_file)
  - id: phases_file
    type:
      - 'null'
      - File
    doc: output phased reads into a file
    outputBinding:
      glob: $(inputs.phases_file)
  - id: sce_file
    type:
      - 'null'
      - File
    doc: output the positions of SCEs
    outputBinding:
      glob: $(inputs.sce_file)
  - id: variant_file
    type:
      - 'null'
      - File
    doc: output SVs and which cells they were simulated in
    outputBinding:
      glob: $(inputs.variant_file)
  - id: segment_file
    type:
      - 'null'
      - File
    doc: output optimal segmentation according to SVs and SCEs.
    outputBinding:
      glob: $(inputs.segment_file)
  - id: info_file
    type:
      - 'null'
      - File
    doc: Write info about samples
    outputBinding:
      glob: $(inputs.info_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
