cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-plot-model]
label: rsem_rsem-plot-model
doc: "Plot the model files (fragment length, read start position, quality, mismatch profiles) learned by rsem-calculate-expression into a PDF file.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: sample_name
    type: string
    doc: The sample name used with rsem-calculate-expression. The tool reads the folder sample_name.stat.
    inputBinding:
      position: 1
  - id: stat_dir
    type: Directory
    doc: The sample_name.stat folder written by rsem-calculate-expression. It is staged as sample_name.stat.
  - id: output_plot_file
    type: string
    doc: Name of the output PDF plot file.
    inputBinding:
      position: 2
outputs:
  - id: plot
    type: File
    doc: PDF file with the model plots.
    outputBinding:
      glob: $(inputs.output_plot_file)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.sample_name).stat
        entry: $(inputs.stat_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
