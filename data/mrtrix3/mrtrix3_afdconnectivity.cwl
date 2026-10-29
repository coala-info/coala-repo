cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_afdconnectivity
doc: "Obtain an estimate of fibre connectivity between two regions using AFD and streamlines tractography\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [afdconnectivity]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: afdconnectivity.txt
inputs:
  - id: image
    type: File
    doc: "the input FOD image."
    inputBinding:
      position: 10
  - id: tracks
    type: File
    doc: "the input track file defining the bundle of interest."
    inputBinding:
      position: 11
  - id: wbft
    type: ['null', File]
    doc: "provide a whole-brain fibre-tracking data set (of which the input track file should be a subset), to improve the estimate of fibre bundle volume in the presence of partial volume"
    inputBinding:
      prefix: -wbft
  - id: afd_map
    type: ['null', string]
    doc: "output a 3D image containing the AFD estimated for each voxel."
    inputBinding:
      prefix: -afd_map
  - id: all_fixels
    type: ['null', boolean]
    doc: "if whole-brain fibre-tracking is NOT provided, then if multiple fixels within a voxel are traversed by the pathway of interest, by default the fixel with the greatest streamlines density is selected to contribute to the AFD in that voxel. If this option is provided, then ALL fixels with non-zero streamlines density will contribute to the result, even if multiple fixels per voxel are selected."
    inputBinding:
      prefix: -all_fixels
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
  - id: afd_map_file
    type: ['null', File]
    doc: "output a 3D image containing the AFD estimated for each voxel."
    outputBinding:
      glob: $(inputs.afd_map)
  - id: stdout_text
    type: stdout
    doc: Text printed by the command.
