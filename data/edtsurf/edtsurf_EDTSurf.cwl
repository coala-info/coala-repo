cwlVersion: v1.2
class: CommandLineTool
baseCommand: EDTSurf
label: edtsurf_EDTSurf
doc: "EDTSurf calculates the solvent accessible surface area (SASA) and the volume
  of the cavities of a protein.\n\nTool homepage: https://github.com/UnixJunkie/EDTSurf"
inputs:
  - id: pdbname
    type:
      type: array
      items: File
    doc: Input PDB file(s)
    inputBinding:
      position: 1
  - id: cavity_type
    type:
      - 'null'
      - string
    doc: 'Type of cavity definition: 1-pure (pure cavities), 2-atom (atom-based cavities),
      3-chain (chain-based cavities)'
    inputBinding:
      position: 102
      prefix: -c
  - id: outname
    type: string
    doc: Output file name prefix
    inputBinding:
      position: 102
      prefix: -o
  - id: output_mode
    type:
      - 'null'
      - string
    doc: 'Output mode: 1-in and out (all cavities and surrounding solvent), 2-out
      (only surrounding solvent), 3-in (only cavities)'
    inputBinding:
      position: 102
      prefix: -h
  - id: probe_radius
    type:
      - 'null'
      - float
    doc: Probe radius for SASA and cavity calculation [0, 2.0]
    inputBinding:
      position: 102
      prefix: -p
  - id: sas_type
    type:
      - 'null'
      - string
    doc: 'Type of SASA calculation: 1-VWS (Vollrath-Wolf-Schiffer), 2-SAS (Solvent
      Accessible Surface), 3-MS (Molecular Surface), 4-SES (Solvent Excluded Surface)'
    inputBinding:
      position: 102
      prefix: -s
  - id: scale_factor
    type:
      - 'null'
      - float
    doc: Scale factor for cavity volume calculation (0, 20.0]
    inputBinding:
      position: 102
      prefix: -f
  - id: surface_type
    type:
      - 'null'
      - string
    doc: 'Type of surface to calculate: 1-MC (Molecular Cavity), 2-VCMC (Volume of
      Molecular Cavity)'
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/edtsurf:v0.2009-6-deb_cv1
stdout: edtsurf_EDTSurf.out
