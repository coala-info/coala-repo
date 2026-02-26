cwlVersion: v1.2
class: CommandLineTool
baseCommand: minnow simulate
label: minnow_simulate
doc: "Simulate single-cell RNA-seq data\n\nTool homepage: https://github.com/COMBINE-lab/minnow"
inputs:
  - id: alevin_mode
    type:
      - 'null'
      - boolean
    doc: Enable Alevin mode
    inputBinding:
      position: 101
      prefix: --alevin-mode
  - id: bfh_file
    type:
      - 'null'
      - File
    doc: BFH file
    inputBinding:
      position: 101
      prefix: --bfh
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Output in binary format
    inputBinding:
      position: 101
      prefix: --binary
  - id: clusters
    type:
      - 'null'
      - int
    doc: Number of clusters
    inputBinding:
      position: 101
      prefix: --clusters
  - id: count_prob
    type:
      - 'null'
      - float
    doc: Global count probability
    inputBinding:
      position: 101
      prefix: --countProb
  - id: dbg
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 101
      prefix: --dbg
  - id: dup_counts
    type:
      - 'null'
      - boolean
    doc: Include duplicate counts
    inputBinding:
      position: 101
      prefix: --dupCounts
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate for sequences
    inputBinding:
      position: 101
      prefix: -e
  - id: gencode
    type:
      - 'null'
      - boolean
    doc: Use GENCODE annotation
    inputBinding:
      position: 101
      prefix: --gencode
  - id: gene_prob
    type:
      - 'null'
      - float
    doc: Gene level probability
    inputBinding:
      position: 101
      prefix: --geneProb
  - id: gene_to_transcript
    type:
      - 'null'
      - File
    doc: Gene to transcript mapping file
    inputBinding:
      position: 101
      prefix: --g2t
  - id: generate_noisy_cells
    type:
      - 'null'
      - boolean
    doc: Generate noisy cells
    inputBinding:
      position: 101
      prefix: --generateNoisyCells
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome file
    inputBinding:
      position: 101
      prefix: --genome
  - id: gfa_file
    type:
      - 'null'
      - File
    doc: GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: intron_file
    type:
      - 'null'
      - File
    doc: Intron file
    inputBinding:
      position: 101
      prefix: --intronfile
  - id: mat_file_input
    type: File
    doc: Input MAT file
    inputBinding:
      position: 101
      prefix: -m
  - id: no_dump
    type:
      - 'null'
      - boolean
    doc: Disable dumping of intermediate files
    inputBinding:
      position: 101
      prefix: --noDump
  - id: normal_mode
    type:
      - 'null'
      - boolean
    doc: Enable normal mode
    inputBinding:
      position: 101
      prefix: --normal-mode
  - id: num_mol_file
    type: File
    doc: Number of molecules file
    inputBinding:
      position: 101
      prefix: --numMolFile
  - id: num_of_doublets
    type:
      - 'null'
      - int
    doc: Number of doublets
    inputBinding:
      position: 101
      prefix: --numOfDoublets
  - id: num_pcr_cycles
    type:
      - 'null'
      - int
    doc: Number of PCR cycles
    inputBinding:
      position: 101
      prefix: -c
  - id: num_transcripts
    type:
      - 'null'
      - int
    doc: Number of transcripts
    inputBinding:
      position: 101
      prefix: -g
  - id: pcr_cycles
    type:
      - 'null'
      - int
    doc: Number of PCR cycles
    inputBinding:
      position: 101
      prefix: --PCR
  - id: pcr_model6
    type:
      - 'null'
      - boolean
    doc: Use PCR model 6
    inputBinding:
      position: 101
      prefix: --PCRmodel6
  - id: poly_a
    type:
      - 'null'
      - boolean
    doc: Simulate polyA tails
    inputBinding:
      position: 101
      prefix: --polyA
  - id: poly_a_fraction
    type:
      - 'null'
      - float
    doc: PolyA fraction
    inputBinding:
      position: 101
      prefix: --polyAfraction
  - id: poly_a_site
    type:
      - 'null'
      - int
    doc: PolyA site
    inputBinding:
      position: 101
      prefix: --polyAsite
  - id: ref_file
    type: File
    doc: Reference file
    inputBinding:
      position: 101
      prefix: -r
  - id: reverse_uniqness
    type:
      - 'null'
      - boolean
    doc: Reverse uniqueness test
    inputBinding:
      position: 101
      prefix: --reverseUniqness
  - id: rspd_dist
    type:
      - 'null'
      - File
    doc: RNA speed distribution file
    inputBinding:
      position: 101
      prefix: --rspd
  - id: sample_cells
    type:
      - 'null'
      - int
    doc: Number of cells to sample
    inputBinding:
      position: 101
      prefix: -s
  - id: splatter_mode
    type:
      - 'null'
      - boolean
    doc: Enable Splatter mode
    inputBinding:
      position: 101
      prefix: --splatter-mode
  - id: test_uniqness
    type:
      - 'null'
      - boolean
    doc: Test uniqueness
    inputBinding:
      position: 101
      prefix: --testUniqness
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -p
  - id: use_weibull
    type:
      - 'null'
      - boolean
    doc: Use Weibull distribution
    inputBinding:
      position: 101
      prefix: --useWeibull
  - id: use_white_list
    type:
      - 'null'
      - boolean
    doc: Use whitelist for cell barcodes
    inputBinding:
      position: 101
      prefix: --useWhiteList
  - id: velocity
    type:
      - 'null'
      - boolean
    doc: Enable velocity simulation
    inputBinding:
      position: 101
      prefix: --velocity
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: mat_file_output
    type: File
    doc: Output MAT file
    outputBinding:
      glob: $(inputs.mat_file_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minnow:1.2--h86b0361_0
