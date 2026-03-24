cwlVersion: v1.2
class: Workflow
inputs:
    DT5104: Directory
outputs: {}
steps:
    ST510101:
        run:
            class: Operation
            inputs:
                DT5104: Directory
            outputs: {}
        in:
            DT5104: DT5104
        out: []
