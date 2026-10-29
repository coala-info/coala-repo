cwlVersion: v1.2
class: CommandLineTool
baseCommand: tck2connectome
label: mrtrix3_tck2connectome
doc: "Generate a connectome matrix from a streamlines file and a node parcellation image\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks_in
    type: File
    doc: "the input track file"
    inputBinding:
      position: 1
  - id: nodes_in
    type: File
    doc: "the input node parcellation image"
    inputBinding:
      position: 2
  - id: connectome_out
    type: string
    doc: "the output .csv file containing edge weights"
    inputBinding:
      position: 3
  - id: assignment_end_voxels
    type: ['null', boolean]
    doc: "use a simple voxel lookup value at each streamline endpoint"
    inputBinding:
      position: 10
      prefix: -assignment_end_voxels
  - id: assignment_radial_search
    type: ['null', float]
    doc: "perform a radial search from each streamline endpoint to locate the nearest node. Argument is the maximum radius in mm; if no node is found within this radius, the streamline endpoint is not assigned to any node. Default search distance is 4mm."
    inputBinding:
      position: 10
      prefix: -assignment_radial_search
  - id: assignment_reverse_search
    type: ['null', float]
    doc: "traverse from each streamline endpoint inwards along the streamline, in search of the last node traversed by the streamline. Argument is the maximum traversal length in mm (set to 0 to allow search to continue to the streamline midpoint)."
    inputBinding:
      position: 10
      prefix: -assignment_reverse_search
  - id: assignment_forward_search
    type: ['null', float]
    doc: "project the streamline forwards from the endpoint in search of a parcellation node voxel. Argument is the maximum traversal length in mm."
    inputBinding:
      position: 10
      prefix: -assignment_forward_search
  - id: assignment_all_voxels
    type: ['null', boolean]
    doc: "assign the streamline to all nodes it intersects along its length (note that this means a streamline may be assigned to more than two nodes, or indeed none at all)"
    inputBinding:
      position: 10
      prefix: -assignment_all_voxels
  - id: scale_length
    type: ['null', boolean]
    doc: "scale each contribution to the connectome edge by the length of the streamline"
    inputBinding:
      position: 10
      prefix: -scale_length
  - id: scale_invlength
    type: ['null', boolean]
    doc: "scale each contribution to the connectome edge by the inverse of the streamline length"
    inputBinding:
      position: 10
      prefix: -scale_invlength
  - id: scale_invnodevol
    type: ['null', boolean]
    doc: "scale each contribution to the connectome edge by the inverse of the two node volumes"
    inputBinding:
      position: 10
      prefix: -scale_invnodevol
  - id: scale_file
    type: ['null', File]
    doc: "scale each contribution to the connectome edge according to the values in a vector file"
    inputBinding:
      position: 10
      prefix: -scale_file
  - id: symmetric
    type: ['null', boolean]
    doc: "Make matrices symmetric on output"
    inputBinding:
      position: 10
      prefix: -symmetric
  - id: zero_diagonal
    type: ['null', boolean]
    doc: "Set matrix diagonal to zero on output"
    inputBinding:
      position: 10
      prefix: -zero_diagonal
  - id: stat_edge
    type: ['null', string]
    doc: "statistic for combining the values from all streamlines in an edge into a single scale value for that edge (options are: sum,mean,min,max; default=sum)"
    inputBinding:
      position: 10
      prefix: -stat_edge
  - id: tck_weights_in
    type: ['null', File]
    doc: "specify a text scalar file containing the streamline weights"
    inputBinding:
      position: 10
      prefix: -tck_weights_in
  - id: keep_unassigned
    type: ['null', boolean]
    doc: "By default, the program discards the information regarding those streamlines that are not successfully assigned to a node pair. Set this option to keep these values (will be the first row/column in the output matrix)"
    inputBinding:
      position: 10
      prefix: -keep_unassigned
  - id: out_assignments
    type: ['null', string]
    doc: "output the node assignments of each streamline to a file; this can be used subsequently e.g. by the command connectome2tck"
    inputBinding:
      position: 10
      prefix: -out_assignments
  - id: vector
    type: ['null', boolean]
    doc: "output a vector representing connectivities from a given seed point to target nodes, rather than a matrix of node-node connectivities"
    inputBinding:
      position: 10
      prefix: -vector
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: connectome_out_file
    type: File
    doc: Output file given by connectome_out.
    outputBinding:
      glob: $(inputs.connectome_out)
  - id: out_assignments_file
    type: ['null', File]
    doc: Output file given by -out_assignments.
    outputBinding:
      glob: $(inputs.out_assignments)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
