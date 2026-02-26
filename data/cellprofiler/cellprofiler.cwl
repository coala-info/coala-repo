cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellprofiler
label: cellprofiler
doc: "Run CellProfiler in headless mode or with a GUI.\n\nTool homepage: https://github.com/CellProfiler/CellProfiler"
inputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Optional filename for the output file of measurements when running 
      headless.
    inputBinding:
      position: 1
  - id: always_continue
    type:
      - 'null'
      - boolean
    doc: Keep running after an image set throws an error
    inputBinding:
      position: 102
      prefix: --always-continue
  - id: batch_commands_file
    type:
      - 'null'
      - File
    doc: "Open the measurements file following the --get-batch- commands switch and
      print one line to the console per group. The measurements file should be generated
      using CreateBatchFiles and the image sets should be grouped into the units to
      be run. Each line is a command to invoke CellProfiler. You can use this option
      to generate a shell script that will invoke CellProfiler on a cluster by substituting
      \"CellProfiler\" with your invocation command in the script's text, for instance:
      CellProfiler --get-batch-commands Batch_data.h5 | sed s/CellProfiler/farm_jobs.sh.
      Note that CellProfiler will always run in headless mode when --get-batch-commands
      is present and will exit after generating the batch commands without processing
      any pipeline. Note that this exact version is deprecated and will be removed
      in CellProfiler 5; you may use the new version now with --get-batch-commands-new"
    inputBinding:
      position: 102
      prefix: --get-batch-commands
  - id: conserve_memory
    type:
      - 'null'
      - boolean
    doc: CellProfiler will attempt to release unused memory after each image 
      set.
    inputBinding:
      position: 102
      prefix: --conserve-memory
  - id: data_file
    type:
      - 'null'
      - File
    doc: Specify the location of a .csv file for LoadData. If this switch is 
      present, this file is used instead of the one specified in the LoadData 
      module.
    inputBinding:
      position: 102
      prefix: --data-file
  - id: do_not_write_schema
    type:
      - 'null'
      - boolean
    doc: Do not execute the schema definition and other per- experiment SQL 
      commands during initialization when running a pipeline in batch mode.
    inputBinding:
      position: 102
      prefix: --do-not-write-schema
  - id: done_file
    type:
      - 'null'
      - File
    doc: The path to the "Done" file, written by CellProfiler shortly before 
      exiting
    inputBinding:
      position: 102
      prefix: --done-file
  - id: file_list
    type:
      - 'null'
      - File
    doc: Specify a file list of one file or URL per line to be used to initially
      populate the Images module's file list.
    inputBinding:
      position: 102
      prefix: --file-list
  - id: first_image_set
    type:
      - 'null'
      - int
    doc: The one-based index of the first image set to process
    inputBinding:
      position: 102
      prefix: --first-image-set
  - id: groups
    type:
      - 'null'
      - string
    doc: Restrict processing to one grouping in a grouped pipeline. For 
      instance, "-g ROW=H,COL=01", will process only the group of image sets 
      that match the keys.
    inputBinding:
      position: 102
      prefix: --group
  - id: image_directory
    type:
      - 'null'
      - Directory
    doc: Make this directory the default input folder
    inputBinding:
      position: 102
      prefix: --image-directory
  - id: images_per_batch
    type:
      - 'null'
      - int
    doc: For pipelines that do not use image grouping this option specifies the 
      number of images that should be processed in each batch if 
      --get-batch-commands is used. Defaults to 1.
    default: 1
    inputBinding:
      position: 102
      prefix: --images-per-batch
  - id: last_image_set
    type:
      - 'null'
      - int
    doc: The one-based index of the last image set to process
    inputBinding:
      position: 102
      prefix: --last-image-set
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set the verbosity for logging messages: 10 or DEBUG for debugging, 20 or
      INFO for informational, 30 or WARNING for warning, 40 or ERROR for error, 50
      or CRITICAL for critical, 50 or FATAL for fatal. Otherwise, the argument is
      interpreted as the file name of a log configuration file (see http://docs.python.org/library/logging.config.html
      for file format)'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: measurements
    type:
      - 'null'
      - boolean
    doc: Open the pipeline file specified by the -p switch and print the 
      measurements made by that pipeline
    inputBinding:
      position: 102
      prefix: --measurements
  - id: new_batch_commands_file
    type:
      - 'null'
      - File
    doc: "Open the batch file following the --get-batch- commands-new switch and print
      one line to the console per group. Each line is a command to invoke CellProfiler.
      You can use this option to generate a shell script that will invoke CellProfiler
      on a cluster by substituting \"CellProfiler\". This new version (which will
      be the only version in CellProfiler 5) will return groups if CellProfiler has
      more than one group and --images-per-batch is NOT passed (or is passed as 1),
      otherwise it will always return -f and -l commands. with your invocation command
      in the script's text, for instance: CellProfiler --get-batch-commands-new Batch_data.h5
      | sed s/CellProfiler/farm_jobs.sh. Note that CellProfiler will always run in
      headless mode when --get-batch-commands is present and will exit after generating
      the batch commands without processing any pipeline."
    inputBinding:
      position: 102
      prefix: --get-batch-commands-new
  - id: omero_credentials
    type:
      - 'null'
      - string
    doc: "Enter login credentials for OMERO. The credentials are entered as comma-separated
      key/value pairs with keys, \"host\" - the DNS host name for the OMERO server,
      \"port\" - the server's port # (typically 4064), \"user\" - the name of the
      connecting user, \"password\" - the connecting user's password, \"session-id\"\
      \ - the session ID for an OMERO client session., \"config-file\" - the path
      to the OMERO credentials config file. A typical set of credentials might be:
      --omero-credentials host=demo.openmicroscopy.org,port=4064,session- id=atrvomvjcjfe7t01e8eu59amixmqqkfp"
    inputBinding:
      position: 102
      prefix: --omero-credentials
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Make this directory the default output folder
    inputBinding:
      position: 102
      prefix: --output-directory
  - id: pipeline_filename
    type:
      - 'null'
      - File
    doc: Load this pipeline file or project on startup. If specifying a pipeline
      file rather than a project, the -i flag is also needed unless the pipeline
      is saved with the file list.
    inputBinding:
      position: 102
      prefix: --pipeline
  - id: plugins_directory
    type:
      - 'null'
      - Directory
    doc: CellProfiler will look for plugin modules in this directory 
      (headless-only).
    inputBinding:
      position: 102
      prefix: --plugins-directory
  - id: print_groups_file
    type:
      - 'null'
      - File
    doc: Open the measurements file following the --print- groups switch and 
      print the groups in its image sets. The measurements file should be 
      generated using CreateBatchFiles. The output is a JSON-encoded data 
      structure containing the group keys and values and the image sets in each 
      group.
    inputBinding:
      position: 102
      prefix: --print-groups
  - id: project_filename
    type:
      - 'null'
      - File
    doc: Load this pipeline file or project on startup. If specifying a pipeline
      file rather than a project, the -i flag is also needed unless the pipeline
      is saved with the file list.
    inputBinding:
      position: 102
      prefix: --project
  - id: run
    type:
      - 'null'
      - boolean
    doc: Run the given pipeline on startup
    inputBinding:
      position: 102
      prefix: --run
  - id: run_headless
    type:
      - 'null'
      - boolean
    doc: Run headless (without the GUI)
    inputBinding:
      position: 102
      prefix: --run-headless
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Temporary directory. CellProfiler uses this for downloaded image files 
      and for the measurements file, if not specified.
    default: /tmp
    inputBinding:
      position: 102
      prefix: --temporary-directory
  - id: widget_inspector
    type:
      - 'null'
      - boolean
    doc: Enable the widget inspector menu item under "Test"
    inputBinding:
      position: 102
      prefix: --widget-inspector
  - id: write_schema_and_exit
    type:
      - 'null'
      - boolean
    doc: Create the experiment database schema and exit
    inputBinding:
      position: 102
      prefix: --write-schema-and-exit
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellprofiler:4.2.8--pyhdfd78af_0
stdout: cellprofiler.out
