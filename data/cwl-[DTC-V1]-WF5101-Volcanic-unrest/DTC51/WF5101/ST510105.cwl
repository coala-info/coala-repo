cwlVersion: v1.2
class: Workflow
inputs: {}
outputs:
    DT5101:
        type: Directory
        outputSource:
            - ST510105/DT5101
steps:
    SS5105:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    SS5108:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    SS5113:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST510105:
        run:
            class: Operation
            inputs: {}
            outputs:
                DT5101: Directory
        in: {}
        out:
            - DT5101
