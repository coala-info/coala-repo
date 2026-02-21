cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_quality_boxplot_graph.sh
label: fastx-toolkit_fastq_quality_boxplot_graph.sh
doc: "A tool from the FASTX-Toolkit for generating quality boxplot graphs from FASTQ
  files. (Note: The provided help text contained only system error messages and no
  usage information.)\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastq_quality_boxplot_graph.sh.out
