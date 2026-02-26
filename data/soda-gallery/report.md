# soda-gallery CWL Generation Report

## soda-gallery_soda

### Tool Description
Generate a gallery of genome browser tracks.

### Metadata
- **Docker Image**: quay.io/biocontainers/soda-gallery:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/alexpreynolds/soda
- **Package**: https://anaconda.org/channels/bioconda/packages/soda-gallery/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/soda-gallery/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alexpreynolds/soda
- **Stars**: N/A
### Original Help Text
```text
Usage: soda [options]

Options:
  -h, --help            show this help message and exit
  -r REGIONSFN, --regionsFn=REGIONSFN
                        Path to BED-formatted regions of interest (required)
  -s BROWSERSESSIONID, --browserSessionID=BROWSERSESSIONID
                        Genome browser session ID (required)
  -o OUTPUTDIR, --outputDir=OUTPUTDIR
                        Output gallery directory (required)
  -b BROWSERBUILDID, --browserBuildID=BROWSERBUILDID
                        Genome build ID (required)
  -t GALLERYTITLE, --galleryTitle=GALLERYTITLE
                        Gallery title (optional)
  -g BROWSERURL, --browserURL=BROWSERURL
                        Genome browser URL (optional)
  -u BROWSERUSERNAME, --browserUsername=BROWSERUSERNAME
                        Genome browser username (optional)
  -p BROWSERPASSWORD, --browserPassword=BROWSERPASSWORD
                        Genome browser password (optional)
  -y, --useKerberosAuthentication
                        Use Kerberos authentication (optional)
  -d, --addMidpointAnnotation
                        Add midpoint annotation underneath tracks (optional)
  -i, --addIntervalAnnotation
                        Add interval annotation underneath tracks (optional)
  -w ANNOTATIONRGBA, --annotationRgba=ANNOTATIONRGBA
                        Annotation 'rgba(r,g,b,a)' color string (optional)
  -z ANNOTATIONFONTPOINTSIZE, --annotationFontPointSize=ANNOTATIONFONTPOINTSIZE
                        Annotation font point size (optional)
  -f ANNOTATIONFONTFAMILY, --annotationFontFamily=ANNOTATIONFONTFAMILY
                        Annotation font family (optional)
  -e ANNOTATIONRESOLUTION, --annotationResolution=ANNOTATIONRESOLUTION
                        Annotation resolution, dpi (optional)
  -j OUTPUTPNGRESOLUTION, --outputPngResolution=OUTPUTPNGRESOLUTION
                        Output PNG resolution, dpi (optional)
  -a RANGEPADDING, --range=RANGEPADDING
                        Add or remove symmetrical padding to input regions
                        (optional)
  -l GALLERYSRCDIR, --gallerySrcDir=GALLERYSRCDIR
                        Gallery resources directory (optional)
  -c OCTICONSSRCDIR, --octiconsSrcDir=OCTICONSSRCDIR
                        Github Octicons resources directory (optional)
  -k CONVERTBINFN, --convertBinFn=CONVERTBINFN
                        ImageMagick convert binary path (optional)
  -n IDENTIFYBINFN, --identifyBinFn=IDENTIFYBINFN
                        ImageMagick identify binary path (optional)
  -m GALLERYMODE, --galleryMode=GALLERYMODE
                        Gallery mode: blueimp or photoswipe [default:
                        photoswipe]
  -v, --verbose         Print debug messages to stderr (optional)
```

