cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk minced
label: cctk_minced
doc: "Find and process CRISPR arrays using minced.\n\nTool homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: add new CRISPR data to a previous run
    inputBinding:
      position: 101
      prefix: --append
  - id: indir
    type:
      - 'null'
      - Directory
    doc: input directory containing genome fastas.
    inputBinding:
      position: 101
      prefix: --indir
  - id: min_shared
    type:
      - 'null'
      - int
    doc: minimum spacers shared to draw an edge in network
    inputBinding:
      position: 101
      prefix: --min-shared
  - id: minced_path
    type:
      - 'null'
      - File
    doc: path to minced executable if not in PATH
    inputBinding:
      position: 101
      prefix: --minced-path
  - id: process_minced
    type:
      - 'null'
      - boolean
    doc: run processing steps on minced output
    inputBinding:
      position: 101
      prefix: --process-minced
  - id: repeats
    type:
      - 'null'
      - File
    doc: CRISPR repeats in FASTA format
    inputBinding:
      position: 101
      prefix: --repeats
  - id: run_minced
    type:
      - 'null'
      - boolean
    doc: run minced to find CRISPR arrays
    inputBinding:
      position: 101
      prefix: --run-minced
  - id: snp_thresh
    type:
      - 'null'
      - int
    doc: number of SNPs to consider spacers the same.
    inputBinding:
      position: 101
      prefix: --snp-thresh
outputs:
  - id: outdir
    type: Directory
    doc: directory for minced output and processed files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
