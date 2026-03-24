cwlVersion: v1.2
class: Workflow
inputs:
    DT810105: Directory
    DT810106: Directory
outputs:
    DT810107:
        type: Directory
        outputSource:
            - ST810107/DT810107
steps:
    ST810107:
        run:
            class: Operation
            inputs:
                DT810105: Directory
                DT810106: Directory
            outputs:
                DT810107: Directory
        in:
            DT810105: DT810105
            DT810106: DT810106
        out:
            - DT810107
