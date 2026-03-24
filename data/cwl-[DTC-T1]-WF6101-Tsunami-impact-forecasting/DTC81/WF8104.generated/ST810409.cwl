cwlVersion: v1.2
class: Workflow
inputs:
    DT810405: Directory
    injection_rate: Directory
outputs:
    DT810409:
        type: Directory
        outputSource:
            - ST810409/DT810409
steps:
    SS8105:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810409:
        run:
            class: Operation
            inputs:
                DT810405: Directory
                injection_rate: Directory
            outputs:
                DT810409: Directory
        in:
            DT810405: DT810405
            injection_rate: injection_rate
        out:
            - DT810409
