cwlVersion: v1.2
class: CommandLineTool
baseCommand: buildH
label: buildh_buildH
doc: "This program builds hydrogens and calculates the order parameters (OP) from
  a united-atom trajectory of lipids. If -opx is requested, pdb and xtc output files
  with hydrogens are created but OP calculation will be slow. If no trajectory output
  is requested (no use of flag -opx), it uses a fast procedure to build hydrogens
  and calculate the OP.\n\nTool homepage: https://github.com/patrickfuchs/buildH"
inputs:
  - id: begin
    type:
      - 'null'
      - string
    doc: The first frame (ps) to read from the trajectory.
    inputBinding:
      position: 101
      prefix: --begin
  - id: coord
    type: File
    doc: Coordinate file (pdb or gro format).
    inputBinding:
      position: 101
      prefix: --coord
  - id: defop
    type: string
    doc: Order parameter definition file. Can be found on 
      https://github.com/patrickfuchs/buildH/tree/master/def_files.
    inputBinding:
      position: 101
      prefix: --defop
  - id: end
    type:
      - 'null'
      - string
    doc: The last frame (ps) to read from the trajectory.
    inputBinding:
      position: 101
      prefix: --end
  - id: ignore_ch3s
    type:
      - 'null'
      - boolean
    doc: Ignore CH3s groups for the construction of hydrogens and the 
      calculation of the OP.
    inputBinding:
      position: 101
      prefix: --ignore-CH3s
  - id: lipid
    type: string
    doc: Combinaison of ForceField name and residue name for the lipid to 
      calculate the OP on (e.g. Berger_POPC).It must match with the internal 
      topology files or the one(s) supplied.A list of supported terms is printed
      when calling the help.
    inputBinding:
      position: 101
      prefix: --lipid
  - id: lipid_topology
    type:
      - 'null'
      - type: array
        items: File
    doc: User topology lipid json file(s).
    inputBinding:
      position: 101
      prefix: --lipid_topology
  - id: opdbxtc
    type:
      - 'null'
      - string
    doc: Base name for trajectory output with hydrogens. File extension will be 
      automatically added. For example -opx trajH will generate trajH.pdb and 
      trajH.xtc. So far only xtc is supported.
    inputBinding:
      position: 101
      prefix: --opdbxtc
  - id: out
    type:
      - 'null'
      - string
    doc: Output file name for storing order parameters. Default name is 
      OP_buildH.out.
    default: OP_buildH.out
    inputBinding:
      position: 101
      prefix: --out
  - id: traj
    type:
      - 'null'
      - File
    doc: Input trajectory file. Could be in XTC, TRR or DCD format.
    inputBinding:
      position: 101
      prefix: --traj
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/buildh:1.6.1--pyhdfd78af_0
stdout: buildh_buildH.out
