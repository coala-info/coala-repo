cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - summarise
label: lorikeet-genome_lorikeet_summarise
doc: "Summarizes ANI values of a given set of VCF files.\n\nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs:
  - id: vcfs
    type:
      - 'null'
      - type: array
        items: File
    doc: "Paths to input VCF files. Can provide one or more."
    inputBinding:
      position: 100
      prefix: --vcfs
  - id: threads
    type:
      - 'null'
      - int
    doc: "Maximum number of threads used. [default: 8] [default: 8]"
    inputBinding:
      position: 101
      prefix: --threads
  - id: qual_by_depth_filter
    type:
      - 'null'
      - float
    doc: "The minimum QD value for a variant to have for it to be included in the genotyping or ANI analyses. [default: 25] [default: 25.0]"
    inputBinding:
      position: 102
      prefix: --qual-by-depth-filter
  - id: qual_threshold
    type:
      - 'null'
      - float
    doc: "The PHRED-scaled quality score threshold for use with ANI calculations. [default: 150] [default: 150.0]"
    inputBinding:
      position: 103
      prefix: --qual-threshold
  - id: depth_per_sample_filter
    type:
      - 'null'
      - int
    doc: "Minimum depth of a variant in a sample for that sample to be included in ANI & Fst calculations for that variant. [default: 5] [default: 5]"
    inputBinding:
      position: 104
      prefix: --depth-per-sample-filter
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print extra debugging information. [default: not set]"
    inputBinding:
      position: 105
      prefix: --verbose
  - id: output_directory
    type: string
    default: lorikeet_out
    doc: Output directory. Folder will contain subfolders for each input genome.
    inputBinding:
      position: 106
      prefix: --output-directory
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the results
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
