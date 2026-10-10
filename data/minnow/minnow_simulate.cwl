cwlVersion: v1.2
class: CommandLineTool
label: minnow_simulate
doc: "Simulate droplet-based single-cell RNA-seq reads from a count matrix and a transcriptome\n\nTool homepage: https://github.com/COMBINE-lab/minnow"
arguments:
  - position: -1
    shellQuote: false
    valueFrom: mkdir -p minnow_run && cd minnow_run && minnow simulate
inputs:
  - id: whitelist_file
    type: File
    doc: 10X cell barcode whitelist (737K-august-2016.txt). Minnow reads it from ../data/ relative to its working directory, so it is staged there.
  - id: uniqueness_file
    type:
      - 'null'
      - File
    doc: Gene uniqueness file (hg_stranded_gene_uniqueness.txt), used with --testUniqness or --reverseUniqness. Staged in the data folder where minnow looks for it.
  - id: alevin_mode
    type:
      - 'null'
      - boolean
    doc: The program assumes that the input matrix is obtained from Alevin
    inputBinding:
      position: 101
      prefix: --alevin-mode
  - id: splatter_mode
    type:
      - 'null'
      - boolean
    doc: Matrix file is obtained from running splatter
    inputBinding:
      position: 101
      prefix: --splatter-mode
  - id: normal_mode
    type:
      - 'null'
      - boolean
    doc: User provided matrix
    inputBinding:
      position: 101
      prefix: --normal-mode
  - id: test_uniqness
    type:
      - 'null'
      - boolean
    doc: Test uniqueness
    inputBinding:
      position: 101
      prefix: --testUniqness
  - id: reverse_uniqness
    type:
      - 'null'
      - boolean
    doc: Reverse uniqueness
    inputBinding:
      position: 101
      prefix: --reverseUniqness
  - id: use_weibull
    type:
      - 'null'
      - boolean
    doc: Use the Weibull distribution
    inputBinding:
      position: 101
      prefix: --useWeibull
  - id: num_of_doublets
    type:
      - 'null'
      - int
    doc: Number of doublets to be generated
    inputBinding:
      position: 101
      prefix: --numOfDoublets
  - id: num_mol_file
    type:
      - 'null'
      - File
    doc: Number of molecules generated from each cell
    inputBinding:
      position: 101
      prefix: --numMolFile
  - id: gencode
    type:
      - 'null'
      - boolean
    doc: Gencode reference has | separator
    inputBinding:
      position: 101
      prefix: --gencode
  - id: ref_file
    type: File
    doc: Transcriptome reference file (FASTA)
    inputBinding:
      position: 101
      prefix: -r
  - id: gene_tr
    type:
      - 'null'
      - File
    doc: Tab separated list of gene to transcript mapping
    inputBinding:
      position: 101
      prefix: --g2t
  - id: rspd_dist
    type:
      - 'null'
      - File
    doc: Tab separated read start position distribution
    inputBinding:
      position: 101
      prefix: --rspd
  - id: bfh_file
    type:
      - 'null'
      - File
    doc: BFH file
    inputBinding:
      position: 101
      prefix: --bfh
  - id: gene_prob
    type:
      - 'null'
      - File
    doc: Gene level probability file (TSV)
    inputBinding:
      position: 101
      prefix: --geneProb
  - id: count_prob
    type:
      - 'null'
      - File
    doc: Global scale count probability file
    inputBinding:
      position: 101
      prefix: --countProb
  - id: velocity
    type:
      - 'null'
      - boolean
    doc: In velocity mode reads are generated from exon-exon junctions
    inputBinding:
      position: 101
      prefix: --velocity
  - id: binary
    type:
      - 'null'
      - boolean
    doc: The matrix file is written in binary
    inputBinding:
      position: 101
      prefix: --binary
  - id: dbg
    type:
      - 'null'
      - boolean
    doc: Use the provided GFA file and BFH
    inputBinding:
      position: 101
      prefix: --dbg
  - id: no_dump
    type:
      - 'null'
      - boolean
    doc: Use the model file made
    inputBinding:
      position: 101
      prefix: --noDump
  - id: gfa_file
    type:
      - 'null'
      - File
    doc: GFA file for contigs
    inputBinding:
      position: 101
      prefix: --gfa
  - id: dup_counts
    type:
      - 'null'
      - boolean
    doc: Read the dup counts TSV filtered_cb_frequency.txt in the same folder
    inputBinding:
      position: 101
      prefix: --dupCounts
  - id: use_white_list
    type:
      - 'null'
      - boolean
    doc: Read the dup counts TSV filtered_cb_frequency.txt in the same folder
    inputBinding:
      position: 101
      prefix: --useWhiteList
  - id: generate_noisy_cells
    type:
      - 'null'
      - boolean
    doc: Read the dup counts TSV filtered_cb_frequency.txt in the same folder
    inputBinding:
      position: 101
      prefix: --generateNoisyCells
  - id: poly_a
    type:
      - 'null'
      - boolean
    doc: Sample with polyA sites; use with --polyAsite and --polyAfraction
    inputBinding:
      position: 101
      prefix: --polyA
  - id: poly_a_site
    type:
      - 'null'
      - File
    doc: FASTA file with polyA sites
    inputBinding:
      position: 101
      prefix: --polyAsite
  - id: poly_a_fraction
    type:
      - 'null'
      - File
    doc: File with polyA site fraction
    inputBinding:
      position: 101
      prefix: --polyAfraction
  - id: sample_cells
    type:
      - 'null'
      - int
    doc: Sample this many cells from the set of all cells
    inputBinding:
      position: 101
      prefix: -s
  - id: intron_file
    type:
      - 'null'
      - File
    doc: Intron BED file which contains the intron boundaries per transcript
    inputBinding:
      position: 101
      prefix: --intronfile
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome FASTA file
    inputBinding:
      position: 101
      prefix: --genome
  - id: num_cells
    type:
      - 'null'
      - int
    doc: Number of cells required for simulation (default = 10)
    inputBinding:
      position: 101
      prefix: -c
  - id: num_transcripts
    type:
      - 'null'
      - int
    doc: Number of transcripts for simulation (default = 100)
    inputBinding:
      position: 101
      prefix: -g
  - id: clusters
    type:
      - 'null'
      - File
    doc: Gene cluster file (use with --dbg)
    inputBinding:
      position: 101
      prefix: --clusters
  - id: pcr_cycles
    type:
      - 'null'
      - int
    doc: Maximum cycles to repeat PCR (default = 5)
    inputBinding:
      position: 101
      prefix: --PCR
  - id: pcr_model6
    type:
      - 'null'
      - boolean
    doc: Model6 from Best, Katharine et al. (2015)
    inputBinding:
      position: 101
      prefix: --PCRmodel6
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate to be introduced while producing sequences
    inputBinding:
      position: 101
      prefix: -e
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to parallelize the process
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: -v
  - id: mat_dir
    type:
      - File
      - Directory
    doc: Directory with the matrix files (quants_mat.csv or quants_mat.gz, quants_mat_rows.txt, quants_mat_cols.txt), or the matrix file itself
    inputBinding:
      position: 101
      prefix: -m
  - id: out_dir_path
    type: string
    doc: Output directory; the simulated reads are written here
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: out_dir
    type: Directory
    doc: The simulated reads are written here
    outputBinding:
      glob: minnow_run/$(inputs.out_dir_path)
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: data/737K-august-2016.txt
        entry: $(inputs.whitelist_file)
      - entryname: data/hg/hg_stranded_gene_uniqueness.txt
        entry: $(inputs.uniqueness_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minnow:1.2--h86b0361_0
