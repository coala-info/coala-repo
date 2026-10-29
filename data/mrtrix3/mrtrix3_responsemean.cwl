cwlVersion: v1.2
class: CommandLineTool
baseCommand: responsemean
label: mrtrix3_responsemean
doc: "Calculate the mean response function from a set of text files\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: "The input response functions"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "The output mean response function"
    inputBinding:
      position: 2
  - id: legacy
    type: ['null', boolean]
    doc: "Use the legacy behaviour of former command 'average_response': average response function coefficients directly, without compensating for global magnitude differences between input files"
    inputBinding:
      position: 10
      prefix: -legacy
  - id: nocleanup
    type: ['null', boolean]
    doc: "do not delete intermediate files during script execution, and do not delete scratch directory at script completion."
    inputBinding:
      position: 10
      prefix: -nocleanup
  - id: scratch
    type: ['null', string]
    doc: "manually specify the path in which to generate the scratch directory."
    inputBinding:
      position: 10
      prefix: -scratch
  - id: continue
    type: ['null', continue_record]
    doc: "continue the script from a previous execution; must provide the scratch directory path, and the name of the last successfully-generated file."
    inputBinding:
      position: 10
      prefix: -continue
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status. Alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non- empty string."
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
    doc: "force overwrite of output files."
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
  - id: output_file
    type: File
    doc: Output file given by output.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: continue_record
        type: record
        fields:
          - name: scratch_dir
            type: string
            inputBinding:
              position: 1
          - name: last_file
            type: string
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
