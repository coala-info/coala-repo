cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_split_concat_nexus_to_loci]
label: phyluce_phyluce_align_split_concat_nexus_to_loci
doc: "Split a concatenated NEXUS file into component loci using the charsets values.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: nexus
    type: File
    doc: "The input NEXUS file."
    inputBinding:
      position: 1
      prefix: --nexus
  - id: output
    type: string
    doc: "The output directory in which to store alignments."
    inputBinding:
      position: 2
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of per-locus alignments."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
