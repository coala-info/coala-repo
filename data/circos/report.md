# circos CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| circos | PASS |  |

## circos

### Tool Description
circos - generate circular data visualizations

### Metadata
- **Docker Image**: quay.io/biocontainers/circos:0.69.9--hdfd78af_0
- **Homepage**: http://circos.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/circos/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circos/overview
- **Total Downloads**: 247.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
    circos - generate circular data visualizations

SYNOPSIS
      # without -conf Circos will search for configuration
      circos

      # use specific configuration file
      circos -conf circos.conf 

      # diagnose required modules
      circos -modules

      # detailed debugging for code components
      # see http://www.circos.ca/documentation/tutorials/configuration/debugging
      circos -debug_group GROUP1,[GROUP2,...]

      # full debugging
      circos -debug_group _all

      # absolutely no reporting
      circos ... [-silent]

      # configuration dump of a block (or block tree) of
      # any parameters that match REGEXP (optional)
      circos -cdump [BLOCK1/[BLOCK2/...]]{:REGEXP}
      circos -cdump ideogram
      circos -cdump ideogram:label
      circos -cdump ideogram/spacing

      # override configuration parameters
      circos -param image/radius=2000p -param ideogram/show=no

      # for fun - randomize all colors in the image except for
      # COLOR1, COLOR2,...
      circos -randomcolor COLOR1,[COLOR2,...]
      circos -randomcolor white,black

      # brief help
      circos -h

      # man page
      circos -man

      # version
      circos -v

OPTIONS
  Configuration
    -configfile FILE
        Name of configuration file. This is required.

        Circos will attempt to guess the location of this file, searching
        for "circos.conf" in ".", "..", and "../..". This is described
        above.

  Output Format
    -png, -nopng
    -svg, -nosvg
        Toggles output of PNG and SVG files.

  Image Elements
    -show_ticks, -noshow_ticks
    -show_tick_labels, -noshow_tick_labels
        Override the display of ticks and their labels. These are both
        usually defined in the <ticks> block.

        These flags are shortcuts to

          -param show_ticks=no
          -param show_tick_labels=no

  Output Paths
    -outputdir DIR, -dir DIR
    -outputfile FILE, -file FILE
        Change the output directory and filename. The FILE can contain a
        path.

  Debugging
    -debug
        Turn on basic debugging output. Reports information from

          image, io, layer, summary, timer

        debug groups (see below).

    -debug_group {+-}GROUP1,[{+-}GROUP2,...]
        Turn on debugging output for specific groups. For a list of groups,
        see

        <http://www.circos.ca/documentation/tutorials/configuration/debuggin
        g>

        To add a group to the output prefix it with +. To remove it, with -.

          # use default debugging groups but exclude layer and io
          -debug -debug_group -layer,-io

          # use default debugging groups and add spacing
          -debug -debug_group +spacing

          # explicitly specify the groups
          -debug_group png,io,timer

        To list the groups that are supported, use the flag without an
        argument

          -debug_group

        Those listed with a "*" are turned on by default. To change this,
        adjust "debug_group" in "etc/housekeeping.conf" in the distribution
        directory.

    -time
        Report timing information. Same as "-debug_group +timer".

    -silent
        Generate no reporting.

    -paranoid, -noparanoid
        Run in paranoid mode (default), or not. The default for this setting
        is defined by "paranoid" in "etc/housekeeping.conf".

    -warnings, -nowarnings
        Display warnings, or not (default). The default for this setting is
        defined by "warnings" in "etc/housekeeping.conf".

    -fakeerror =item -fakeerror CAT =item -fakeerror ,ID =item -fakeerror
    CAT,ID
        Fake an error by displaying the error message for category CAT and
        error name ID. If one or neither are specified, lists which errors
        are available.

        Unless you truly enjoy seeing error messages, there should be little
        reason for you to want to use this.

  Usage
    -version
        Show the version.

    -help
        Show brief usage synopsis.

    -man
        Show man page.

  Goofing Around
    -randomcolor [color1,color2,...]
        Randomize the color of every element in the image, except for an
        optional list of colors.

        For example, to keep the background white and anything that is
        black,

          -randomcolor white,black
```


## Metadata
- **Skill**: generated
