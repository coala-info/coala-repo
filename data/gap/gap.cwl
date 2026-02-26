cwlVersion: v1.2
class: CommandLineTool
baseCommand: gap
label: gap
doc: "run the Groups, Algorithms and Programming system, Version 4.8.10\n\nTool homepage:
  https://github.com/MacGapProject/MacGap1"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: architecture
    type:
      - 'null'
      - string
    doc: current architecture
    inputBinding:
      position: 102
      prefix: -B
  - id: autoload_packages
    type:
      - 'null'
      - boolean
    doc: disable/enable autoloading of suggested GAP packages
    inputBinding:
      position: 102
      prefix: -A
  - id: banner
    type:
      - 'null'
      - boolean
    doc: disable/enable the banner
    inputBinding:
      position: 102
      prefix: --banner
  - id: break_loop
    type:
      - 'null'
      - boolean
    doc: enable/disable break loop
    inputBinding:
      position: 102
      prefix: -T
  - id: cache_size
    type:
      - 'null'
      - string
    doc: set the cache size value
    inputBinding:
      position: 102
      prefix: -c
  - id: coverage_line_by_line
    type:
      - 'null'
      - File
    doc: Run CoverageLineByLine(<filename>) on GAP start
    inputBinding:
      position: 102
      prefix: --cover
  - id: crc_check_compiled_modules
    type:
      - 'null'
      - boolean
    doc: enable/disable CRC checking for compiled modules
    inputBinding:
      position: 102
      prefix: -X
  - id: debug_loading
    type:
      - 'null'
      - boolean
    doc: enable/disable debugging the loading of files
    inputBinding:
      position: 102
      prefix: -D
  - id: force_line_editing
    type:
      - 'null'
      - boolean
    doc: force line editing
    inputBinding:
      position: 102
      prefix: -f
  - id: gasinfo
    type:
      - 'null'
      - boolean
    doc: show GASMAN messages (full/all/no garbage collections)
    inputBinding:
      position: 102
      prefix: --gasinfo
  - id: init_file
    type:
      - 'null'
      - File
    doc: change the name of the init file
    inputBinding:
      position: 102
      prefix: -i
  - id: line_width
    type:
      - 'null'
      - int
    doc: set line width
    inputBinding:
      position: 102
      prefix: --width
  - id: lines
    type:
      - 'null'
      - int
    doc: set number of lines
    inputBinding:
      position: 102
      prefix: --lines
  - id: load_compiled_modules
    type:
      - 'null'
      - boolean
    doc: disable/enable loading of compiled modules
    inputBinding:
      position: 102
      prefix: -M
  - id: load_obsolete_files
    type:
      - 'null'
      - boolean
    doc: disable/enable loading of obsolete files
    inputBinding:
      position: 102
      prefix: -O
  - id: mapped_virtual_memory
    type:
      - 'null'
      - string
    doc: set the initially mapped virtual memory
    inputBinding:
      position: 102
      prefix: -s
  - id: max_workspace_hint
    type:
      - 'null'
      - string
    doc: set hint for maximal workspace size (GAP may allocate more)
    inputBinding:
      position: 102
      prefix: --maxworkspace
  - id: max_workspace_limit
    type:
      - 'null'
      - string
    doc: set maximal workspace size (GAP never allocates more)
    inputBinding:
      position: 102
      prefix: --limitworkspace
  - id: min_workspace
    type:
      - 'null'
      - string
    doc: set the initial workspace size
    inputBinding:
      position: 102
      prefix: --minworkspace
  - id: package_output_mode
    type:
      - 'null'
      - boolean
    doc: enable/disable package output mode
    inputBinding:
      position: 102
      prefix: -p
  - id: pre_malloc_amount
    type:
      - 'null'
      - string
    doc: set amount to pre-malloc-ate
    inputBinding:
      position: 102
      prefix: -a
  - id: prevent_line_editing
    type:
      - 'null'
      - boolean
    doc: prevent line editing
    inputBinding:
      position: 102
      prefix: -n
  - id: prevent_restore_workspace
    type:
      - 'null'
      - boolean
    doc: prevent restoring of workspace (ignoring -L)
    inputBinding:
      position: 102
      prefix: -R
  - id: profile_line_by_line
    type:
      - 'null'
      - File
    doc: Run ProfileLineByLine(<filename>) on GAP start
    inputBinding:
      position: 102
      prefix: --prof
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: enable/disable quiet mode
    inputBinding:
      position: 102
      prefix: --quiet
  - id: quit_on_ctrld
    type:
      - 'null'
      - boolean
    doc: disable/enable quitting on <ctr>-D
    inputBinding:
      position: 102
      prefix: -e
  - id: readline
    type:
      - 'null'
      - boolean
    doc: disable/enable use of readline library (if possible)
    inputBinding:
      position: 102
      prefix: --readline
  - id: restore_workspace
    type:
      - 'null'
      - File
    doc: restore a saved workspace
    inputBinding:
      position: 102
      prefix: -L
  - id: roots
    type:
      - 'null'
      - string
    doc: set the GAP root paths. Directories are separated using ';'. Putting 
      ';' on the start/end of list appends directories to the end/start of 
      existing list of root paths
    inputBinding:
      position: 102
      prefix: --roots
  - id: unused_backward_compatibility
    type:
      - 'null'
      - boolean
    doc: unused, for backward compatibility only
    inputBinding:
      position: 102
      prefix: -N
  - id: user_gap_root
    type:
      - 'null'
      - boolean
    doc: disable/enable user GAP root dir GAPInfo.UserGapRoot
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gap:4.8.10--0
stdout: gap.out
