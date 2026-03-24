cwlVersion: v1.2
class: Workflow
inputs:
    DT810401: Directory
    DT810403: Directory
    frequency_range: Directory
    network_inventory: Directory
    source_rock_density: Directory
    source_wave_velocity: Directory
    time_window_length: Directory
    velocity_model: Directory
    waveform_miniseed: Directory
outputs:
    DT810404:
        type: Directory
        outputSource:
            - ST810404/DT810404
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
    ST810404:
        run:
            class: Operation
            inputs:
                DT810401: Directory
                DT810403: Directory
                frequency_range: Directory
                network_inventory: Directory
                source_rock_density: Directory
                source_wave_velocity: Directory
                time_window_length: Directory
                velocity_model: Directory
                waveform_miniseed: Directory
            outputs:
                DT810404: Directory
        in:
            DT810401: DT810401
            DT810403: DT810403
            frequency_range: frequency_range
            network_inventory: network_inventory
            source_rock_density: source_rock_density
            source_wave_velocity: source_wave_velocity
            time_window_length: time_window_length
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810404
