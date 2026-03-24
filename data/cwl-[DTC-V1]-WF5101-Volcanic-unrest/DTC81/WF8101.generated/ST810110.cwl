cwlVersion: v1.2
class: Workflow
inputs:
    DT810109: Directory
    simulation_params: Directory
outputs:
    DT810110:
        type: Directory
        outputSource:
            - ST810110/DT810110
steps:
    ST810110:
        run:
            class: Operation
            inputs:
                DT810109: Directory
                simulation_params: Directory
            outputs:
                DT810110: Directory
        in:
            DT810109: DT810109
            simulation_params: simulation_params
        out:
            - DT810110
