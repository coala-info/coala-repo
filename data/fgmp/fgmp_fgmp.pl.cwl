cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgmp_fgmp.pl
label: fgmp_fgmp.pl
doc: "Fungal Genome Mapping Project (FGMP) - A tool for assessing the quality of fungal
  genome assemblies.\n\nTool homepage: https://github.com/stajichlab/FGMP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgmp:1.0.3--pl526_0
stdout: fgmp_fgmp.pl.out
