cwlVersion: v1.2
class: Workflow
inputs:
    DT5109: Directory
outputs:
    DT5110:
        type: Directory
        outputSource:
            - ST510110/DT5110
steps:
    ST510110:
        run:
            class: Operation
            inputs:
                DT5109: Directory
            outputs:
                DT5110: Directory
        in:
            DT5109: DT5109
        out:
            - DT5110
