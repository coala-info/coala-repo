cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckresample
label: mrtrix3_tckresample
doc: "Resample each streamline in a track file to a new set of vertices\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: in_tracks
    type: File
    doc: "the input track file"
    inputBinding:
      position: 1
  - id: out_tracks
    type: string
    doc: "the output resampled tracks"
    inputBinding:
      position: 2
  - id: upsample
    type: ['null', int]
    doc: "increase the density of points along the length of each streamline by some factor (may improve mapping streamlines to ROIs, and/or visualisation)"
    inputBinding:
      position: 10
      prefix: -upsample
  - id: downsample
    type: ['null', int]
    doc: "increase the density of points along the length of each streamline by some factor (decreases required storage space)"
    inputBinding:
      position: 10
      prefix: -downsample
  - id: step_size
    type: ['null', float]
    doc: "re-sample the streamlines to a desired step size (in mm)"
    inputBinding:
      position: 10
      prefix: -step_size
  - id: num_points
    type: ['null', int]
    doc: "re-sample each streamline to a fixed number of points"
    inputBinding:
      position: 10
      prefix: -num_points
  - id: endpoints
    type: ['null', boolean]
    doc: "only output the two endpoints of each streamline"
    inputBinding:
      position: 10
      prefix: -endpoints
  - id: line
    type: ['null', line_record]
    doc: "resample tracks at 'num' equidistant locations along a line between 'start' and 'end' (specified as comma-separated 3-vectors in scanner coordinates)"
    inputBinding:
      position: 10
      prefix: -line
  - id: arc
    type: ['null', arc_record]
    doc: "resample tracks at 'num' equidistant locations along a circular arc specified by points 'start', 'mid' and 'end' (specified as comma-separated 3-vectors in scanner coordinates)"
    inputBinding:
      position: 10
      prefix: -arc
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
  - id: out_tracks_file
    type: File
    doc: Output file given by out_tracks.
    outputBinding:
      glob: $(inputs.out_tracks)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: line_record
        type: record
        fields:
          - name: num
            type: int
            inputBinding:
              position: 1
          - name: start
            type: string
            inputBinding:
              position: 2
          - name: end
            type: string
            inputBinding:
              position: 3
      - name: arc_record
        type: record
        fields:
          - name: num
            type: int
            inputBinding:
              position: 1
          - name: start
            type: string
            inputBinding:
              position: 2
          - name: mid
            type: string
            inputBinding:
              position: 3
          - name: end
            type: string
            inputBinding:
              position: 4
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
