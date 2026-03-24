cwlVersion: v1.2
class: Workflow
inputs: {}
outputs:
    DT5101:
        type: Directory
        outputSource:
            - SS5101/DT5101
steps:
    SS5101:
        run:
            class: Operation
            inputs: {}
            outputs:
                DT5101: Directory
        in: {}
        out:
            - DT5101
