cwlVersion: v1.2
class: Workflow
inputs:
    DT5402: Directory
    DT5404: Directory
outputs:
    DT5405:
        type: Directory
        outputSource:
            - SS5404/DT5405
steps:
    SS5404:
        run:
            class: Operation
            inputs:
                DT5402: Directory
                DT5404: Directory
            outputs:
                DT5405: Directory
        in:
            DT5402: DT5402
            DT5404: DT5404
        out:
            - DT5405
