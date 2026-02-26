cwlVersion: v1.2
class: CommandLineTool
baseCommand: soda
label: soda-gallery_soda
doc: "Generate a gallery of genome browser tracks.\n\nTool homepage: https://github.com/alexpreynolds/soda"
inputs:
  - id: add_interval_annotation
    type:
      - 'null'
      - boolean
    doc: Add interval annotation underneath tracks (optional)
    inputBinding:
      position: 101
      prefix: --addIntervalAnnotation
  - id: add_midpoint_annotation
    type:
      - 'null'
      - boolean
    doc: Add midpoint annotation underneath tracks (optional)
    inputBinding:
      position: 101
      prefix: --addMidpointAnnotation
  - id: annotation_font_family
    type:
      - 'null'
      - string
    doc: Annotation font family (optional)
    inputBinding:
      position: 101
      prefix: --annotationFontFamily
  - id: annotation_font_point_size
    type:
      - 'null'
      - int
    doc: Annotation font point size (optional)
    inputBinding:
      position: 101
      prefix: --annotationFontPointSize
  - id: annotation_resolution
    type:
      - 'null'
      - int
    doc: Annotation resolution, dpi (optional)
    inputBinding:
      position: 101
      prefix: --annotationResolution
  - id: annotation_rgba
    type:
      - 'null'
      - string
    doc: Annotation 'rgba(r,g,b,a)' color string (optional)
    inputBinding:
      position: 101
      prefix: --annotationRgba
  - id: browser_build_id
    type: string
    doc: Genome build ID (required)
    inputBinding:
      position: 101
      prefix: --browserBuildID
  - id: browser_password
    type:
      - 'null'
      - string
    doc: Genome browser password (optional)
    inputBinding:
      position: 101
      prefix: --browserPassword
  - id: browser_session_id
    type: string
    doc: Genome browser session ID (required)
    inputBinding:
      position: 101
      prefix: --browserSessionID
  - id: browser_url
    type:
      - 'null'
      - string
    doc: Genome browser URL (optional)
    inputBinding:
      position: 101
      prefix: --browserURL
  - id: browser_username
    type:
      - 'null'
      - string
    doc: Genome browser username (optional)
    inputBinding:
      position: 101
      prefix: --browserUsername
  - id: convert_bin_fn
    type:
      - 'null'
      - File
    doc: ImageMagick convert binary path (optional)
    inputBinding:
      position: 101
      prefix: --convertBinFn
  - id: gallery_mode
    type:
      - 'null'
      - string
    doc: 'Gallery mode: blueimp or photoswipe [default: photoswipe]'
    default: photoswipe
    inputBinding:
      position: 101
      prefix: --galleryMode
  - id: gallery_src_dir
    type:
      - 'null'
      - Directory
    doc: Gallery resources directory (optional)
    inputBinding:
      position: 101
      prefix: --gallerySrcDir
  - id: gallery_title
    type:
      - 'null'
      - string
    doc: Gallery title (optional)
    inputBinding:
      position: 101
      prefix: --galleryTitle
  - id: identify_bin_fn
    type:
      - 'null'
      - File
    doc: ImageMagick identify binary path (optional)
    inputBinding:
      position: 101
      prefix: --identifyBinFn
  - id: octicons_src_dir
    type:
      - 'null'
      - Directory
    doc: Github Octicons resources directory (optional)
    inputBinding:
      position: 101
      prefix: --octiconsSrcDir
  - id: output_png_resolution
    type:
      - 'null'
      - int
    doc: Output PNG resolution, dpi (optional)
    inputBinding:
      position: 101
      prefix: --outputPngResolution
  - id: range_padding
    type:
      - 'null'
      - string
    doc: Add or remove symmetrical padding to input regions (optional)
    inputBinding:
      position: 101
      prefix: --range
  - id: regions_fn
    type: File
    doc: Path to BED-formatted regions of interest (required)
    inputBinding:
      position: 101
      prefix: --regionsFn
  - id: use_kerberos_authentication
    type:
      - 'null'
      - boolean
    doc: Use Kerberos authentication (optional)
    inputBinding:
      position: 101
      prefix: --useKerberosAuthentication
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug messages to stderr (optional)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Output gallery directory (required)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soda-gallery:1.2.0--pyhdfd78af_0
