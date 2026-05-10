cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - classify_bins
label: metawrap-classify-bins_metawrap
doc: "A tool to classify a set of bins using NCBI taxonomy.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: bin_dir
    type: Directory
    doc: Folder containing the bins to be classified
    inputBinding:
      position: 101
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for the classification results
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-classify-bins:1.3.0--hdfd78af_3
