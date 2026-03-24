cwlVersion: v1.2
class: Workflow
inputs:
    DT810405: Directory
    grid_cell_size: Directory
outputs:
    DT810406:
        type: Directory
        outputSource:
            - ST810406/DT810406
steps:
    SS8106:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810406:
        run:
            class: Operation
            inputs:
                DT810405: Directory
                grid_cell_size: Directory
            outputs:
                DT810406: Directory
        in:
            DT810405: DT810405
            grid_cell_size: grid_cell_size
        out:
            - DT810406
