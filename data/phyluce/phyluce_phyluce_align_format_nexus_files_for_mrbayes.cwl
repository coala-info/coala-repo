cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_format_nexus_files_for_mrbayes]
label: phyluce_phyluce_align_format_nexus_files_for_mrbayes
doc: "Generate a Nexus file for MrBayes given an raw_input file of Nexus-formatted alignments and a file of models associated with loci.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The path to the alignments directory."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: models
    type: File
    doc: "The path to the model configuration file."
    inputBinding:
      position: 2
      prefix: --models
  - id: output
    type: string
    doc: "The path to the output file."
    inputBinding:
      position: 3
      prefix: --output
  - id: fully_partition
    type: ['null', boolean]
    doc: "Fully partition the output."
    inputBinding:
      position: 4
      prefix: --fully-partition
  - id: interleave
    type: ['null', boolean]
    doc: "Interleave sequence in nexus files."
    inputBinding:
      position: 5
      prefix: --interleave
  - id: unlink
    type: ['null', boolean]
    doc: "Unlink the models."
    inputBinding:
      position: 6
      prefix: --unlink
outputs:
  - id: output_nexus
    type: File
    doc: "NEXUS file with a MrBayes block."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
