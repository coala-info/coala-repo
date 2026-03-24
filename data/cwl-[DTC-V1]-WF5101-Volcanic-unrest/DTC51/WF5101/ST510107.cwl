cwlVersion: v1.2
class: Workflow
inputs:
    DT5101: Directory
    DT5102: Directory
outputs:
    DT5103:
        type: Directory
        outputSource:
            - ST510107/DT5103
steps:
    ST510107:
        run:
            class: Operation
            inputs:
                DT5101: Directory
                DT5102: Directory
            outputs:
                DT5103: Directory
        in:
            DT5101: DT5101
            DT5102: DT5102
        out:
            - DT5103
