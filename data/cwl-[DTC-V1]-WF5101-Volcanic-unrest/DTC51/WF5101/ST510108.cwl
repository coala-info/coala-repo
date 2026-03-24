cwlVersion: v1.2
class: Workflow
inputs:
    DT5101: Directory
    DT5106: Directory
outputs:
    DT5107:
        type: Directory
        outputSource:
            - ST510108/DT5107
steps:
    SS5111:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
