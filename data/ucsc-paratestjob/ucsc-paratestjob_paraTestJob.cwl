cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraTestJob
label: ucsc-paratestjob_paraTestJob
doc: "A good test job to run on Parasol. Can be configured to take a long time or
  crash.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: count
    type: int
    doc: Run a relatively time consuming algorithm count times.
    inputBinding:
      position: 1
  - id: crash
    type:
      - 'null'
      - boolean
    doc: Try to write to NULL when done.
    inputBinding:
      position: 102
      prefix: -crash
  - id: err
    type:
      - 'null'
      - boolean
    doc: Return -1 error code when done.
    inputBinding:
      position: 102
      prefix: -err
  - id: heavy
    type:
      - 'null'
      - int
    doc: 'Make output heavy: n extra lumberjack lines.'
    inputBinding:
      position: 102
      prefix: -heavy=
  - id: input_file
    type:
      - 'null'
      - File
    doc: Make it read in a file too.
    inputBinding:
      position: 102
      prefix: -input=
  - id: sleep
    type:
      - 'null'
      - int
    doc: Sleep for N seconds.
    inputBinding:
      position: 102
      prefix: -sleep=
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Make some output in file as well.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paratestjob:482--h0b57e2e_2
