cwlVersion: v1.2
class: Workflow
inputs:
    DT5306: Directory
    DT5308: Directory
    DT5309: Directory
outputs: {}
steps:
    SS5304:
        run:
            class: Operation
            inputs:
                DT5309: Directory
            outputs:
                DT5305: Directory
                DT5310: Directory
        in:
            DT5309: DT5309
        out:
            - DT5305
            - DT5310
    SS5305:
        run:
            class: Operation
            inputs:
                DT5306: Directory
                DT5308: Directory
            outputs:
                DT5310: Directory
        in:
            DT5306: DT5306
            DT5308: DT5308
        out:
            - DT5310
    SS5306:
        run:
            class: Operation
            inputs:
                DT5306: Directory
                DT5308: Directory
            outputs:
                DT5311: Directory
        in:
            DT5306: DT5306
            DT5308: DT5308
        out:
            - DT5311
