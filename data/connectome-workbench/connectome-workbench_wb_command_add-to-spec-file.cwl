cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -add-to-spec-file
label: connectome-workbench_wb_command_add-to-spec-file
doc: "Add a file to a specification file. The resulting spec file overwrites the existing spec file. If the spec file doesn't exist, it is created with default metadata. The data file is staged next to the spec file, so the spec file lists it by its base name.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [inputs.filename];
        if (inputs.spec_in) {
          l.push({"entryname": inputs.specfile, "entry": inputs.spec_in, "writable": true});
        }
        return l;
      }
inputs:
  - id: specfile
    type: string
    doc: the specification file to add to (name of the spec file to write)
    inputBinding:
      position: 1
  - id: spec_in
    type:
      - 'null'
      - File
    doc: an existing specification file to add to; it is copied to <specfile> first
  - id: structure
    type: string
    doc: 'the structure of the data file: CORTEX_LEFT, CORTEX_RIGHT, CEREBELLUM, ACCUMBENS_LEFT, ACCUMBENS_RIGHT, ALL_GREY_MATTER, ALL_WHITE_MATTER, AMYGDALA_LEFT, AMYGDALA_RIGHT, BRAIN_STEM, CAUDATE_LEFT, CAUDATE_RIGHT, CEREBELLAR_WHITE_MATTER_LEFT, CEREBELLAR_WHITE_MATTER_RIGHT, CEREBELLUM_LEFT, CEREBELLUM_RIGHT, CEREBRAL_WHITE_MATTER_LEFT, CEREBRAL_WHITE_MATTER_RIGHT, CORTEX, DIENCEPHALON_VENTRAL_LEFT, DIENCEPHALON_VENTRAL_RIGHT, HIPPOCAMPUS_LEFT, HIPPOCAMPUS_RIGHT, INVALID, OTHER, OTHER_GREY_MATTER, OTHER_WHITE_MATTER, PALLIDUM_LEFT, PALLIDUM_RIGHT, PUTAMEN_LEFT, PUTAMEN_RIGHT, THALAMUS_LEFT, THALAMUS_RIGHT'
    inputBinding:
      position: 2
  - id: filename
    type: File
    doc: the path to the file
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
outputs:
  - id: spec_out
    type: File
    doc: the updated or new specification file
    outputBinding:
      glob: $(inputs.specfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
