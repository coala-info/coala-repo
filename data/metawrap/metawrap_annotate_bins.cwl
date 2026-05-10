cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap annotate_bins
label: metawrap_annotate_bins
doc: "Annotates metagenomic bins.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: bin_folder
    type: Directory
    doc: folder with metagenomic bins in fasta format
    inputBinding:
      position: 101
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
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
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
