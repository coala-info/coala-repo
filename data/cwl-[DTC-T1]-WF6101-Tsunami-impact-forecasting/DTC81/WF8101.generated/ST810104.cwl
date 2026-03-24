cwlVersion: v1.2
class: Workflow
inputs:
    DT810101: Directory
    DT810103: Directory
    frequency_range: Directory
    network_inventory: Directory
    source_rock_density: Directory
    source_wave_velocity: Directory
    time_window_length: Directory
    velocity_model: Directory
    waveform_miniseed: Directory
outputs:
    DT810104:
        type: Directory
        outputSource:
            - ST810104/DT810104
steps:
    ST810104:
        run:
            class: Operation
            inputs:
                DT810101: Directory
                DT810103: Directory
                frequency_range: Directory
                network_inventory: Directory
                source_rock_density: Directory
                source_wave_velocity: Directory
                time_window_length: Directory
                velocity_model: Directory
                waveform_miniseed: Directory
            outputs:
                DT810104: Directory
        in:
            DT810101: DT810101
            DT810103: DT810103
            frequency_range: frequency_range
            network_inventory: network_inventory
            source_rock_density: source_rock_density
            source_wave_velocity: source_wave_velocity
            time_window_length: time_window_length
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810104
