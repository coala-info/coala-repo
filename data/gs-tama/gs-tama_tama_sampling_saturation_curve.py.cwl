cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_sampling_saturation_curve.py
label: gs-tama_tama_sampling_saturation_curve.py
doc: "This script uses the TAMA read support levels file to create a saturation curve\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: read_support_file
    type:
      - 'null'
      - File
    doc: Read support file
    inputBinding:
      position: 101
      prefix: -r
  - id: read_bin_size
    type:
      - 'null'
      - int
    doc: Read bin size
    inputBinding:
      position: 101
      prefix: -b
  - id: output_file_name
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Saturation curve table (read count and gene count)
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_sampling_saturation_curve.py.out
