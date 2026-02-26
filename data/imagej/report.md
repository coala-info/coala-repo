# imagej CWL Generation Report

## imagej

### Tool Description
Image display and analysis program. Opens formats including:
UNC, Analyze, Dicom, NIFTI, Tiff, Jpeg, Gif, PNG ...

### Metadata
- **Docker Image**: biocontainers/imagej:v1.51idfsg-2-deb_cv1
- **Homepage**: https://github.com/imagej/imagej2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/imagej/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/imagej/imagej2
- **Stars**: N/A
### Original Help Text
```text
Display variable not set
If ImageJ fails to load, try 
% setenv DISPLAY yourcomputer:0
if you use the "csh" or for "bash" try
% export DISPLAY=yourcomputer:0

Image display and analysis program. Opens formats including:
UNC, Analyze, Dicom, NIFTI, Tiff, Jpeg, Gif, PNG ...

imagej [options] image [ image2 ... image3 ] -> open images

basic options:
  -h        print help and more options
  -o        open images in existing ImageJ panel if one exists
  -p <N>    open images in existing ImageJ panel number <N>
  -x <MB>   set available memory (default=4000 max=0)

advanced options:
  -c        enable plugin compilation within imagej
  -d        use development version
  -v        be verbose (vv or vvv increases verbosity)

options for batch processing:
  -e 'Macro Code'            execute macro code
  -r 'Menu Command'          run menu command
Quotation marks '' are required around commands including spaces
Commands can be sent to open ImageJ panels with the -p option

options for macros:
imagej [-i image] [-b|-m] [arg1 ... argN] 
  -b macro    run macro without graphics window
  -m macro    run macro
"image" will be opened before macro is run
all following arguments are passed to macro

Documentation - http://imagej.nih.gov/ij/ 
Report problems with this software to debian-med-packaging@lists.alioth.debian.org
```


## Metadata
- **Skill**: generated
