cwlVersion: v1.2
class: Workflow
inputs:
    acceleration_miniseed: Directory
    damping_factor: Directory
outputs:
    DT810411:
        type: Directory
        outputSource:
            - ST810411/DT810411
steps:
    ST810411:
        run:
            class: Operation
            inputs:
                acceleration_miniseed: Directory
                damping_factor: Directory
            outputs:
                DT810411: Directory
        in:
            acceleration_miniseed: acceleration_miniseed
            damping_factor: damping_factor
        out:
            - DT810411
