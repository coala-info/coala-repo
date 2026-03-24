cwlVersion: v1.2
class: Workflow
inputs:
    P_phase_threshold:
        type: Directory
    S_phase_threshold:
        type: Directory
    blinding:
        type: Directory
    depth_max:
        type: Directory
    depth_min:
        type: Directory
    frequency_range:
        type: Directory
    lat_max:
        type: Directory
    lat_min:
        type: Directory
    lon_max:
        type: Directory
    lon_min:
        type: Directory
    model:
        type: Directory
    model_weights:
        type: Directory
    network_inventory:
        type: Directory
    raw_catalog:
        type: Directory
    relevant_surfaces_points:
        type: Directory
    simulation_params:
        type: Directory
    source_rock_density:
        type: Directory
    source_wave_velocity:
        type: Directory
    time_window_length:
        type: Directory
    velocity_model:
        type: Directory
    waveform_miniseed:
        type: Directory
outputs:
    DT810101:
        type: Directory
        outputSource:
            - ST810101/DT810101
    DT810102:
        type: Directory
        outputSource:
            - ST810102/DT810102
    DT810103:
        type: Directory
        outputSource:
            - ST810103/DT810103
    DT810104:
        type: Directory
        outputSource:
            - ST810104/DT810104
    DT810105:
        type: Directory
        outputSource:
            - ST810105/DT810105
    DT810106:
        type: Directory
        outputSource:
            - ST810106/DT810106
    DT810107:
        type: Directory
        outputSource:
            - ST810107/DT810107
    DT810108:
        type: Directory
        outputSource:
            - ST810108/DT810108
    DT810109:
        type: Directory
        outputSource:
            - ST810109/DT810109
    DT810110:
        type: Directory
        outputSource:
            - ST810110/DT810110
    DT810111:
        type: Directory
        outputSource:
            - ST810111/DT810111
requirements:
    SubworkflowFeatureRequirement: {}
steps:
    ST810101:
        run: ST810101.cwl
        in:
            P_phase_threshold: P_phase_threshold
            S_phase_threshold: S_phase_threshold
            blinding: blinding
            model: model
            model_weights: model_weights
            waveform_miniseed: waveform_miniseed
        out:
            - DT810101
    ST810102:
        run: ST810102.cwl
        in:
            DT810101: ST810101/DT810101
            depth_max: depth_max
            depth_min: depth_min
            lat_max: lat_max
            lat_min: lat_min
            lon_max: lon_max
            lon_min: lon_min
            network_inventory: network_inventory
            velocity_model: velocity_model
        out:
            - DT810102
    ST810103:
        run: ST810103.cwl
        in:
            DT810101: ST810101/DT810101
            DT810102: ST810102/DT810102
            network_inventory: network_inventory
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810103
    ST810104:
        run: ST810104.cwl
        in:
            DT810101: ST810101/DT810101
            DT810103: ST810103/DT810103
            frequency_range: frequency_range
            network_inventory: network_inventory
            source_rock_density: source_rock_density
            source_wave_velocity: source_wave_velocity
            time_window_length: time_window_length
            velocity_model: velocity_model
            waveform_miniseed: waveform_miniseed
        out:
            - DT810104
    ST810105:
        run: ST810105.cwl
        in:
            raw_catalog: raw_catalog
        out:
            - DT810105
    ST810106:
        run: ST810106.cwl
        in:
            DT810105: ST810105/DT810105
        out:
            - DT810106
    ST810107:
        run: ST810107.cwl
        in:
            DT810105: ST810105/DT810105
            DT810106: ST810106/DT810106
        out:
            - DT810107
    ST810108:
        run: ST810108.cwl
        in:
            DT810107: ST810107/DT810107
        out:
            - DT810108
    ST810109:
        run: ST810109.cwl
        in:
            relevant_surfaces_points: relevant_surfaces_points
        out:
            - DT810109
    ST810110:
        run: ST810110.cwl
        in:
            DT810109: ST810109/DT810109
            simulation_params: simulation_params
        out:
            - DT810110
    ST810111:
        run: ST810111.cwl
        in:
            simulation_params: simulation_params
        out:
            - DT810111
