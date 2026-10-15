cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_randomly_sample_and_concatenate]
label: phyluce_phyluce_align_randomly_sample_and_concatenate
doc: "Randomly sample a directory of NEXUS files, concatenate, and output.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing NEXUS alignments to sample and concatenate."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The output directory to hold concatenated files."
    inputBinding:
      position: 2
      prefix: --output
  - id: sample_size
    type: ['null', int]
    doc: "The number of loci to sample (default: 100)."
    inputBinding:
      position: 3
      prefix: --sample-size
  - id: replicates
    type: ['null', int]
    doc: "The number of replicate samples to take (default: 1)."
    inputBinding:
      position: 4
      prefix: --replicates
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 5
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 6
      prefix: --log-path
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of concatenated random samples."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
