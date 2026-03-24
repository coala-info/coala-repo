cwlVersion: v1.2
class: Workflow
inputs:
    DT5303: Directory
    DT5305: Directory
outputs:
    DT5306:
        type: Directory
        outputSource:
            - SS5303/DT5306
steps:
    SS5303:
        run:
            class: Operation
            inputs:
                DT5303: Directory
                DT5305: Directory
            outputs:
                DT5306: Directory
        in:
            DT5303: DT5303
            DT5305: DT5305
        out:
            - DT5306
