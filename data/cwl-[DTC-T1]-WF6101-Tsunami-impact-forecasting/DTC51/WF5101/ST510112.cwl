cwlVersion: v1.2
class: Workflow
inputs:
    DT5111: Directory
outputs: {}
steps:
    ST510112:
        run:
            class: Operation
            inputs:
                DT5111: Directory
            outputs: {}
        in:
            DT5111: DT5111
        out: []
