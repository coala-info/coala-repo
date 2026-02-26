cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: qsignature
doc: Execute Java classes or jar files
inputs:
  - id: class_or_jar
    type: string
    doc: The class to execute or the jar file to execute
    inputBinding:
      position: 1
  - id: class_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the class
    inputBinding:
      position: 2
  - id: jar_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the jar file
    inputBinding:
      position: 3
  - id: agent_lib
    type:
      - 'null'
      - string
    doc: load native agent library
    inputBinding:
      position: 104
      prefix: -agentlib
  - id: agent_path
    type:
      - 'null'
      - string
    doc: load native agent library by full pathname
    inputBinding:
      position: 104
      prefix: -agentpath
  - id: class_path
    type:
      - 'null'
      - string
    doc: 'A : separated list of directories, JAR archives, and ZIP archives to search
      for class files.'
    inputBinding:
      position: 104
      prefix: -classpath
  - id: disable_assertions
    type:
      - 'null'
      - type: array
        items: string
    doc: disable assertions with specified granularity
    inputBinding:
      position: 104
      prefix: -disableassertions
  - id: disable_system_assertions
    type:
      - 'null'
      - boolean
    doc: disable system assertions
    inputBinding:
      position: 104
      prefix: -disablesystemassertions
  - id: enable_assertions
    type:
      - 'null'
      - type: array
        items: string
    doc: enable assertions with specified granularity
    inputBinding:
      position: 104
      prefix: -enableassertions
  - id: enable_system_assertions
    type:
      - 'null'
      - boolean
    doc: enable system assertions
    inputBinding:
      position: 104
      prefix: -enablesystemassertions
  - id: java_agent
    type:
      - 'null'
      - string
    doc: load Java programming language agent
    inputBinding:
      position: 104
      prefix: -javaagent
  - id: no_jre_restrict_search
    type:
      - 'null'
      - boolean
    doc: exclude user private JREs in the version search
    inputBinding:
      position: 104
      prefix: -no-jre-restrict-search
  - id: require_version
    type:
      - 'null'
      - string
    doc: require the specified version to run
    inputBinding:
      position: 104
      prefix: -version
  - id: restrict_jre_search
    type:
      - 'null'
      - boolean
    doc: include user private JREs in the version search
    inputBinding:
      position: 104
      prefix: -jre-restrict-search
  - id: server_vm
    type:
      - 'null'
      - boolean
    doc: to select the "server" VM
    inputBinding:
      position: 104
      prefix: -server
  - id: show_version
    type:
      - 'null'
      - boolean
    doc: print product version and continue
    inputBinding:
      position: 104
      prefix: -showversion
  - id: splash_image
    type:
      - 'null'
      - string
    doc: show splash screen with specified image
    inputBinding:
      position: 104
      prefix: -splash
  - id: system_property
    type:
      - 'null'
      - type: array
        items: string
    doc: set a system property
    inputBinding:
      position: 104
  - id: use_32bit_model
    type:
      - 'null'
      - boolean
    doc: use a 32-bit data model if available
    inputBinding:
      position: 104
      prefix: -d32
  - id: use_64bit_model
    type:
      - 'null'
      - boolean
    doc: use a 64-bit data model if available
    inputBinding:
      position: 104
      prefix: -d64
  - id: verbose
    type:
      - 'null'
      - string
    doc: enable verbose output (class, gc, jni)
    inputBinding:
      position: 104
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qsignature:0.1pre--3
stdout: qsignature.out
