cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_gblocks_trimmed_alignments_from_untrimmed]
label: phyluce_phyluce_align_get_gblocks_trimmed_alignments_from_untrimmed
doc: "Use GBLOCKS to trim existing alignments in parallel.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing alignments to be trimmed."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The directory in which to store the resulting alignments."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: fasta)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: output_format
    type: ['null', string]
    doc: "The output alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 4
      prefix: --output-format
  - id: b1
    type: ['null', float]
    doc: "The GBLOCKS -b1 proportion (default: 0.5)."
    inputBinding:
      position: 5
      prefix: --b1
  - id: b2
    type: ['null', float]
    doc: "The GBLOCKS -b2 proportion (default: 0.85)."
    inputBinding:
      position: 6
      prefix: --b2
  - id: b3
    type: ['null', int]
    doc: "The GBLOCKS -b3 integer value (default: 8)."
    inputBinding:
      position: 7
      prefix: --b3
  - id: b4
    type: ['null', int]
    doc: "The GBLOCKS -b4 integer value (default: 10)."
    inputBinding:
      position: 8
      prefix: --b4
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 9
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 10
      prefix: --log-path
  - id: cores
    type: ['null', int]
    doc: "Process alignments in parallel using --cores for alignment. This is the number of PHYSICAL CPUs."
    inputBinding:
      position: 11
      prefix: --cores
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of trimmed alignments."
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
