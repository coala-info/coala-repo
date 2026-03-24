#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

# Specify any requirements your workflow needs.
requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs.
inputs:
  INPUT_DIR: Directory  # Replace with your actual input identifier

# Define global outputs.
outputs:
  OUTPUT_DIR:
    type: Directory
    # Specify the step and output identifier that produces this output.
    outputSource:
      - STEP2/FINAL_OUTPUT

# Define the workflow steps.
steps:
  STEP1:
    doc: "Description of Step 1 – e.g., preprocessing the input data."
    in:
      # Map global input(s) or outputs from previous steps.
      INPUT_DIR: INPUT_DIR
    run:
      # Here we define an abstract Operation.
      class: Operation
      inputs:
        INPUT_DIR: Directory
      outputs:
        INTERMEDIATE_OUTPUT: Directory
    out:
      - INTERMEDIATE_OUTPUT

  STEP2:
    doc: "Description of Step 2 – e.g., processing the intermediate output."
    in:
      # Link to the output of STEP1.
      INTERMEDIATE_OUTPUT: STEP1/INTERMEDIATE_OUTPUT
    run:
      class: Operation
      inputs:
        INTERMEDIATE_OUTPUT: Directory
      outputs:
        FINAL_OUTPUT: Directory
    out:
      - FINAL_OUTPUT

# Add additional steps following the same pattern if needed.

