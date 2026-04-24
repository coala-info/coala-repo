#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

# enable subworkflow for ST750207
requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs.
inputs:
  DT7501:
    doc: "CSEMv3 model"
    type: File
  FDNS_STREAM:
    doc: "Stream from FDNS service."
    type: File
    streamable: true
  RUN_MLESMAP:
    doc: "Flag to run or skip MLESmap step."
    type: boolean

# Define global outputs.
outputs:
  DT7502:
    doc: "Shake Maps Library"
    type: Directory
    outputSource: ST750210/DT7502

# Define workflow steps.
steps:
  ST750201:
    doc: "Assimilate Data – Collect earthquake data from multiple sources."
    in:
      FDNS_STREAM: FDNS_STREAM
    run:
      class: Operation
      inputs:
        FDNS_STREAM: File
      outputs:
        ASSIMILATED_DATA: File
    out: 
      - ASSIMILATED_DATA

  ST750202:
    doc: "Acquire Source Parameters – Construct earthquake source parameters."
    in:
      ASSI_DATA: ST750201/ASSIMILATED_DATA
      URGENT_COMPUTING_RESULTS: ST750206/URGENT_COMPUTING_RESULTS
      DT7501: DT7501
    run:
      class: Workflow
      inputs:
        ASSI_DATA: File
        URGENT_COMPUTING_RESULTS: File
        DT7501: File
      outputs:
        SOURCE_PARAMETERS: Directory
      steps:
        SS7502:
          in:
            DT7501: DT7501
          run:
            class: Operation
            inputs:
              DT7501: File
            outputs:
              SOURCE_PARAMETERS: Directory
          out:
            - SOURCE_PARAMETERS
        SS7503:
          in:
            DT7501: DT7501
          run:
            class: Operation
            inputs:
              DT7501: File
            outputs:
              SOURCE_PARAMETERS: Directory
          out:
            - SOURCE_PARAMETERS
        SS7504:
          in:
            DT7501: DT7501
          run:
            class: Operation
            inputs:
              DT7501: File
            outputs:
              SOURCE_PARAMETERS: Directory
          out:
            - SOURCE_PARAMETERS
    out:
      - SOURCE_PARAMETERS

  ST750203:
    doc: "Build Input Parameters – Prepare parameters for simulations."
    in:
      SOURCE_PARAMETERS: ST750202/SOURCE_PARAMETERS
      DT7501: DT7501
    run:
      class: Operation
      inputs:
        SOURCE_PARAMETERS: Directory
        DT7501: File
      outputs:
        INPUT_PARAMETERS: Directory
    out:
      - INPUT_PARAMETERS

  ST750204:
    doc: "EQ. HPC Simulations – Run high-performance earthquake simulations."
    in:
      INPUT_PARAMETERS: ST750203/INPUT_PARAMETERS
    run:
      class: Workflow
      inputs:
        INPUT_PARAMETERS: Directory
      outputs:
        SIMULATION_RESULTS: Directory
      steps:
        SS7501:
          doc: "Salvus."
          in:
            INPUT_PARAMETERS: INPUT_PARAMETERS
          run:
            class: Operation
            inputs:
              INPUT_PARAMETERS: Directory
            outputs:
              SIMULATION_RESULTS: Directory
          out:
            - SIMULATION_RESULTS
    out:
      - SIMULATION_RESULTS

  ST750205:
    doc: "Evaluate Event Updates – Dynamically update events based on new data."
    in:
      FDNS_STREAM: FDNS_STREAM
    run:
      class: Operation
      inputs:
        FDNS_STREAM: File
      outputs:
        UPDATED_EVENTS: File
    out:
      - UPDATED_EVENTS

  ST750206:
    doc: "Enable Urgent Computing – Prioritize urgent simulations."
    in:
      UPDATED_EVENTS: ST750205/UPDATED_EVENTS
      FDNS_STREAM: FDNS_STREAM
    run:
      class: Operation
      inputs:
        UPDATED_EVENTS: File
        FDNS_STREAM: File
      outputs:
        URGENT_COMPUTING_RESULTS: File
    out:
      - URGENT_COMPUTING_RESULTS

  ST750207:
    doc: "MLESmap – Generate statistical earthquake hazard maps."
    in:
      SOURCE_PARAMETERS: ST750202/SOURCE_PARAMETERS
      DAL:
        source: ST750202/SOURCE_PARAMETERS
        valueFrom: $(self.listing.find(f => f.basename === "DAL_template.json"))
      INFERENCE_PARAMETERS:
        source: ST750202/SOURCE_PARAMETERS
        valueFrom: $(self.listing.find(f => f.basename === "mlesmap_inference.json"))
      SETUP_PARAMETERS:
        source: ST750202/SOURCE_PARAMETERS
        valueFrom: $(self.listing.find(f => f.basename === "mlesmap_setup.json"))
      PLOTS_PARAMETERS:
        source: ST750202/SOURCE_PARAMETERS
        valueFrom: $(self.listing.find(f => f.basename === "mlesmap_plots.json"))
      SSH_KNOWN_HOSTS:
        source: ST750202/SOURCE_PARAMETERS
        valueFrom: $(self.listing.find(f => f.basename === "known_hosts"))
      SSH_AUTH_SOCK:
        source: ST750202/SOURCE_PARAMETERS
        valueFrom: $(self.listing.find(f => f.basename === "ssh_auth_sock"))
    when: $(inputs.RUN_MLESMAP)
    run: ST750207.cwl
    out:
      - MLESMAP_RESULTS

  ST750208:
    doc: "Post-process Results – Analyze and compare results."
    in:
      SIMULATION_RESULTS: ST750204/SIMULATION_RESULTS
      MLESMAP_RESULTS: 
        source: ST750207/MLESMAP_RESULTS
        pickValue: first_non_null
    run:
      class: Operation
      inputs:
        SIMULATION_RESULTS: Directory
        MLESMAP_RESULTS: ["null", Directory]
      outputs:
        PROCESSED_RESULTS: File
    out:
      - PROCESSED_RESULTS

  ST750209:
    doc: "Gather Outputs – Collect final results for visualization."
    in:
      PROCESSED_RESULTS: ST750208/PROCESSED_RESULTS
    run:
      class: Operation
      inputs:
        PROCESSED_RESULTS: File
      outputs:
        POSTPROCESSED_RESULTS: File
    out:
      - POSTPROCESSED_RESULTS

  ST750210:
    doc: "Shake Maps Library – Store results in the Synthetic Shake Maps Library (DT7502)."
    in:
      POSTPROCESSED_RESULTS: ST750209/POSTPROCESSED_RESULTS
    run:
      class: Operation
      inputs:
        POSTPROCESSED_RESULTS: File
      outputs:
        DT7502: Directory
    out:
      - DT7502
