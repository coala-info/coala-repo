cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogs
label: ogs
doc: "OpenGeoSys-6 software.\n\nTool homepage: https://github.com/OGSR/OGSR-Engine"
inputs:
  - id: project_file
    type: File
    doc: Path to the ogs6 project file.
    inputBinding:
      position: 1
  - id: config_warnings_nonfatal
    type:
      - 'null'
      - boolean
    doc: warnings from parsing the configuration file will not trigger program 
      abortion
    inputBinding:
      position: 102
      prefix: --config-warnings-nonfatal
  - id: enable_fpe
    type:
      - 'null'
      - boolean
    doc: enables floating point exceptions
    inputBinding:
      position: 102
      prefix: --enable-fpe
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --ignore_rest
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'the verbosity of logging messages: none, error, warn, info, debug, all'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: mesh_input_directory
    type:
      - 'null'
      - Directory
    doc: the directory where the meshes are read from
    inputBinding:
      position: 102
      prefix: --mesh-input-directory
  - id: reference
    type:
      - 'null'
      - Directory
    doc: Run output result comparison after successful simulation comparing to 
      all files in the given path. This requires test definitions to be present 
      in the project file.
    inputBinding:
      position: 102
      prefix: --reference
  - id: script_input_directory
    type:
      - 'null'
      - Directory
    doc: the directory where script files (e.g. Python BCs) are read from
    inputBinding:
      position: 102
      prefix: --script-input-directory
  - id: unbuffered_std_out
    type:
      - 'null'
      - boolean
    doc: use unbuffered standard output
    inputBinding:
      position: 102
      prefix: --unbuffered-std-out
  - id: write_prj
    type:
      - 'null'
      - boolean
    doc: Writes processed project file to output path / 
      [prj_base_name]_processed.prj.
    inputBinding:
      position: 102
      prefix: --write-prj
  - id: xml_patch
    type:
      - 'null'
      - type: array
        items: File
    doc: the xml patch file(s) which is (are) applied (in the given order) to 
      the PROJECT_FILE
    inputBinding:
      position: 102
      prefix: --xml-patch
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: the output directory to write to
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ogs:6.5.3
