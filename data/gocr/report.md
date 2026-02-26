# gocr CWL Generation Report

## gocr

### Tool Description
Optical Character Recognition

### Metadata
- **Docker Image**: quay.io/biocontainers/gocr:0.52--h7b50bb2_0
- **Homepage**: https://jocr.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/gocr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gocr/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-08-04
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Optical Character Recognition --- gocr 0.52 20181015
 Copyright (C) 2001-2018 Joerg Schulenburg  GPG=1024D/53BDFBE3
 released under the GNU General Public License
 using: gocr [options] pnm_file_name  # use - for stdin
 options (see gocr manual pages for more details):
 -h, --help, -V --version
 -i name   - input image file (pnm,pgm,pbm,ppm,pcx,...)
 -o name   - output file  (redirection of stdout)
 -e name   - logging file (redirection of stderr)
 -x name   - progress output to fifo (see manual)
 -p name   - database path including final slash (default is ./db/)
 -f fmt    - output format (ISO8859_1 TeX HTML XML UTF8 ASCII)
 -l num    - threshold grey level 0<160<=255 (0 = autodetect)
 -d num    - dust_size (remove small clusters, -1 = autodetect)
 -s num    - spacewidth/dots (0 = autodetect)
 -v num    - verbose (see manual page)
 -c string - list of chars (debugging, see manual)
 -C string - char filter (ex. hexdigits: 0-9A-Fx, only ASCII)
 -m num    - operation modes (bitpattern, see manual)
 -a num    - value of certainty (in percent, 0..100, default=95)
 -u string - output this string for every unrecognized character
 examples:
	gocr -m 4 text1.pbm                   # do layout analyzis
	gocr -m 130 -p ./database/ text1.pbm  # extend database
	djpeg -pnm -gray text.jpg | gocr -    # use jpeg-file via pipe

 website: http://www-e.uni-magdeburg.de/jschulen/ocr/
```

