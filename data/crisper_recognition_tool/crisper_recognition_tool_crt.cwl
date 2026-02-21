cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: crisper_recognition_tool_crt
doc: "Java Virtual Machine launcher used to run the CRISPR Recognition Tool (CRT).\n
  \nTool homepage: http://www.room220.com/crt/"
inputs:
  - id: class_name
    type:
      - 'null'
      - string
    doc: The class to execute (if -jar is not used)
    inputBinding:
      position: 1
  - id: app_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the application
    inputBinding:
      position: 2
  - id: agent_lib
    type:
      - 'null'
      - string
    doc: load native agent library <libname>
    inputBinding:
      position: 103
      prefix: '-agentlib:'
  - id: agent_path
    type:
      - 'null'
      - string
    doc: load native agent library by full pathname
    inputBinding:
      position: 103
      prefix: '-agentpath:'
  - id: classpath
    type:
      - 'null'
      - string
    doc: 'A : separated list of directories, JAR archives, and ZIP archives to search
      for class files.'
    inputBinding:
      position: 103
      prefix: -classpath
  - id: disable_assertions
    type:
      - 'null'
      - string
    doc: disable assertions with specified granularity
    inputBinding:
      position: 103
      prefix: -disableassertions
  - id: disable_system_assertions
    type:
      - 'null'
      - boolean
    doc: disable system assertions
    inputBinding:
      position: 103
      prefix: -disablesystemassertions
  - id: enable_assertions
    type:
      - 'null'
      - string
    doc: enable assertions with specified granularity
    inputBinding:
      position: 103
      prefix: -enableassertions
  - id: enable_system_assertions
    type:
      - 'null'
      - boolean
    doc: enable system assertions
    inputBinding:
      position: 103
      prefix: -enablesystemassertions
  - id: jar_file
    type:
      - 'null'
      - File
    doc: execute a jar file
    inputBinding:
      position: 103
      prefix: -jar
  - id: java_agent
    type:
      - 'null'
      - File
    doc: load Java programming language agent
    inputBinding:
      position: 103
      prefix: '-javaagent:'
  - id: jre_restrict_search
    type:
      - 'null'
      - boolean
    doc: include user private JREs in the version search
    inputBinding:
      position: 103
      prefix: -jre-restrict-search
  - id: no_jre_restrict_search
    type:
      - 'null'
      - boolean
    doc: exclude user private JREs in the version search
    inputBinding:
      position: 103
      prefix: -no-jre-restrict-search
  - id: non_standard_options
    type:
      - 'null'
      - boolean
    doc: print help on non-standard options
    inputBinding:
      position: 103
      prefix: -X
  - id: server
    type:
      - 'null'
      - boolean
    doc: to select the "server" VM
    inputBinding:
      position: 103
      prefix: -server
  - id: show_version
    type:
      - 'null'
      - boolean
    doc: print product version and continue
    inputBinding:
      position: 103
      prefix: -showversion
  - id: splash_image
    type:
      - 'null'
      - File
    doc: show splash screen with specified image
    inputBinding:
      position: 103
      prefix: '-splash:'
  - id: system_property
    type:
      - 'null'
      - string
    doc: set a system property (e.g., -D<name>=<value>)
    inputBinding:
      position: 103
      prefix: -D
  - id: use_32bit
    type:
      - 'null'
      - boolean
    doc: use a 32-bit data model if available
    inputBinding:
      position: 103
      prefix: -d32
  - id: use_64bit
    type:
      - 'null'
      - boolean
    doc: use a 64-bit data model if available
    inputBinding:
      position: 103
      prefix: -d64
  - id: verbose
    type:
      - 'null'
      - string
    doc: enable verbose output (class|gc|jni)
    inputBinding:
      position: 103
      prefix: '-verbose:'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisper_recognition_tool:1.2--py35_0
stdout: crisper_recognition_tool_crt.out
