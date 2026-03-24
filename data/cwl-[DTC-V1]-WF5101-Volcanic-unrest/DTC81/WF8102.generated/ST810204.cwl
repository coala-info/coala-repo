cwlVersion: v1.2
class: Workflow
inputs:
    DT810201: Directory
    DT810203: Directory
    frequency_range: Directory
    network_inventory: Directory
    source_rock_density: Directory
    source_wave_velocity: Directory
    time_window_length: Directory
    velocity_model: Directory
    waveform_miniseed: Directory
outputs:
    DT810204:
        type: Directory
        outputSource:
            - ST810204/DT810204
steps:
    ST810204:
        run:
            class: Operation
            inputs:
                DT810201: Directory
                DT810203: Directory
                frequency_range: Directory
                network_inventory: Directory
                source_rock_density: Directory
                source_wave_velocity: Directory
                time_window_length: Directory
                velocity_model: Directory
                waveform_miniseed: Directory
            outputs:
                DT810204: Directory
        in:
            DT810201: DT810201
            DT810203: DT810203
            frequency_range: frequency_range
            network_inventory: network_inventory
            source_rock_density: source_rock_density
            source_wave_velocity: source_wave_velocity
            time_window_length: time_window_length
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810204
