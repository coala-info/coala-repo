cwlVersion: v1.2
class: Workflow
inputs: {}
outputs:
    DT5105:
        type: Directory
        outputSource:
            - ST510102/DT5105
steps:
    ST510102:
        run:
            class: Operation
            inputs: {}
            outputs:
                DT5105: Directory
        in: {}
        out:
            - DT5105
