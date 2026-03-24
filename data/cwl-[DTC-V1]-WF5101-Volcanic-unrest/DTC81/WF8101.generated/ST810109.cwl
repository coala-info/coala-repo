cwlVersion: v1.2
class: Workflow
inputs:
    relevant_surfaces_points: Directory
outputs:
    DT810109:
        type: Directory
        outputSource:
            - ST810109/DT810109
steps:
    ST810109:
        run:
            class: Operation
            inputs:
                relevant_surfaces_points: Directory
            outputs:
                DT810109: Directory
        in:
            relevant_surfaces_points: relevant_surfaces_points
        out:
            - DT810109
