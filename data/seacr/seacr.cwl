cwlVersion: v1.2
class: CommandLineTool
baseCommand: SEACR.sh
label: seacr
doc: "SEACR is a highly selective peak caller for CUT&RUN tool that uses the global
  distribution of background signal to determine a threshold for peak calling.\n\n
  Tool homepage: https://github.com/FredHutch/SEACR"
inputs:
  - id: experimental_bedgraph
    type: File
    doc: Target data bedgraph file in UCSC format
    inputBinding:
      position: 1
  - id: control
    type: string
    doc: Control (IgG) data bedgraph file OR a numeric threshold (0-1) representing
      the fraction of the top percentage of peaks to retain
    inputBinding:
      position: 2
  - id: normalization
    type: string
    doc: "Whether to normalize the data. Options: 'norm' (normalize) or 'non' (do
      not normalize)"
    inputBinding:
      position: 3
  - id: stringency
    type: string
    doc: "Stringency level for peak calling. Options: 'relaxed' or 'stringent'"
    inputBinding:
      position: 4
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for the output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seacr:1.3--hdfd78af_2
