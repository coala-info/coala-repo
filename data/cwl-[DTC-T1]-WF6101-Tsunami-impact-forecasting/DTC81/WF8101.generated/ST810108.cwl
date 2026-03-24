cwlVersion: v1.2
class: Workflow
inputs:
    DT810107: Directory
outputs:
    DT810108:
        type: Directory
        outputSource:
            - ST810108/DT810108
steps:
    ST810108:
        run:
            class: Operation
            inputs:
                DT810107: Directory
            outputs:
                DT810108: Directory
        in:
            DT810107: DT810107
        out:
            - DT810108
