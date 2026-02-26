# pretextsnapshot CWL Generation Report

## pretextsnapshot_PretextSnapshot

### Tool Description
an image generator for pretext contact maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/pretextsnapshot:0.0.5--h9948957_0
- **Homepage**: https://github.com/wtsi-hpag/PretextSnapshot
- **Package**: https://anaconda.org/channels/bioconda/packages/pretextsnapshot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pretextsnapshot/overview
- **Total Downloads**: 15.3K
- **Last updated**: 2025-06-04
- **GitHub**: https://github.com/wtsi-hpag/PretextSnapshot
- **Stars**: N/A
### Original Help Text
```text
PretextSnapshot, an image generator for pretext contact maps.

Nomenclature:
      Texel:    A single image unit of the underlying pretext map.
      Pixel:    A single image unit of the output image(s).

Usage:
      PretextSnapshot [Options]

Options:
         --help:                Print this help message.
                                Cannot be used with any other option.
         
         -m/--map mp:           Path to a pretext map.
                                This option is required, except when using:
                                 --help,
                                 --sequenceHelp,
			         --printColourMapNames,
			         --version,
			         --licence,
			         --thirdParty

	-f/--format fmt:        Image format, one of "png"(default) "bmp" or "jpeg".

	-r/--resolution res:	Image resolution, a positive integer, default 1080.
			        For non-square images this will be the resolution
                                of the longest dimension.

	-c/--colourMap cmap:	Either, a non-negative integer, indexing the colour map to use.
			        Or, the name of the colour map to use.
			        Defaults to "Three Wave Blue-Green-Yellow" i.e. "8".

	--printColourMapNames:	Prints a list of the available colour maps.
			        Cannot be used with any other option. 

	--jpegQuality qual:	JPEG quality factor, an integer between 1 and 100, default 80.
			        Larger values result in increased image quality and file size.
			        Only applicable to JPEG images.

	-o/--folder fldr:	Output folder path, will be created if it doesn't exist.
			        Defaults to the name of the pretext map.

	--prefix pfx:		Prefix name for all image files.
			        Defaults to the name of the pretext map + "_".

	--sequences sqncs:	Sequence specification string. Each entry, except for "=all", corresponds to one output image.
			        Defaults to "=full, =all".

	--sequenceHelp:		Sequence specification string format documentation.
			        Cannot be used with any other option.

	--minTexels txls:       Minimum map texels per image (along a single dimension), a positive integer, default 64.
			        Output images over too small a range that violate this minimum will not be created.

	--gridSize grdSz:	Width in pixels of the sequence separation grid, a non-negative integer, default 1.
			        Set to 0 to not overlay a grid.

	--gridColour col:	Colour of the sequence separation grid.
			        Either, one of: "black"(default), "white", "red", "green", "blue", "yellow", "cyan" or "magenta".
			        Or, a sRGBA 32-bit hex code in RRGGBBAA format, e.g. "ff00ff80" (magenta at half-occupancy).

	--printSequenceNames:	Prints a list of the individual sequence names in the map, in order of appearance.
			        Can only be used with the -m/--map option.

	--verbose vrbs:		Verbosity level, one of: "3"(default) for error, warning and status messages.
							 "2" for error and warning messages.
							 "1" for error messages.
							 "0" for no messages.
			        Warning and status messages are printed to stdout, error messages to stderr.

	--version:		Prints the software version.
			        Cannot be used with any other option.

	--licence:		Prints the software licence.
			        Cannot be used with any other option.

	--thirdParty:		Prints a list of the third-party libraries used, along with their respective licences.
			        Cannot be used with any other option.
```

