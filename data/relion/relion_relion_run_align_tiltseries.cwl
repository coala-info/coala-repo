cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_run_align_tiltseries
label: relion_relion_run_align_tiltseries
doc: "Align tomography tilt series with IMOD (fiducial or patch tracking) or AreTomo2 (needs the external\
  \ program).\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: STAR file with all input tomograms, or a unix wildcard to all tomogram files, e.g. "mics/*.mrc"
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Directory, where all output files will be stored (RELION default: AlignTiltSeries/)'
    inputBinding:
      position: 101
      prefix: --o
    default: AlignTiltSeries
  - id: tomogram_thickness
    type:
      - 'null'
      - float
    doc: 'Estimated tomogram thickness (in nm) (RELION default: 300)'
    inputBinding:
      position: 101
      prefix: --tomogram_thickness
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only estimate CTFs for those tomograms for which there is not yet a logfile with Final values.
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: do_at_most
    type:
      - 'null'
      - int
    doc: 'Only process up to this number of (unprocessed) tomograms. (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --do_at_most
  - id: batchtomo_exe
    type:
      - 'null'
      - string
    doc: IMOD's batchruntomo executable (default is set through $RELION_BATCHTOMO_EXECUTABLE)
    inputBinding:
      position: 101
      prefix: --batchtomo_exe
  - id: adoc_template
    type:
      - 'null'
      - File
    doc: Filename of a template for the IMOD directive file (by default, use hard-coded defaults)
    inputBinding:
      position: 101
      prefix: --adoc_template
  - id: imod_fiducials
    type:
      - 'null'
      - boolean
    doc: Use IMOD's fiducial-based alignment method
    inputBinding:
      position: 101
      prefix: --imod_fiducials
  - id: fiducial_diameter
    type:
      - 'null'
      - float
    doc: 'Diameter of the fiducials (in nm) (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --fiducial_diameter
  - id: imod_patchtrack
    type:
      - 'null'
      - boolean
    doc: 'OR: Use IMOD''s patrick-tracking alignment method'
    inputBinding:
      position: 101
      prefix: --imod_patchtrack
  - id: patch_overlap
    type:
      - 'null'
      - float
    doc: 'Overlap between the patches (in %) (RELION default: 10.)'
    inputBinding:
      position: 101
      prefix: --patch_overlap
  - id: patch_size
    type:
      - 'null'
      - float
    doc: 'Patch size (in nm) (RELION default: 100.)'
    inputBinding:
      position: 101
      prefix: --patch_size
  - id: aretomo2
    type:
      - 'null'
      - boolean
    doc: 'OR: Use AreTomo2 alignment method'
    inputBinding:
      position: 101
      prefix: --aretomo2
  - id: aretomo_exe
    type:
      - 'null'
      - string
    doc: AreTomo executable (can be set through $RELION_ARETOMO_EXECUTABLE, defaults to AreTomo2)
    inputBinding:
      position: 101
      prefix: --aretomo_exe
  - id: aretomo_tiltcorrect
    type:
      - 'null'
      - boolean
    doc: Specify to correct the tilt angle offset in the tomogram (AreTomo -TiltCor option; default=false)
    inputBinding:
      position: 101
      prefix: --aretomo_tiltcorrect
  - id: aretomo_tiltcorrect_angle
    type:
      - 'null'
      - float
    doc: 'User-specified tilt angle correction (value > 180, means estimate automatically (RELION default:
      999.)'
    inputBinding:
      position: 101
      prefix: --aretomo_tiltcorrect_angle
  - id: aretomo_ctf
    type:
      - 'null'
      - boolean
    doc: Perform CTF estimation in AreTomo? (default=false)
    inputBinding:
      position: 101
      prefix: --aretomo_ctf
  - id: aretomo_phaseshift
    type:
      - 'null'
      - boolean
    doc: Perform CTF estimation in AreTomo? (default=false)
    inputBinding:
      position: 101
      prefix: --aretomo_phaseshift
  - id: gpu
    type:
      - 'null'
      - string
    doc: Device ids for each MPI-thread, e.g 0:1:2:3
    inputBinding:
      position: 101
      prefix: --gpu
  - id: other_wrapper_args
    type:
      - 'null'
      - string
    doc: Additional command-line arguments that will be passed onto the wrapper.
    inputBinding:
      position: 101
      prefix: --other_wrapper_args
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the alignment results
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_run_align_tiltseries.out
