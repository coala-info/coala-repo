cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckedit
label: mrtrix3_tckedit
doc: "Perform various editing operations on track files\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks_in
    type:
      type: array
      items: File
    doc: "the input track file(s)"
    inputBinding:
      position: 1
  - id: tracks_out
    type: string
    doc: "the output track file"
    inputBinding:
      position: 2
  - id: include
    type:
      - 'null'
      - type: array
        items: [File, string]
        inputBinding:
          prefix: -include
    doc: "specify an inclusion region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines must traverse ALL inclusion regions to be accepted."
    inputBinding:
      position: 10
  - id: include_ordered
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -include_ordered
    doc: "specify an inclusion region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines must traverse ALL inclusion_ordered regions in the order they are specified in order to be accepted."
    inputBinding:
      position: 10
  - id: exclude
    type:
      - 'null'
      - type: array
        items: [File, string]
        inputBinding:
          prefix: -exclude
    doc: "specify an exclusion region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines that enter ANY exclude region will be discarded."
    inputBinding:
      position: 10
  - id: mask
    type:
      - 'null'
      - type: array
        items: [File, string]
        inputBinding:
          prefix: -mask
    doc: "specify a masking region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). If defined, streamlines exiting the mask will be truncated."
    inputBinding:
      position: 10
  - id: maxlength
    type: ['null', float]
    doc: "set the maximum length of any streamline in mm"
    inputBinding:
      position: 10
      prefix: -maxlength
  - id: minlength
    type: ['null', float]
    doc: "set the minimum length of any streamline in mm"
    inputBinding:
      position: 10
      prefix: -minlength
  - id: number
    type: ['null', int]
    doc: "set the desired number of selected streamlines to be propagated to the output file"
    inputBinding:
      position: 10
      prefix: -number
  - id: skip
    type: ['null', int]
    doc: "omit this number of selected streamlines before commencing writing to the output file"
    inputBinding:
      position: 10
      prefix: -skip
  - id: maxweight
    type: ['null', float]
    doc: "set the maximum weight of any streamline"
    inputBinding:
      position: 10
      prefix: -maxweight
  - id: minweight
    type: ['null', float]
    doc: "set the minimum weight of any streamline"
    inputBinding:
      position: 10
      prefix: -minweight
  - id: inverse
    type: ['null', boolean]
    doc: "output the inverse selection of streamlines based on the criteria provided; i.e. only those streamlines that fail at least one selection criterion, and/or vertices that are outside masks if provided, will be written to file"
    inputBinding:
      position: 10
      prefix: -inverse
  - id: ends_only
    type: ['null', boolean]
    doc: "only test the ends of each streamline against the provided include/exclude ROIs"
    inputBinding:
      position: 10
      prefix: -ends_only
  - id: tck_weights_in
    type: ['null', File]
    doc: "specify a text scalar file containing the streamline weights"
    inputBinding:
      position: 10
      prefix: -tck_weights_in
  - id: tck_weights_out
    type: ['null', string]
    doc: "specify the path for an output text scalar file containing streamline weights"
    inputBinding:
      position: 10
      prefix: -tck_weights_out
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
  - id: tracks_out_file
    type: File
    doc: Output file given by tracks_out.
    outputBinding:
      glob: $(inputs.tracks_out)
  - id: tck_weights_out_file
    type: ['null', File]
    doc: Output file given by -tck_weights_out.
    outputBinding:
      glob: $(inputs.tck_weights_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
