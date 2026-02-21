cwlVersion: v1.2
class: CommandLineTool
baseCommand: virsorter_wrapper_phage_contigs_sorter_iPlant.pl
label: virsorter_wrapper_phage_contigs_sorter_iPlant.pl
doc: "A wrapper script for VirSorter (phage contigs sorter). Note: The provided text
  contains system execution logs and a fatal error regarding container image retrieval
  rather than command-line help documentation; therefore, no arguments could be extracted.\n
  \nTool homepage: https://github.com/simroux/VirSorter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
stdout: virsorter_wrapper_phage_contigs_sorter_iPlant.pl.out
