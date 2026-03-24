cwlVersion: v1.2
class: Workflow
inputs:
    DT5105: Directory
outputs:
    DT5111:
        type: Directory
        outputSource:
            - ST510109/DT5111
steps:
    SS5102:
        run:
            class: Operation
            inputs:
                DT5103: Directory
                DT5105: Directory
            outputs: {}
        in:
            DT5103: DT5103
            DT5105: DT5105
        out: []
