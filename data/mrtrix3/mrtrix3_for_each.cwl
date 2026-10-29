cwlVersion: v1.2
class: CommandLineTool
baseCommand: [for_each]
label: mrtrix3_for_each
doc: |-
  Perform some arbitrary processing step for each of a set of inputs

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: SchemaDefRequirement
    types:
      - name: for_each_continue_rec
        type: record
        fields:
          - name: ScratchDir
            type: string
            doc: <ScratchDir>
            inputBinding:
              position: 1
          - name: LastFile
            type: string
            doc: <LastFile>
            inputBinding:
              position: 2
inputs:
  - id: targets
    type:
      type: array
      items: [File, Directory]
    doc: Each of the inputs for which processing should be run
    inputBinding:
      position: 1
  - id: command
    type:
      type: array
      items: string
    doc: The command string to run for each input, as separate words, containing any of the substitutions
      IN, NAME, PRE, UNI.
    inputBinding:
      position: 3
  - id: result_patterns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Wrapper option: names or glob patterns of files the command writes in the working directory;
      they are returned in ''results''.'
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -exclude
    doc: Exclude one specific input string / all strings matching a regular expression from being processed
      (see Example Usage)
  - id: test
    type: ['null', boolean]
    doc: Test the operation of the for_each script, by printing the command strings following string substitution
      but not actually executing them
    inputBinding:
      prefix: -test
  - id: nocleanup
    type: ['null', boolean]
    doc: do not delete intermediate files during script execution, and do not delete scratch directory
      at script completion.
    inputBinding:
      prefix: -nocleanup
  - id: scratch
    type: ['null', string]
    doc: manually specify the path in which to generate the scratch directory.
    inputBinding:
      prefix: -scratch
  - id: continue
    type: ['null', for_each_continue_rec]
    doc: continue the script from a previous execution; must provide the scratch directory path, and the
      name of the last successfully-generated file.
    inputBinding:
      prefix: -continue
  - id: info
    type: ['null', boolean]
    doc: display information messages.
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: do not display information messages or progress status. Alternatively, this can be achieved by
      setting the MRTRIX_QUIET environment variable to a non-empty string.
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: display debugging messages.
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: force overwrite of output files.
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).
    inputBinding:
      prefix: -nthreads
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: Files written by the command (matching result_patterns).
    outputBinding:
      glob: $(inputs.result_patterns)
arguments:
  - position: 2
    valueFrom: ':'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
