cwlVersion: v1.2
class: CommandLineTool
baseCommand: msms
label: scripps-msms_msms
doc: "MSMS (Molecular Surface Masking System) computes the Solvent Excluded Surface
  (SES) of a set of spheres representing a molecule.\n\nTool homepage: https://ccsb.scripps.edu/msms/"
inputs:
  - id: all_components
    type:
      - 'null'
      - boolean
    doc: compute all the surfaces components
    inputBinding:
      position: 101
      prefix: -all_components
  - id: density
    type:
      - 'null'
      - float
    doc: surface points density
    default: 1.0
    inputBinding:
      position: 101
      prefix: -density
  - id: free_vertices
    type:
      - 'null'
      - boolean
    doc: turns on computation for isolated RS vertices
    inputBinding:
      position: 101
      prefix: -free_vertices
  - id: hdensity
    type:
      - 'null'
      - float
    doc: surface points high density
    default: 3.0
    inputBinding:
      position: 101
      prefix: -hdensity
  - id: input_file
    type:
      - 'null'
      - File
    doc: sphere input file
    inputBinding:
      position: 101
      prefix: -if
  - id: no_area
    type:
      - 'null'
      - boolean
    doc: turns off the analytical surface area computation
    inputBinding:
      position: 101
      prefix: -no_area
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: do not add comment line to the output
    inputBinding:
      position: 101
      prefix: -no_header
  - id: no_rest
    type:
      - 'null'
      - boolean
    doc: no restart if pb. are encountered
    inputBinding:
      position: 101
      prefix: -no_rest
  - id: no_rest_on_pbr
    type:
      - 'null'
      - boolean
    doc: no restart if pb. during triangulation
    inputBinding:
      position: 101
      prefix: -no_rest_on_pbr
  - id: noh
    type:
      - 'null'
      - boolean
    doc: ignore atoms with radius 1.2
    inputBinding:
      position: 101
      prefix: -noh
  - id: one_cavity
    type:
      - 'null'
      - type: array
        items: string
    doc: Compute the surface for an internal cavity for which at least one atom is
      specified
    inputBinding:
      position: 101
      prefix: -one_cavity
  - id: probe_radius
    type:
      - 'null'
      - float
    doc: probe sphere radius
    default: 1.5
    inputBinding:
      position: 101
      prefix: -probe_radius
  - id: sinetd
    type:
      - 'null'
      - boolean
    doc: inetd server connection
    inputBinding:
      position: 101
      prefix: -sinetd
  - id: socket_name
    type:
      - 'null'
      - string
    doc: socket connection from a client
    inputBinding:
      position: 101
      prefix: -socketName
  - id: socket_port
    type:
      - 'null'
      - int
    doc: socket connection from a client
    inputBinding:
      position: 101
      prefix: -socketPort
  - id: surface_type
    type:
      - 'null'
      - string
    doc: triangulated or Analytical SES (tses, ases)
    default: tses
    inputBinding:
      position: 101
      prefix: -surface
  - id: xdr
    type:
      - 'null'
      - boolean
    doc: use xdr encoding over socket
    inputBinding:
      position: 101
      prefix: -xdr
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output for triangulated surface
    outputBinding:
      glob: $(inputs.output_file)
  - id: area_file
    type:
      - 'null'
      - File
    doc: area file
    outputBinding:
      glob: $(inputs.area_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scripps-msms:2.6.1--h9ee0642_0
