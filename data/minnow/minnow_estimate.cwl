cwlVersion: v1.2
class: CommandLineTool
baseCommand: minnow
label: minnow_estimate
doc: "minnow simulate [--alevin-mode] [--splatter-mode] [--normal-mode] [--testUniqness]
  [--reverseUniqness] [--useWeibull] [--numOfDoublets <number of Doublets>] -m <mat_file>
  -o <mat_file> --numMolFile <num mol file> [--gencode] -r <ref_file> [--g2t <gene_tr>]
  [--rspd <rspd_dist>] [--bfh <BFH file>] [--geneProb <gene level probability>] [--countProb
  <global count probability>] [--velocity] [--binary] [--dbg] [--noDump] [--gfa <gfa_file>]
  [--dupCounts] [--useWhiteList] [--generateNoisyCells] [--polyA] [--polyAsite <polyA_site>]
  [--polyAfraction <polyA_site>] [-s <sample_cells>] [--intronfile <intron_file>]
  [--genome <genome>] [-c <number of PCR cycles>] [-g <number of transcripts>] [--clusters
  <number of transcripts>] [--PCR <number of PCR cycles>] [--PCRmodel6] [-e <error
  rate for sequences>] [-p <number of threads>] [-v]\n        minnow estimate -eq
  <eqclass_dir> -o <mat_file> --g2t <gene_tr> --bfh <bfh_file> [--cluster <cluster>]
  [-v]\n        minnow --help [-v]\n        minnow -h [-v]\n        minnow help [-v]\n\
  \nTool homepage: https://github.com/COMBINE-lab/minnow"
inputs:
  - id: alevin_mode
    type:
      - 'null'
      - boolean
    doc: alevin mode
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
  - id: bfh_file_estimate
    type: File
    doc: bfh_file
    inputBinding:
      position: 101
      prefix: --bfh
  - id: binary
    type:
      - 'null'
      - boolean
    doc: binary
    inputBinding:
      position: 101
      prefix: --binary
  - id: cluster
    type:
      - 'null'
      - string
    doc: cluster
    inputBinding:
      position: 101
      prefix: --cluster
  - id: clusters
    type:
      - 'null'
      - int
    doc: number of transcripts
    inputBinding:
      position: 101
      prefix: --clusters
  - id: dbg
    type:
      - 'null'
      - boolean
    doc: dbg
    inputBinding:
      position: 101
      prefix: --dbg
  - id: dup_counts
    type:
      - 'null'
      - boolean
    doc: dup Counts
    inputBinding:
      position: 101
      prefix: --dupCounts
  - id: eqclass_dir
    type: Directory
    doc: eqclass_dir
    inputBinding:
      position: 101
      prefix: -eq
  - id: error_rate
    type:
      - 'null'
      - float
    doc: error rate for sequences
    inputBinding:
      position: 101
      prefix: -e
  - id: gencode
    type:
      - 'null'
      - boolean
    doc: gencode
    inputBinding:
      position: 101
      prefix: --gencode
  - id: gene_level_probability
    type:
      - 'null'
      - float
    doc: gene level probability
    inputBinding:
      position: 101
      prefix: --geneProb
  - id: gene_tr
    type:
      - 'null'
      - File
    doc: gene_tr
    inputBinding:
      position: 101
      prefix: --g2t
  - id: gene_tr_estimate
    type: File
    doc: gene_tr
    inputBinding:
      position: 101
      prefix: --g2t
  - id: generate_noisy_cells
    type:
      - 'null'
      - boolean
    doc: generate Noisy Cells
    inputBinding:
      position: 101
      prefix: --generateNoisyCells
  - id: genome
    type:
      - 'null'
      - File
    doc: genome
    inputBinding:
      position: 101
      prefix: --genome
  - id: gfa_file
    type:
      - 'null'
      - File
    doc: gfa_file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: global_count_probability
    type:
      - 'null'
      - float
    doc: global count probability
    inputBinding:
      position: 101
      prefix: --countProb
  - id: intron_file
    type:
      - 'null'
      - File
    doc: intron_file
    inputBinding:
      position: 101
      prefix: --intronfile
  - id: mat_file_input
    type:
      - 'null'
      - File
    doc: mat_file
    inputBinding:
      position: 101
      prefix: -m
  - id: no_dump
    type:
      - 'null'
      - boolean
    doc: no Dump
    inputBinding:
      position: 101
      prefix: --noDump
  - id: normal_mode
    type:
      - 'null'
      - boolean
    doc: normal mode
    inputBinding:
      position: 101
      prefix: --normal-mode
  - id: num_mol_file
    type:
      - 'null'
      - File
    doc: num mol file
    inputBinding:
      position: 101
      prefix: --numMolFile
  - id: num_of_doublets
    type:
      - 'null'
      - int
    doc: number of Doublets
    inputBinding:
      position: 101
      prefix: --numOfDoublets
  - id: num_pcr_cycles
    type:
      - 'null'
      - int
    doc: number of PCR cycles
    inputBinding:
      position: 101
      prefix: -c
  - id: num_transcripts
    type:
      - 'null'
      - int
    doc: number of transcripts
    inputBinding:
      position: 101
      prefix: -g
  - id: pcr_cycles
    type:
      - 'null'
      - int
    doc: number of PCR cycles
    inputBinding:
      position: 101
      prefix: --PCR
  - id: pcr_model6
    type:
      - 'null'
      - boolean
    doc: PCR model6
    inputBinding:
      position: 101
      prefix: --PCRmodel6
  - id: poly_a
    type:
      - 'null'
      - boolean
    doc: polyA
    inputBinding:
      position: 101
      prefix: --polyA
  - id: poly_a_fraction
    type:
      - 'null'
      - float
    doc: polyA_site
    inputBinding:
      position: 101
      prefix: --polyAfraction
  - id: poly_a_site
    type:
      - 'null'
      - string
    doc: polyA_site
    inputBinding:
      position: 101
      prefix: --polyAsite
  - id: ref_file
    type:
      - 'null'
      - File
    doc: ref_file
    inputBinding:
      position: 101
      prefix: -r
  - id: reverse_uniqness
    type:
      - 'null'
      - boolean
    doc: reverse Uniqness
    inputBinding:
      position: 101
      prefix: --reverseUniqness
  - id: rspd_dist
    type:
      - 'null'
      - File
    doc: rspd_dist
    inputBinding:
      position: 101
      prefix: --rspd
  - id: sample_cells
    type:
      - 'null'
      - string
    doc: sample_cells
    inputBinding:
      position: 101
      prefix: -s
  - id: splatter_mode
    type:
      - 'null'
      - boolean
    doc: splatter mode
    inputBinding:
      position: 101
      prefix: --splatter-mode
  - id: test_uniqness
    type:
      - 'null'
      - boolean
    doc: test Uniqness
    inputBinding:
      position: 101
      prefix: --testUniqness
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -p
  - id: use_weibull
    type:
      - 'null'
      - boolean
    doc: use Weibull
    inputBinding:
      position: 101
      prefix: --useWeibull
  - id: use_white_list
    type:
      - 'null'
      - boolean
    doc: use WhiteList
    inputBinding:
      position: 101
      prefix: --useWhiteList
  - id: velocity
    type:
      - 'null'
      - boolean
    doc: velocity
    inputBinding:
      position: 101
      prefix: --velocity
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: mat_file_output
    type:
      - 'null'
      - File
    doc: mat_file
    outputBinding:
      glob: $(inputs.mat_file_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minnow:1.2--h86b0361_0
