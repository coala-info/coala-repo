cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicap
label: hicap
doc: "HiCap: A tool for Hi-C data analysis\n\nTool homepage: https://github.com/scwatts/hicap"
inputs:
  - id: query_fp
    type: File
    doc: Input FASTA query
    inputBinding:
      position: 101
      prefix: --query_fp
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicap:1.0.4--pyhdfd78af_2
