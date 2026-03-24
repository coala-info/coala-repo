class: Workflow
doc: Subset data on the Mediterreanean see and extract and visualise the Phosphate
  variable
label: Ocean's variables 2.0
cwlVersion: v1.2
inputs:
  Workflow fully interactive:
    doc: Choose whether you want to have only interactive tools (for more experimented
      user) or if you want a workflow hat combines interactive and non-interactive
      tools (easier)
    id: Workflow fully interactive
    type: boolean
  Eutrophication_Med_profiles_2022_unrestricted_SNAPSHOT_2023-10-24T16-39-44.zip:
    doc: The data here are Mediterranean Sea - Eutrophication and Acidity aggregated
      datasets EMODnet Chemistry.
    id: Eutrophication_Med_profiles_2022_unrestricted_SNAPSHOT_2023-10-24T16-39-44.zip
    type: File
  Workflow semi automatic:
    doc: Choose whether you want to have only interactive tools (for more experimented
      user) or if you want a workflow hat combines interactive and non-interactive
      tools (easier)
    id: Workflow semi automatic
    type: boolean
  gebco_30sec_8.nc:
    doc: A bathymetry file in netcdf.
    id: gebco_30sec_8.nc
    type: File
outputs:
  _anonymous_output_1:
    outputSource: Workflow fully interactive
    type: File
  _anonymous_output_2:
    outputSource: Workflow semi automatic
    type: File
  Water_body_Phosphate_Mediterranean.nc:
    outputSource: DIVAnd (create a climatology)/output_netcdf
    type: File
  Ocean variables visualisation interactive:
    outputSource: ODV (visualisation) interactive/outputs_all
    type: File
  Ocean variables visualisation:
    outputSource: ODV (visualisation)/outputs_all
    type: File
steps:
  Ocean Data View:
    doc: Interactively subset you data.
    run:
      class: Operation
      doc: Interactively subset you data.
      inputs: {}
      outputs: {}
    in:
      method|folder:
        source: Eutrophication_Med_profiles_2022_unrestricted_SNAPSHOT_2023-10-24T16-39-44.zip
    out: []
  Interactive DIVAnd jupyterlab:
    doc: Create a climatology interactively with notebooks
    run:
      class: Operation
      doc: Create a climatology interactively with notebooks
      inputs: {}
      outputs: {}
    in:
      input:
        source: Ocean Data View/outputs_netcdf
      when:
        source: Workflow fully interactive
    out: []
  DIVAnd (create a climatology):
    doc: Create a climatology (not interactively)
    run:
      class: Operation
      doc: Create a climatology (not interactively)
      inputs: {}
      outputs: {}
    in:
      input_netcdf_identifier:
        source: Ocean Data View/outputs_netcdf
      bathname:
        source: gebco_30sec_8.nc
      when:
        source: Workflow semi automatic
    out:
    - output_netcdf
  ODV (visualisation) interactive:
    doc: Final step to visualize in different way a ocean variable like the phosphate.
    run:
      class: Operation
      doc: Final step to visualize in different way a ocean variable like the phosphate.
      inputs: {}
      outputs: {}
    in:
      method|infiles:
        source: Interactive DIVAnd jupyterlab/output_netcdf
      when:
        source: Workflow fully interactive
    out:
    - outputs_all
  ODV (visualisation):
    doc: Final step to visualize in different way a ocean variable like the phosphate.
    run:
      class: Operation
      doc: Final step to visualize in different way a ocean variable like the phosphate.
      inputs: {}
      outputs: {}
    in:
      method|infiles:
        source: DIVAnd (create a climatology)/output_netcdf
      when:
        source: Workflow semi automatic
    out:
    - outputs_all
