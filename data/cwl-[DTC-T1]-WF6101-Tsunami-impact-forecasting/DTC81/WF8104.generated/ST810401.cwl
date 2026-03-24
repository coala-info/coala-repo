cwlVersion: v1.2
class: Workflow
inputs:
    P_phase_threshold: Directory
    S_phase_threshold: Directory
    blinding: Directory
    model: Directory
    model_weights: Directory
    waveform_miniseed: Directory
outputs:
    DT810401:
        type: Directory
        outputSource:
            - ST810401/DT810401
steps:
    SS8102:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    SS8104:
        run:
            class: Operation
            inputs: {}
            outputs: {}
        in: {}
        out: []
    ST810401:
        run:
            class: Operation
            inputs:
                P_phase_threshold: Directory
                S_phase_threshold: Directory
                blinding: Directory
                model: Directory
                model_weights: Directory
                waveform_miniseed: Directory
            outputs:
                DT810401: Directory
        in:
            P_phase_threshold: P_phase_threshold
            S_phase_threshold: S_phase_threshold
            blinding: blinding
            model: model
            model_weights: model_weights
            waveform_miniseed: waveform_miniseed
        out:
            - DT810401
