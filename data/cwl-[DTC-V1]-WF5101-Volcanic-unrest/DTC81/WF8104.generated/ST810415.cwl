cwlVersion: v1.2
class: Workflow
inputs:
    DT810413: Directory
    DT810414: Directory
outputs:
    DT810415:
        type: Directory
        outputSource:
            - ST810415/DT810415
steps:
    SS8107:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810415:
        run:
            class: Operation
            inputs:
                DT810413: Directory
                DT810414: Directory
            outputs:
                DT810415: Directory
        in:
            DT810413: DT810413
            DT810414: DT810414
        out:
            - DT810415
