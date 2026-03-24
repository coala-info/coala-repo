cwlVersion: v1.2
class: Workflow
inputs:
    DT810401: Directory
    depth_max: Directory
    depth_min: Directory
    lat_max: Directory
    lat_min: Directory
    lon_max: Directory
    lon_min: Directory
    network_inventory: Directory
    velocity_model: Directory
outputs:
    DT810402:
        type: Directory
        outputSource:
            - ST810402/DT810402
steps:
    SS8101:
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
    ST810402:
        run:
            class: Operation
            inputs:
                DT810401: Directory
                depth_max: Directory
                depth_min: Directory
                lat_max: Directory
                lat_min: Directory
                lon_max: Directory
                lon_min: Directory
                network_inventory: Directory
                velocity_model: Directory
            outputs:
                DT810402: Directory
        in:
            DT810401: DT810401
            depth_max: depth_max
            depth_min: depth_min
            lat_max: lat_max
            lat_min: lat_min
            lon_max: lon_max
            lon_min: lon_min
            network_inventory: network_inventory
            velocity_model: velocity_model
        out:
            - DT810402
