cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dirmerge
doc: "Splice / merge multiple sets of directions in such a way as to maintain near-optimality upon truncation\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dirmerge]
requirements:
  - class: SchemaDefRequirement
    types:
      - name: BvalueFiles
        type: record
        fields:
          - name: bvalue
            type: int
            inputBinding:
              position: 1
          - name: files
            type: File[]
            inputBinding:
              position: 2
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: subsets
    type: int
    doc: "The number of subsets (e.g. phase encoding directions) per b-value."
    inputBinding:
      position: 10
  - id: out
    type: string
    doc: "the output directions file, with each row listing the X Y Z gradient directions, the b-value, and an index representing the phase encode direction"
    inputBinding:
      position: 12
  - id: unipolar_weight
    type: ['null', float]
    doc: "set the weight given to the unipolar electrostatic repulsion model compared to the bipolar model (default: 0.2)."
    inputBinding:
      prefix: -unipolar_weight
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
  - id: bvalue_files
    type:
      type: array
      items: BvalueFiles
    doc: One entry per b-value, holding the b-value and the files with the corresponding direction subsets, in order. Each file holds a set of directions.
    inputBinding:
      position: 11
outputs:
  - id: out_file
    type: File
    doc: "the output directions file, with each row listing the X Y Z gradient directions, the b-value, and an index representing the phase encode direction"
    outputBinding:
      glob: $(inputs.out)
