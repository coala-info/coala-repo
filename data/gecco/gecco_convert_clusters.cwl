cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gecco
  - convert
  - clusters
label: gecco_convert_clusters
doc: "Convert the clusters table written by GECCO to a different format (gff).\n\nTool homepage: https://gecco.embl.de/"
inputs:
  - id: input_dir
    type: Directory
    doc: "The path to the input directory containing files to convert"
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: format
    type: string
    doc: "The output format to write: gff"
    inputBinding:
      position: 101
      prefix: --format
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "The path to the directory where to write converted files"
    inputBinding:
      position: 101
      prefix: --output-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory with the converted files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
stdout: gecco_convert_clusters.out
