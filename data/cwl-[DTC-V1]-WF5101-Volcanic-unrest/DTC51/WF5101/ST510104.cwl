cwlVersion: v1.2
class: Workflow
inputs: {}
outputs:
    DT5101:
        type: Directory
        outputSource:
            - DT5101
steps:
    SS5104:
        run:
            class: Operation
            inputs:
                DT5106: Directory
                DT5111: Directory
            outputs: {}
        in:
            DT5106: DT5106
            DT5111: DT5111
        out: []
    SS5107:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
