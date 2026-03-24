cwlVersion: v1.2
class: Workflow
inputs:
    DT810405: Directory
    time_window_duration: Directory
outputs:
    DT810407:
        type: Directory
        outputSource:
            - ST810407/DT810407
steps:
    SS8105:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    SS8106:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810407:
        run:
            class: Operation
            inputs:
                DT810405: Directory
                time_window_duration: Directory
            outputs:
                DT810407: Directory
        in:
            DT810405: DT810405
            time_window_duration: time_window_duration
        out:
            - DT810407
