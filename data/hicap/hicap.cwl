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
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicap:1.0.4--pyhdfd78af_2
