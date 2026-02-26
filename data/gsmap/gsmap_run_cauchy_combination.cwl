cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap_run_cauchy_combination
label: gsmap_run_cauchy_combination
doc: "Combines Cauchy results for multiple samples.\n\nTool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: annotation
    type: string
    doc: Name of the annotation in adata.obs to use.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of the sample.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: sample_name_list
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sample names to process. Provide as a space-separated list.
    inputBinding:
      position: 101
      prefix: --sample_name_list
  - id: trait_name
    type: string
    doc: Name of the trait being analyzed.
    inputBinding:
      position: 101
      prefix: --trait_name
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to save the combined Cauchy results. Required when using multiple 
      samples.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
