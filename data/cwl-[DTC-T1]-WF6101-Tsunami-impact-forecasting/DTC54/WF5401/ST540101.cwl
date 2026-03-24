cwlVersion: v1.2
class: Workflow
inputs: {}
outputs:
    DT5401:
        type: Directory
        outputSource:
            - ST540101/DT5401
steps:
    ST540101:
        run:
            class: Operation
            inputs: {}
            outputs:
                DT5401: Directory
        in: {}
        out:
            - DT5401
