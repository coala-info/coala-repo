cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - MKFQ
label: lrtk_MKFQ
doc: "Simulate linked-read (10x or stLFR) sequencing reads from template genome sequences. The config argument is a directory with one configuration file per library; the simulated reads are written to a lib_<name> folder inside it.\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.config_file)
        writable: true
      - $(inputs.template_files)
inputs:
  - id: config_file
    type: Directory
    doc: 'The path to config_files for simulation: a directory with one configuration file per library (lines of the form KEY=VALUE such as Path_Fastahap1, Path_barcodepool, CF, CR, N_FP, Mu_F, SR, Mu_IS, Std_IS, Hap).'
    inputBinding:
      position: 1
      prefix: -CF
      valueFrom: $(self.basename)
  - id: template_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Template genome FASTA and barcode list files that the configuration files name; they are staged in the working directory so relative names in the configuration resolve.
  - id: input_type
    type:
      - 'null'
      - type: enum
        symbols:
          - 10x
          - stLFR
    doc: Input sequencing technology. Users can choose from (10x,stLFR)
    inputBinding:
      position: 1
      prefix: -IT
outputs:
  - id: simulation_directory
    type: Directory
    doc: The configuration directory, now holding the simulated library folders (lib_<name>).
    outputBinding:
      glob: $(inputs.config_file.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
