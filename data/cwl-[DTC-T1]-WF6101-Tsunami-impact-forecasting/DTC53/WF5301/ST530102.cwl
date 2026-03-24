cwlVersion: v1.2
class: Workflow
inputs:
    DT5302: Directory
    DT5304: Directory
    DT5308: Directory
    DT5309: Directory
outputs:
    DT5305:
        type: Directory
        outputSource:
            - ST530102/DT5305
steps:
    SS5302:
        run:
            class: Operation
            inputs:
                DT5302: Directory
                DT5304: Directory
            outputs: {}
        in:
            DT5302: DT5302
            DT5304: DT5304
        out: []
