cwlVersion: v1.2
class: Workflow
inputs:
    DT5403: Directory
outputs:
    DT5403:
        type: Directory
        outputSource:
            - DT5403
    DT5404:
        type: Directory
        outputSource:
            - SS5402/DT5404
steps:
    SS5402:
        run:
            class: Operation
            inputs:
                DT5403: Directory
            outputs:
                DT5403: Directory
                DT5404: Directory
        in:
            DT5403: DT5403
        out:
            - DT5403
            - DT5404
    SS5403:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
