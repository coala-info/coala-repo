cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk quickrun
label: cctk_quickrun
doc: "Runs the cctk pipeline on a directory of genome fastas.\n\nTool homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: indir
    type: Directory
    doc: input directory containing genome fastas.
    inputBinding:
      position: 101
      prefix: --indir
  - id: max_cluster
    type:
      - 'null'
      - int
    doc: Largest cluster size to plot.
    inputBinding:
      position: 101
      prefix: --max-cluster
outputs:
  - id: outdir
    type: Directory
    doc: directory to write output files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
