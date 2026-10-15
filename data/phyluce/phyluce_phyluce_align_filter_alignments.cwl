cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_filter_alignments]
label: phyluce_phyluce_align_filter_alignments
doc: "Filter alignments containing certain taxa or having certain lengths.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing the alignment files."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The directory to write alignments meeting criteria (the folder is created before the run)."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: containing_data_for
    type:
      - 'null'
      - type: array
        items: string
    doc: "Output only alignments containing data for a taxon."
    inputBinding:
      position: 4
      prefix: --containing-data-for
  - id: min_length
    type: ['null', int]
    doc: "Filter out alignments shorter than --min-length."
    inputBinding:
      position: 5
      prefix: --min-length
  - id: min_taxa
    type: ['null', int]
    doc: "Filter out alignments with fewer than --min-taxa."
    inputBinding:
      position: 6
      prefix: --min-taxa
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 7
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 8
      prefix: --log-path
  - id: overwrite_answer
    type: File
    doc: Fixed answer Y sent on standard input to the tool's prompt about overwriting the existing output folder.
    default:
      class: File
      basename: answer_yes.txt
      contents: "Y\n"
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of alignments that meet the criteria."
    outputBinding:
      glob: "$(inputs.output)"
stdin: $(inputs.overwrite_answer.path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.output, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
