cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-label-to-surface-mapping
label: connectome-workbench_wb_command_volume-label-to-surface-mapping
doc: "Map label volume data to a surface. If -ribbon-constrained is not specified, uses the enclosing voxel method. The ribbon mapping method constructs a polyhedron from the vertex's neighbors on each surface, and estimates the amount of this polyhedron's volume that falls inside any nearby voxels, to use as the weights for a popularity comparison. If -thin-columns is specified, the polyhedron uses the edge midpoints and triangle centroids, so that neighboring vertices do not have overlapping polyhedra. This may require increasing -voxel-subdiv to get enough samples in each voxel to reliably land inside these smaller polyhedra. The volume ROI is useful to exclude partial volume effects of voxels the surfaces pass through, and will cause the mapping to ignore voxels that don't have a positive value in the mask. The subdivision number specifies how it approximates the amount of the volume the polyhedron intersects, by splitting each voxel into NxNxN pieces, and checking whether the center of each piece is inside the polyhedron. If you have very large voxels, consider increasing this if you get unexpected unlabeled vertices in your output.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume
    type: File
    doc: "the volume to map data from"
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: "the surface to map the data onto"
    inputBinding:
      position: 2
  - id: label_out
    type: string
    doc: "output - the output gifti label file"
    inputBinding:
      position: 3
  - id: ribbon_inner_surf
    type:
      - 'null'
      - File
    doc: "the inner surface of the ribbon (-ribbon-constrained argument 1 of 2)"
    inputBinding:
      position: 4
      prefix: -ribbon-constrained
  - id: ribbon_outer_surf
    type:
      - 'null'
      - File
    doc: "the outer surface of the ribbon (-ribbon-constrained argument 2 of 2)"
    inputBinding:
      position: 5
  - id: volume_roi
    type:
      - 'null'
      - File
    doc: "use a volume roi: the volume file (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 6
      prefix: -volume-roi
  - id: voxel_subdiv
    type:
      - 'null'
      - int
    doc: "voxel divisions while estimating voxel weights: number of subdivisions, default 3 (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 7
      prefix: -voxel-subdiv
  - id: thin_columns
    type:
      - 'null'
      - boolean
    doc: "use non-overlapping polyhedra (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 8
      prefix: -thin-columns
  - id: subvol_select
    type:
      - 'null'
      - string
    doc: "select a single subvolume to map: the subvolume number or name"
    inputBinding:
      position: 9
      prefix: -subvol-select
outputs:
  - id: label_gifti
    type: File
    doc: "the output gifti label file"
    outputBinding:
      glob: $(inputs.label_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
