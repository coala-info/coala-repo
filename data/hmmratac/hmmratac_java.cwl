cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: hmmratac_java
doc: "Java application launcher\n\nTool homepage: https://github.com/LiuLabUB/HMMRATAC"
inputs:
  - id: argument_files
    type:
      - 'null'
      - type: array
        items: File
    doc: one or more argument files containing options
    inputBinding:
      position: 1
  - id: main_class
    type:
      - 'null'
      - string
    doc: The main class to execute
    inputBinding:
      position: 2
  - id: source_file
    type:
      - 'null'
      - File
    doc: Execute a single source-file program
    inputBinding:
      position: 3
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the main class
    inputBinding:
      position: 4
  - id: add_modules
    type:
      - 'null'
      - type: array
        items: string
    doc: Root modules to resolve in addition to the initial module
    inputBinding:
      position: 105
      prefix: --add-modules
  - id: agent_lib
    type:
      - 'null'
      - string
    doc: load native agent library <libname>
    inputBinding:
      position: 105
      prefix: -agentlib
  - id: agent_path
    type:
      - 'null'
      - File
    doc: load native agent library by full pathname
    inputBinding:
      position: 105
      prefix: -agentpath
  - id: class_path
    type:
      - 'null'
      - string
    doc: 'A : separated list of directories, JAR archives, and ZIP archives to search
      for class files.'
    inputBinding:
      position: 105
      prefix: --class-path
  - id: describe_module
    type:
      - 'null'
      - string
    doc: describe a module and exit
    inputBinding:
      position: 105
      prefix: --describe-module
  - id: disable_assertions
    type:
      - 'null'
      - string
    doc: disable assertions with specified granularity
    inputBinding:
      position: 105
      prefix: -disableassertions
  - id: disable_at_files
    type:
      - 'null'
      - boolean
    doc: prevent further argument file expansion
    inputBinding:
      position: 105
      prefix: -disable-@files
  - id: disable_system_assertions
    type:
      - 'null'
      - boolean
    doc: disable system assertions
    inputBinding:
      position: 105
      prefix: -disablesystemassertions
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: create VM and load main class but do not execute main method
    inputBinding:
      position: 105
      prefix: --dry-run
  - id: enable_assertions
    type:
      - 'null'
      - string
    doc: enable assertions with specified granularity
    inputBinding:
      position: 105
      prefix: -enableassertions
  - id: enable_preview
    type:
      - 'null'
      - boolean
    doc: allow classes to depend on preview features of this release
    inputBinding:
      position: 105
      prefix: --enable-preview
  - id: enable_system_assertions
    type:
      - 'null'
      - boolean
    doc: enable system assertions
    inputBinding:
      position: 105
      prefix: -enablesystemassertions
  - id: jar_file
    type:
      - 'null'
      - File
    doc: Execute a jar file
    inputBinding:
      position: 105
      prefix: -jar
  - id: java_agent
    type:
      - 'null'
      - File
    doc: load Java programming language agent
    inputBinding:
      position: 105
      prefix: -javaagent
  - id: list_modules
    type:
      - 'null'
      - boolean
    doc: list observable modules and exit
    inputBinding:
      position: 105
      prefix: --list-modules
  - id: module
    type:
      - 'null'
      - string
    doc: Execute the main class in a module
    inputBinding:
      position: 105
      prefix: --module
  - id: module_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: 'A : separated list of directories, each directory is a directory of modules.'
    inputBinding:
      position: 105
      prefix: --module-path
  - id: show_module_resolution
    type:
      - 'null'
      - boolean
    doc: show module resolution output during startup
    inputBinding:
      position: 105
      prefix: --show-module-resolution
  - id: show_version_err
    type:
      - 'null'
      - boolean
    doc: print product version to the error stream and continue
    inputBinding:
      position: 105
      prefix: -showversion
  - id: show_version_out
    type:
      - 'null'
      - boolean
    doc: print product version to the output stream and continue
    inputBinding:
      position: 105
      prefix: --show-version
  - id: splash
    type:
      - 'null'
      - File
    doc: show splash screen with specified image
    inputBinding:
      position: 105
      prefix: -splash
  - id: system_property
    type:
      - 'null'
      - string
    doc: set a system property
    inputBinding:
      position: 105
      prefix: -D
  - id: upgrade_module_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: 'A : separated list of directories that replace upgradeable modules'
    inputBinding:
      position: 105
      prefix: --upgrade-module-path
  - id: validate_modules
    type:
      - 'null'
      - boolean
    doc: validate all modules and exit
    inputBinding:
      position: 105
      prefix: --validate-modules
  - id: verbose
    type:
      - 'null'
      - string
    doc: enable verbose output (class|module|gc|jni)
    inputBinding:
      position: 105
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmratac:1.2.10--hdfd78af_1
stdout: hmmratac_java.out
