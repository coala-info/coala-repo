cwlVersion: v1.2
class: Workflow
inputs:
    DT810201: Directory
    depth_max: Directory
    depth_min: Directory
    lat_max: Directory
    lat_min: Directory
    lon_max: Directory
    lon_min: Directory
    network_inventory: Directory
    velocity_model: Directory
outputs:
    DT810202:
        type: Directory
        outputSource:
            - ST810202/DT810202
steps:
    ST810202:
        run:
            class: Operation
            inputs:
                DT810201: Directory
                depth_max: Directory
                depth_min: Directory
                lat_max: Directory
                lat_min: Directory
                lon_max: Directory
                lon_min: Directory
                network_inventory: Directory
                velocity_model: Directory
            outputs:
                DT810202: Directory
        in:
            DT810201: DT810201
            depth_max: depth_max
            depth_min: depth_min
            lat_max: lat_max
            lat_min: lat_min
            lon_max: lon_max
            lon_min: lon_min
            network_inventory: network_inventory
            velocity_model: velocity_model
        out:
            - DT810202
