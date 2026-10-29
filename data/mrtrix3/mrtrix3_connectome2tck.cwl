cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_connectome2tck
doc: "Extract streamlines from a tractogram based on their assignment to parcellated nodes\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [connectome2tck]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: tracks_in
    type: File
    doc: "the input track file"
    inputBinding:
      position: 10
  - id: assignments_in
    type: File
    doc: "input text file containing the node assignments for each streamline"
    inputBinding:
      position: 11
  - id: prefix_out
    type: string
    doc: "the output file / prefix"
    inputBinding:
      position: 12
  - id: nodes
    type: ['null', string]
    doc: "only select tracks that involve a set of nodes of interest (provide as a comma-separated list of integers)"
    inputBinding:
      prefix: -nodes
  - id: exclusive
    type: ['null', boolean]
    doc: "only select tracks that exclusively connect nodes from within the list of nodes of interest"
    inputBinding:
      prefix: -exclusive
  - id: files
    type: ['null', string]
    doc: "select how the resulting streamlines will be grouped in output files. Options are: per_edge, per_node, single (default: per_edge)"
    inputBinding:
      prefix: -files
  - id: exemplars
    type: ['null', File]
    doc: "generate a mean connection exemplar per edge, rather than keeping all streamlines (the parcellation node image must be provided in order to constrain the exemplar endpoints)"
    inputBinding:
      prefix: -exemplars
  - id: keep_unassigned
    type: ['null', boolean]
    doc: "by default, the program discards those streamlines that are not successfully assigned to a node. Set this option to generate corresponding outputs containing these streamlines (labelled as node index 0)"
    inputBinding:
      prefix: -keep_unassigned
  - id: keep_self
    type: ['null', boolean]
    doc: "by default, the program will not output streamlines that connect to the same node at both ends. Set this option to instead keep these self-connections."
    inputBinding:
      prefix: -keep_self
  - id: tck_weights_in
    type: ['null', File]
    doc: "specify a text scalar file containing the streamline weights"
    inputBinding:
      prefix: -tck_weights_in
  - id: prefix_tck_weights_out
    type: ['null', string]
    doc: "provide a prefix for outputting a text file corresponding to each output file, each containing only the streamline weights relevant for that track file"
    inputBinding:
      prefix: -prefix_tck_weights_out
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      prefix: -nthreads
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: "temporarily set the value of an MRtrix config file entry."
    inputBinding:
      prefix: -config
outputs:
  - id: prefix_out_files
    type: File[]
    doc: "the output file / prefix"
    outputBinding:
      glob: $(inputs.prefix_out)*
  - id: prefix_tck_weights_out_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "provide a prefix for outputting a text file corresponding to each output file, each containing only the streamline weights relevant for that track file"
    outputBinding:
      glob: $(inputs.prefix_tck_weights_out)*
