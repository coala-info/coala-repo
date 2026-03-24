cwlVersion: v1.2
class: Workflow
inputs:
    DT5306: Directory
    DT5308: Directory
    DT5309: Directory
    DT5311: Directory
outputs:
    DT5307:
        type: Directory
        outputSource:
            - SS5307/DT5307
steps:
    SS5307:
        run:
            class: Operation
            inputs:
                DT5306: Directory
                DT5311: Directory
            outputs:
                DT5307: Directory
        in:
            DT5306: DT5306
            DT5311: DT5311
        out:
            - DT5307
