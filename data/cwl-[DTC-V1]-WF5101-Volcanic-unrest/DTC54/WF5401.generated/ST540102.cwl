cwlVersion: v1.2
class: Workflow
inputs:
    DT5401: Directory
outputs:
    DT5402:
        type: Directory
        outputSource:
            - SS5401/DT5402
steps:
    SS5401:
        run:
            class: Operation
            inputs:
                DT5401: Directory
            outputs:
                DT5402: Directory
        in:
            DT5401: DT5401
        out:
            - DT5402
