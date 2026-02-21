cwlVersion: v1.2
class: CommandLineTool
baseCommand: seismic
label: seismic-rna_seismic
doc: "Seismic-RNA tool (Note: The provided input text contains system error logs rather
  than command-line help documentation, so arguments could not be extracted.)\n\n
  Tool homepage: https://github.com/rouskinlab/seismic-rna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
stdout: seismic-rna_seismic.out
