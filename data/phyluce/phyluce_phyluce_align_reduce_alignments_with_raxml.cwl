cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_reduce_alignments_with_raxml]
label: phyluce_phyluce_align_reduce_alignments_with_raxml
doc: "Reduce a directory of alignments using RAxML.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "Input folder of alignments."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "Output folder for reduced alignments."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, phylip, phylip-relaxed (default: phylip-relaxed)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: cores
    type: ['null', int]
    doc: "The number of compute cores to use."
    inputBinding:
      position: 4
      prefix: --cores
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
    doc: "Folder of reduced alignments."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.alignments)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
