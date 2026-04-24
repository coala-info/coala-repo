cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - seqsort
label: fermi_seqrank
doc: "Sorts an FMD-index for Fermi.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: reads_fmd
    type: File
    doc: Input FMD-index file.
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_seqrank.out
