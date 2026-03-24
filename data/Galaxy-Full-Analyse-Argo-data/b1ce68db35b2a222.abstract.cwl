class: Workflow
doc: Process argo data with the Pangeo Ecosystem and visualise them with Ocean Data
  View (ODV)
label: 'Full Analyse Argo data '
cwlVersion: v1.2
inputs:
  Physical variables:
    doc: If true you can study physical variables of the ocean.
    id: Physical variables
    type: boolean
  Bio-GeoChemical variables:
    doc: If true you can study BGC variables of the ocean
    id: Bio-GeoChemical variables
    type: boolean
outputs:
  _anonymous_output_1:
    outputSource: Physical variables
    type: File
  _anonymous_output_2:
    outputSource: Bio-GeoChemical variables
    type: File
  Argo phys data:
    outputSource: Argo physical data/output_argo
    type: File
  Ago BGC data:
    outputSource: Argo BGC data/output_argo
    type: File
  Coordinate info phys:
    outputSource: 4/output_dir
    type: File
  info phys:
    outputSource: 5/info
    type: File
  phys metadata tabular:
    outputSource: '5'
    type: File
  Coordinate info bgc:
    outputSource: 6/output_dir
    type: File
  bgc metadata tabular:
    outputSource: '7'
    type: File
  info bgc:
    outputSource: 7/info
    type: File
  Timeseries phys tabular:
    outputSource: 8/timeseries_tabular
    type: File
  Timeseries plot phys:
    outputSource: 8/timeseries_plot
    type: File
  Timeseries bgc tabular:
    outputSource: 9/timeseries_tabular
    type: File
  Timeseries plot bgc:
    outputSource: 9/timeseries_plot
    type: File
  Netcdf phys:
    outputSource: 10/outputs_netcdf
    type: File
  Resulting map phys:
    outputSource: 10/outputs_all
    type: File
  Netcdf bgc:
    outputSource: 11/outputs_netcdf
    type: File
  Resulting map bgc:
    outputSource: 11/outputs_all
    type: File
steps:
  Argo physical data:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      when:
        source: Physical variables
    out:
    - output_argo
  Argo BGC data:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      when:
        source: Bio-GeoChemical variables
    out:
    - output_argo
  '4':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      input:
        source: Argo physical data/output_argo
    out:
    - output_dir
  '5':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      input:
        source: Argo physical data/output_argo
    out:
    - info
    - output
  '6':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      input:
        source: Argo BGC data/output_argo
    out:
    - output_dir
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      input:
        source: Argo BGC data/output_argo
    out:
    - info
    - output
  '8':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      input:
        source: Argo physical data/output_argo
      var_tab:
        source: '5'
    out:
    - timeseries_plot
    - timeseries_tabular
  '9':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      input:
        source: Argo BGC data/output_argo
      var_tab:
        source: '7'
    out:
    - timeseries_plot
    - timeseries_tabular
  '10':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      method|infiles:
        source: 8/timeseries_tabular
    out:
    - outputs_netcdf
    - outputs_all
  '11':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      method|infiles:
        source: 9/timeseries_tabular
    out:
    - outputs_all
    - outputs_netcdf
