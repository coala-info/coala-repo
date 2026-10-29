cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_fixel2voxel
doc: "Convert a fixel-based sparse-data image into some form of scalar image\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [fixel2voxel]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: fixel_in_directory
    type: Directory
    doc: "Fixel directory containing the file named in fixel_in."
  - id: fixel_in
    type: string
    doc: "the input fixel data file Give the file name inside the fixel directory."
    inputBinding:
      position: 10
      valueFrom: $(inputs.fixel_in_directory.path)/$(self)
  - id: operation
    type: string
    doc: "the operation to apply, one of: mean, sum, product, min, max, absmax, magmax, count, complexity, sf, dec_unit, dec_scaled, none."
    inputBinding:
      position: 11
  - id: image_out
    type: string
    doc: "the output scalar image."
    inputBinding:
      position: 12
  - id: number
    type: ['null', int]
    doc: "use only the largest N fixels in calculation of the voxel-wise statistic; in the case of operation \"none\", output only the largest N fixels in each voxel."
    inputBinding:
      prefix: -number
  - id: fill
    type: ['null', float]
    doc: "for \"none\" operation, specify the value to fill when number of fixels is fewer than the maximum (default: 0.0)"
    inputBinding:
      prefix: -fill
  - id: weighted
    type: ['null', string]
    doc: "weight the contribution of each fixel to the per-voxel result according to its volume. Give the file name inside the fixel directory."
    inputBinding:
      prefix: -weighted
      valueFrom: $(inputs.fixel_in_directory.path)/$(self)
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
  - id: image_out_file
    type: File
    doc: "the output scalar image."
    outputBinding:
      glob: $(inputs.image_out)
