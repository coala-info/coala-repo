cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_plot_sample_qc
label: illumina-interop_plot_sample_qc
doc: "Plot the sample QC (index) metrics (gnuplot data on standard output)\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs:
  - id: run_folder
    type: Directory
    doc: Path to the run folder
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: interop_plot_sample_qc.out
