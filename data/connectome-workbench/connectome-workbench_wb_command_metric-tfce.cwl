cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-tfce
label: connectome-workbench_wb_command_metric-tfce
doc: 'Threshold-free cluster enhancement is a method to increase the relative value
  of regions that would form clusters in a standard thresholding test. This is accomplished
  by evaluating the integral of:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: parameters_rec
        type: record
        fields:
          - name: e
            type: float
            doc: exponent for cluster area (default 1.0)
            inputBinding:
              position: 1
          - name: h
            type: float
            doc: exponent for threshold value (default 2.0)
            inputBinding:
              position: 2
inputs:
  - id: surface
    type: File
    doc: the surface to compute on
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the metric to run TFCE on
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 3
  - id: presmooth
    type:
      - 'null'
      - float
    doc: smooth the metric before running TFCE
    inputBinding:
      position: 4
      prefix: -presmooth
  - id: roi
    type:
      - 'null'
      - File
    doc: select a region of interest to run TFCE on
    inputBinding:
      position: 4
      prefix: -roi
  - id: parameters
    type:
      - 'null'
      - parameters_rec
    doc: set parameters for TFCE integral
    inputBinding:
      position: 4
      prefix: -parameters
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column
    inputBinding:
      position: 4
      prefix: -column
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface
    inputBinding:
      position: 4
      prefix: -corrected-areas
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
