cwlVersion: v1.2
class: CommandLineTool
baseCommand: dcm2niix
label: dcm2niix
doc: Convert DICOM images to NIfTI format
inputs:
  - id: in_folder
    type: Directory
    doc: Input directory containing DICOM files
    inputBinding:
      position: 103
  - id: compression_level
    type:
      - 'null'
      - int
    doc: gz compression level (1=fastest..9=smallest, default 6)
    inputBinding:
      position: 102
      prefix: '-'
      separate: false
  - id: bids_sidecar
    type:
      - 'null'
      - string
    doc: 'BIDS sidecar (y/n/o [o=only: no NIfTI], default y)'
    inputBinding:
      position: 102
      prefix: -b
  - id: anonymize_bids
    type:
      - 'null'
      - string
    doc: anonymize BIDS (y/n, default y)
    inputBinding:
      position: 102
      prefix: -ba
  - id: comment
    type:
      - 'null'
      - string
    doc: comment stored in NIfTI aux_file (up to 24 characters)
    inputBinding:
      position: 102
      prefix: -c
  - id: search_depth
    type:
      - 'null'
      - int
    doc: directory search depth. Convert DICOMs in sub-folders of in_folder? 
      (0..9, default 5)
    inputBinding:
      position: 102
      prefix: -d
  - id: filename_format
    type:
      - 'null'
      - string
    doc: filename format (%a=antenna (coil) name, %b=basename, %c=comments, 
      %d=description, %e=echo number, %f=folder name, %i=ID of patient, 
      %j=seriesInstanceUID, %k=studyInstanceUID, %m=manufacturer, %n=name of 
      patient, %p=protocol, %r=instance number, %s=series number, %t=time, 
      %u=acquisition number, %v=vendor, %x=study ID; %z=sequence name; default 
      '%f_%p_%t_%s')
    inputBinding:
      position: 102
      prefix: -f
  - id: generate_defaults
    type:
      - 'null'
      - string
    doc: 'generate defaults file (y/n/o/i [o=only: reset and write defaults; i=ignore:
      reset defaults], default n)'
    inputBinding:
      position: 102
      prefix: -g
  - id: ignore_derived
    type:
      - 'null'
      - string
    doc: ignore derived, localizer and 2D images (y/n, default n)
    inputBinding:
      position: 102
      prefix: -i
  - id: lossless_scale
    type:
      - 'null'
      - string
    doc: losslessly scale 16-bit integers to use dynamic range (y/n, default n)
    inputBinding:
      position: 102
      prefix: -l
  - id: merge_2d_slices
    type:
      - 'null'
      - string
    doc: merge 2D slices from same series regardless of study time, echo, coil, 
      orientation, etc. (y/n, default n)
    inputBinding:
      position: 102
      prefix: -m
  - id: series_number
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: -n
          separate: true
    doc: only convert this series number - can be used up to 16 times (default 
      convert all)
    inputBinding:
      position: 102
  - id: output_dir
    type:
      - 'null'
      - string
    doc: output directory (created in the working directory)
    inputBinding:
      position: 102
      prefix: -o
    default: dcm2niix_out
  - id: philips_precise_scaling
    type:
      - 'null'
      - string
    doc: Philips precise float (not display) scaling (y/n, default y)
    inputBinding:
      position: 102
      prefix: -p
  - id: rename_dicoms
    type:
      - 'null'
      - string
    doc: rename instead of convert DICOMs (y/n, default n)
    inputBinding:
      position: 102
      prefix: -r
  - id: single_file_mode
    type:
      - 'null'
      - string
    doc: single file mode, do not convert other images in folder (y/n, default 
      n)
    inputBinding:
      position: 102
      prefix: -s
  - id: text_notes
    type:
      - 'null'
      - string
    doc: text notes includes private patient details (y/n, default n)
    inputBinding:
      position: 102
      prefix: -t
  - id: up_to_date_check
    type:
      - 'null'
      - boolean
    doc: up-to-date check
    inputBinding:
      position: 102
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbose (n/y or 0/1/2 [no, yes, logorrheic], default 0)
    inputBinding:
      position: 102
      prefix: -v
  - id: crop
    type:
      - 'null'
      - string
    doc: crop (y/n, default n)
    inputBinding:
      position: 102
      prefix: -x
  - id: gz_compress
    type:
      - 'null'
      - string
    doc: gz compress images (y/i/n/3, default n) [y=pigz, i=internal:miniz, 
      n=no, 3=no,3D]
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: output_output_dir
    type: Directory
    doc: output directory with the NIfTI and BIDS sidecar files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.output_dir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dcm2niix:v1.0.20181125-1-deb_cv1
s:url: https://github.com/rordenlab/dcm2niix
$namespaces:
  s: https://schema.org/
