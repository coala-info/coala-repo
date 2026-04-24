cwlVersion: v1.2
class: CommandLineTool
baseCommand: PretextSnapshot
label: pretextsnapshot_PretextSnapshot
doc: "an image generator for pretext contact maps.\n\nTool homepage: https://github.com/wtsi-hpag/PretextSnapshot"
inputs:
  - id: colour_map
    type:
      - 'null'
      - string
    doc: "Either, a non-negative integer, indexing the colour map to use.\n      \
      \                          Or, the name of the colour map to use.\n        \
      \                        Defaults to \"Three Wave Blue-Green-Yellow\" i.e. \"\
      8\"."
    inputBinding:
      position: 101
      prefix: --colourMap
  - id: format
    type:
      - 'null'
      - string
    doc: Image format, one of "png"(default) "bmp" or "jpeg".
    inputBinding:
      position: 101
      prefix: --format
  - id: grid_colour
    type:
      - 'null'
      - string
    doc: "Colour of the sequence separation grid.\n                              \
      \  Either, one of: \"black\"(default), \"white\", \"red\", \"green\", \"blue\"\
      , \"yellow\", \"cyan\" or \"magenta\".\n                                Or,
      a sRGBA 32-bit hex code in RRGGBBAA format, e.g. \"ff00ff80\" (magenta at half-occupancy)."
    inputBinding:
      position: 101
      prefix: --gridColour
  - id: grid_size
    type:
      - 'null'
      - int
    doc: "Width in pixels of the sequence separation grid, a non-negative integer,
      default 1.\n                                Set to 0 to not overlay a grid."
    inputBinding:
      position: 101
      prefix: --gridSize
  - id: jpeg_quality
    type:
      - 'null'
      - int
    doc: "JPEG quality factor, an integer between 1 and 100, default 80.\n       \
      \                         Larger values result in increased image quality and
      file size.\n                                Only applicable to JPEG images."
    inputBinding:
      position: 101
      prefix: --jpegQuality
  - id: licence
    type:
      - 'null'
      - boolean
    doc: Prints the software licence.
    inputBinding:
      position: 101
      prefix: --licence
  - id: map
    type: File
    doc: Path to a pretext map.
    inputBinding:
      position: 101
      prefix: --map
  - id: min_texels
    type:
      - 'null'
      - int
    doc: "Minimum map texels per image (along a single dimension), a positive integer,
      default 64.\n                                Output images over too small a
      range that violate this minimum will not be created."
    inputBinding:
      position: 101
      prefix: --minTexels
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix name for all image files.\n                                Defaults
      to the name of the pretext map + \"_\"."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: print_colour_map_names
    type:
      - 'null'
      - boolean
    doc: Prints a list of the available colour maps.
    inputBinding:
      position: 101
      prefix: --printColourMapNames
  - id: print_sequence_names
    type:
      - 'null'
      - boolean
    doc: "Prints a list of the individual sequence names in the map, in order of appearance.\n\
      \                                Can only be used with the -m/--map option."
    inputBinding:
      position: 101
      prefix: --printSequenceNames
  - id: resolution
    type:
      - 'null'
      - int
    doc: "Image resolution, a positive integer, default 1080.\n                  \
      \              For non-square images this will be the resolution\n         \
      \                       of the longest dimension."
    inputBinding:
      position: 101
      prefix: --resolution
  - id: sequence_help
    type:
      - 'null'
      - boolean
    doc: Sequence specification string format documentation.
    inputBinding:
      position: 101
      prefix: --sequenceHelp
  - id: sequences
    type:
      - 'null'
      - string
    doc: "Sequence specification string. Each entry, except for \"=all\", corresponds
      to one output image.\n                                Defaults to \"=full, =all\"\
      ."
    inputBinding:
      position: 101
      prefix: --sequences
  - id: third_party
    type:
      - 'null'
      - boolean
    doc: Prints a list of the third-party libraries used, along with their 
      respective licences.
    inputBinding:
      position: 101
      prefix: --thirdParty
  - id: verbose
    type:
      - 'null'
      - string
    doc: "Verbosity level, one of: \"3\"(default) for error, warning and status messages.\n\
      \t\t\t\t \"2\" for error and warning messages.\n\t\t\t\t \"1\" for error messages.\n\
      \t\t\t\t \"0\" for no messages.\n                                Warning and
      status messages are printed to stdout, error messages to stderr."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: folder
    type:
      - 'null'
      - Directory
    doc: "Output folder path, will be created if it doesn't exist.\n             \
      \                   Defaults to the name of the pretext map."
    outputBinding:
      glob: $(inputs.folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextsnapshot:0.0.5--h9948957_0
