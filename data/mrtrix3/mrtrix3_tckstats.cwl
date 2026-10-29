cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckstats
label: mrtrix3_tckstats
doc: "Calculate statistics on streamlines lengths\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks_in
    type: File
    doc: "the input track file"
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -output
    doc: "output only the field specified. Multiple such options can be supplied if required. Choices are: mean, median, std, min, max, count. Useful for use in scripts."
    inputBinding:
      position: 10
  - id: histogram
    type: ['null', string]
    doc: "output a histogram of streamline lengths"
    inputBinding:
      position: 10
      prefix: -histogram
  - id: dump
    type: ['null', string]
    doc: "dump the streamlines lengths to a text file"
    inputBinding:
      position: 10
      prefix: -dump
  - id: ignorezero
    type: ['null', boolean]
    doc: "do not generate a warning if the track file contains streamlines with zero length"
    inputBinding:
      position: 10
      prefix: -ignorezero
  - id: tck_weights_in
    type: ['null', File]
    doc: "specify a text scalar file containing the streamline weights"
    inputBinding:
      position: 10
      prefix: -tck_weights_in
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
  - id: histogram_file
    type: ['null', File]
    doc: Output file given by -histogram.
    outputBinding:
      glob: $(inputs.histogram)
  - id: dump_file
    type: ['null', File]
    doc: Output file given by -dump.
    outputBinding:
      glob: $(inputs.dump)
  - id: tracks_stats
    type: File
    doc: Text printed by the command.
    outputBinding:
      glob: tckstats.txt
stdout: tckstats.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
