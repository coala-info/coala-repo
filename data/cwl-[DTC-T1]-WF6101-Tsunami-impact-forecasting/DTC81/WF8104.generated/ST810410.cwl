cwlVersion: v1.2
class: Workflow
inputs:
    DT810409: Directory
    injection_model: Directory
    injection_rate_threshold: Directory
    inter_event_time_threshold: Directory
    output_uncertainty: Directory
outputs:
    DT810410:
        type: Directory
        outputSource:
            - ST810410/DT810410
steps:
    SS8106:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810410:
        run:
            class: Operation
            inputs:
                DT810409: Directory
                injection_model: Directory
                injection_rate_threshold: Directory
                inter_event_time_threshold: Directory
                output_uncertainty: Directory
            outputs:
                DT810410: Directory
        in:
            DT810409: DT810409
            injection_model: injection_model
            injection_rate_threshold: injection_rate_threshold
            inter_event_time_threshold: inter_event_time_threshold
            output_uncertainty: output_uncertainty
        out:
            - DT810410
