cwlVersion: v1.2
class: Workflow
inputs:
    simulation_params: Directory
outputs:
    DT810111:
        type: Directory
        outputSource:
            - ST810111/DT810111
steps:
    ST810111:
        run:
            class: Operation
            inputs:
                simulation_params: Directory
            outputs:
                DT810111: Directory
        in:
            simulation_params: simulation_params
        out:
            - DT810111
