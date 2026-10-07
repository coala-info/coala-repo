cwlVersion: v1.2
class: CommandLineTool
baseCommand: circos
label: circos
doc: "circos - generate circular data visualizations. Circos is driven by plain-text
  configuration files that name the data files to plot; stage those files with
  input_dir or data_files so relative paths in the configuration resolve.\n\nTool
  homepage: http://circos.ca"
requirements:
  - class: InlineJavascriptRequirement
  - class: LoadListingRequirement
    loadListing: shallow_listing
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.input_dir) { l = l.concat(inputs.input_dir.listing); }
        if (inputs.data_files) { l = l.concat(inputs.data_files); }
        if (inputs.outputdir) {
          l.push({"class": "Directory", "basename": inputs.outputdir, "listing": [], "writable": true});
        }
        return l;
      }
inputs:
  - id: conf
    type:
      - 'null'
      - File
    doc: Name of configuration file. Give this or conf_in_dir.
    inputBinding:
      position: 101
      prefix: -conf
  - id: conf_in_dir
    type:
      - 'null'
      - string
    doc: Path of the configuration file inside input_dir (e.g. etc/circos.conf),
      passed to -conf; use this when the configuration includes files by paths
      relative to its own folder. Give this or conf.
    inputBinding:
      position: 101
      prefix: -conf
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Folder whose contents (data files, included configuration files) are
      placed in the working directory, as when Circos runs from that folder
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data and included configuration files named in the configuration, placed
      in the working directory
  - id: outputdir
    type:
      - 'null'
      - string
    doc: Change the output directory (created in the working directory)
    inputBinding:
      position: 101
      prefix: -outputdir
  - id: outputfile
    type:
      - 'null'
      - string
    doc: Change the output filename
    inputBinding:
      position: 101
      prefix: -outputfile
  - id: png
    type:
      - 'null'
      - boolean
    doc: Toggle output of PNG files on
    inputBinding:
      position: 101
      prefix: -png
  - id: nopng
    type:
      - 'null'
      - boolean
    doc: Toggle output of PNG files off
    inputBinding:
      position: 101
      prefix: -nopng
  - id: svg
    type:
      - 'null'
      - boolean
    doc: Toggle output of SVG files on
    inputBinding:
      position: 101
      prefix: -svg
  - id: nosvg
    type:
      - 'null'
      - boolean
    doc: Toggle output of SVG files off
    inputBinding:
      position: 101
      prefix: -nosvg
  - id: show_ticks
    type:
      - 'null'
      - boolean
    doc: Override the display of ticks (show)
    inputBinding:
      position: 101
      prefix: -show_ticks
  - id: noshow_ticks
    type:
      - 'null'
      - boolean
    doc: Override the display of ticks (hide)
    inputBinding:
      position: 101
      prefix: -noshow_ticks
  - id: show_tick_labels
    type:
      - 'null'
      - boolean
    doc: Override the display of tick labels (show)
    inputBinding:
      position: 101
      prefix: -show_tick_labels
  - id: noshow_tick_labels
    type:
      - 'null'
      - boolean
    doc: Override the display of tick labels (hide)
    inputBinding:
      position: 101
      prefix: -noshow_tick_labels
  - id: param
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -param
    doc: Override configuration parameters, e.g. image/radius=2000p
    inputBinding:
      position: 101
  - id: cdump
    type:
      - 'null'
      - string
    doc: Configuration dump of a block (or block tree) of any parameters that match
      REGEXP
    inputBinding:
      position: 101
      prefix: -cdump
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on basic debugging output
    inputBinding:
      position: 101
      prefix: -debug
  - id: debug_group
    type:
      - 'null'
      - string
    doc: Turn on debugging output for specific groups ({+-}GROUP1,[{+-}GROUP2,...])
    inputBinding:
      position: 101
      prefix: -debug_group
  - id: time
    type:
      - 'null'
      - boolean
    doc: Report timing information. Same as -debug_group +timer
    inputBinding:
      position: 101
      prefix: -time
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Generate no reporting
    inputBinding:
      position: 101
      prefix: -silent
  - id: paranoid
    type:
      - 'null'
      - boolean
    doc: Run in paranoid mode (default)
    inputBinding:
      position: 101
      prefix: -paranoid
  - id: noparanoid
    type:
      - 'null'
      - boolean
    doc: Do not run in paranoid mode
    inputBinding:
      position: 101
      prefix: -noparanoid
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: Display warnings
    inputBinding:
      position: 101
      prefix: -warnings
  - id: nowarnings
    type:
      - 'null'
      - boolean
    doc: Do not display warnings (default)
    inputBinding:
      position: 101
      prefix: -nowarnings
  - id: randomcolor
    type:
      - 'null'
      - string
    doc: Randomize the color of every element in the image, except for an optional
      list of colors
    inputBinding:
      position: 101
      prefix: -randomcolor
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (report)
  - id: png_image
    type:
      - 'null'
      - File
    doc: PNG image
    outputBinding:
      glob: "$((inputs.outputdir ? inputs.outputdir + '/' : '') + (inputs.outputfile
        ? inputs.outputfile.replace(/\\.(png|svg)$/, '') : '*') + '.png')"
  - id: svg_image
    type:
      - 'null'
      - File
    doc: SVG image
    outputBinding:
      glob: "$((inputs.outputdir ? inputs.outputdir + '/' : '') + (inputs.outputfile
        ? inputs.outputfile.replace(/\\.(png|svg)$/, '') : '*') + '.svg')"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circos:0.69.9--hdfd78af_0
stdout: circos.out
