cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cvbio
  - IgvBoss
label: cvbio_IgvBoss
doc: "Take control of your IGV session from end-to-end.\n\nIf no inputs are provided,
  then no new sessions will be created. Adding multiple IGV-valid locus identifiers
  will\nresult in a split-window view. You must have already configured your IGV application
  to allow HTTPS connections over a\nport. Enable remote control through the Advanced
  Tab of the Preferences Window in IGV.\n\nIGV Startup\n-----------\n\nIGV will be
  initialized using the ordered logic:\n\n  1. Let this tool connect to an already-running
  IGV session\n  2. Supply an IGV JAR file path and let this tool run the JAR\n  3.
  If you're on MacOS and have the Mac Application installed, IgvBoss will run it\n\
  \  4. Finally, IgvBoss will attempt to find the 'igv' executable on the system path
  and run it\n\nIgvBoss will always attempt to connect to a running IGV application
  before attempting to start a new instance of IGV.\nProvide a path to an IGV JAR
  file if no IGV applications are currently running. If no IGV JAR file path is set,
  and\nthere are no running instances of IGV, then IgvBoss will attempt to fnd a locally
  installed version of IGV and run it.\nIf you are executing IgvBoss on a MacOS system,
  then IgvBoss will first look for an installed IGV Mac application. If\none cannot
  be found, or you're on a different operating system, then IgvBoss will search for
  an 'igv' executable on the\nsystem path to execute.\n\nIGV Shutdown\n------------\n\
  \nYou can shutdown IGV when IgvBoss exits with the '--close-on-exit' option. This
  will work regardless of how IgvBoss\ninitially connected to IGV. This feature is
  handy for tearing down the application after your investigation is\nconcluded.\n\
  \nReferences and Prior Art\n------------------------\n\n  * https://github.com/igvteam/igv/blob/master/src/main/resources/org/broad/igv/prefs/preferences.tab\n\
  \  * https://software.broadinstitute.org/software/igv/PortCommands\n  * https://github.com/stevekm/IGV-snapshot-automator\n\
  \nTool homepage: https://github.com/clintval/cvbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: base_quality_maximum
    type:
      - 'null'
      - int
    doc: Maximum base quality to shade.
    inputBinding:
      position: 101
      prefix: --base-quality-maximum
  - id: base_quality_minimum
    type:
      - 'null'
      - int
    doc: Minimum base quality to shade.
    inputBinding:
      position: 101
      prefix: --base-quality-minimum
  - id: close_on_exit
    type:
      - 'null'
      - boolean
    doc: Close the IGV application after execution.
    default: false
    inputBinding:
      position: 101
      prefix: --close-on-exit
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
    inputBinding:
      position: 101
      prefix: --compression
  - id: downsample
    type:
      - 'null'
      - boolean
    doc: Downsample reads or not.
    inputBinding:
      position: 101
      prefix: --downsample
  - id: genome
    type:
      - 'null'
      - string
    doc: The genome to use (path, string, id).
    inputBinding:
      position: 101
      prefix: --genome
  - id: host
    type:
      - 'null'
      - string
    doc: The host the IGV server is running on.
    default: 127.0.0.1
    inputBinding:
      position: 101
      prefix: --host
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to display.
    inputBinding:
      position: 101
      prefix: --input
  - id: jar_file
    type:
      - 'null'
      - File
    doc: The IGV Jar file, if we are to initialize IGV.
    inputBinding:
      position: 101
      prefix: --jar
  - id: loci
    type:
      - 'null'
      - type: array
        items: string
    doc: The loci to visit. (e.g. "all", "chr1:23-99", "TP53").
    inputBinding:
      position: 101
      prefix: --loci
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: memory
    type:
      - 'null'
      - int
    doc: The heap size (Gb) given to the JVM, if we initialize.
    default: 5
    inputBinding:
      position: 101
      prefix: --memory
  - id: port
    type:
      - 'null'
      - int
    doc: The port to the IGV server.
    default: 60151
    inputBinding:
      position: 101
      prefix: --port
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cvbio:3.0.0--0
stdout: cvbio_IgvBoss.out
