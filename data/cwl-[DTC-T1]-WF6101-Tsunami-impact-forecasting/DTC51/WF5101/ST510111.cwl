cwlVersion: v1.2
class: Workflow
inputs:
    DT5111: Directory
outputs: {}
steps:
    SS5103:
        run:
            class: Operation
            inputs:
                DT5104: Directory
                DT5110: Directory
            outputs: {}
        in:
            DT5104: DT5104
            DT5110: DT5110
        out: []
