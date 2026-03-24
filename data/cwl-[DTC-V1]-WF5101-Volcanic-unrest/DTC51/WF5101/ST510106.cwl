cwlVersion: v1.2
class: Workflow
inputs: {}
outputs:
    DT5101:
        type: Directory
        outputSource:
            - ST510106/DT5101
steps:
    SS5106:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    SS5109:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
