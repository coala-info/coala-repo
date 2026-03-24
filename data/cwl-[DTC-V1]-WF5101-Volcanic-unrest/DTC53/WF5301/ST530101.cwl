cwlVersion: v1.2
class: Workflow
inputs:
    DT5301: Directory
    DT5302: Directory
    DT5303: Directory
    DT5304: Directory
    DT5308: Directory
    DT5309: Directory
outputs:
    DT5310:
        type: Directory
        outputSource:
            - SS5301/DT5310
steps:
    SS5301:
        run:
            class: Operation
            inputs:
                DT5301: Directory
                DT5302: Directory
                DT5303: Directory
                DT5304: Directory
                DT5308: Directory
                DT5309: Directory
            outputs:
                DT5310: Directory
        in:
            DT5301: DT5301
            DT5302: DT5302
            DT5303: DT5303
            DT5304: DT5304
            DT5308: DT5308
            DT5309: DT5309
        out:
            - DT5310
