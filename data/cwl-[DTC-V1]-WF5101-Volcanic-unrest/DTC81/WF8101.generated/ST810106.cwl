cwlVersion: v1.2
class: Workflow
inputs:
    DT810105: Directory
outputs:
    DT810106:
        type: Directory
        outputSource:
            - ST810106/DT810106
steps:
    ST810106:
        run:
            class: Operation
            inputs:
                DT810105: Directory
            outputs:
                DT810106: Directory
        in:
            DT810105: DT810105
        out:
            - DT810106
