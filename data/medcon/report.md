# medcon CWL Generation Report

## medcon

### Tool Description
CLI Medical Image Conversion Utility

### Metadata
- **Docker Image**: biocontainers/medcon:v0.16.1dfsg-1-deb_cv1
- **Homepage**: https://github.com/nadavlab/MedConceptsQA
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/medcon/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/nadavlab/MedConceptsQA
- **Stars**: N/A
### Original Help Text
```text
CLI Medical Image Conversion Utility
(X)MedCon 0.16.1
Copyright (C) 1997-2018 by Erik Nolf

Try 'medcon --help' for more information.


Usage:

  medcon [options] -f <files> ...

Flags:

  -f, --file, --files  file or list of files to handle

General: [-i -e -r -w] [-p -pa|-c <format> ...] [-o <basename>]

  -e, --extract            extract images from file
  -i, --interactive        read raw files after user input
  -o, --output-name        output name set from command-line
  -p, --print-values       print values of specified pixels
  -pa, --print-all-values  print all values without asking
  -r, --rename-file        rename file after user input
  -w, --overwrite-files    always overwrite files

  -c, --convert            give list of conversion <format> strings:

		ascii = Raw Ascii     (.asc)
		bin   = Raw Binary    (.bin)
		acr   = Acr/Nema      (.ima)
		anlz  = Analyze       (.hdr)+(.img)
		conc  = Concorde/uPET (.img.hdr)
		dicom = DICOM         (.dcm)
		ecat6 = CTI ECAT 6    (.img)
		ecat7 = CTI ECAT 7    (.v)
		gif   = Gif89a        (.gif)
		intf  = InterFile     (.h33)+(.i33)
		inw   = INW (RUG)     (.im)
		nifti = NIfTI         (.nii)
		png   = PNG           (.png)

Pixels: [-n] [-nf] [-qs|-qc|-q] [-b8|-b16[.12]] [-big|little]
        [-si=<slope>:<intercept>] [-cw=<centre>:<width>]

  -n, --negatives           enable negative pixels
  -nf, --norm-over-frames   normalize values over each frames
  -q, --quantitation        quantitation using all factors (-qc)
  -qs, --quantification     quantification (use one scale factor )
  -qc, --calibration        calibration    (use two scale factors)
  -b8, --unsigned-char      write unsigned char pixels  (8  bits)
  -b16, --signed-short      write signed short integers (16 bits)
  -b16.12                   write unsigned shorts, only 12 bits used
  -big, --big-endian        write files in big    endian
  -little, --little-endian  write files in little endian
  -si                       force slope/intercept rescaling
  -cw                       force specified contrast remapping

Fallback Read Format: [-fb-none|-fb-anlz|-fb-conc|-fb-ecat|fb-dicom]

  -fb-none, --without-fallback  fallback disabled
  -fb-anlz, --fallback-analyze  fallback on Analyze (SPM)
  -fb-conc, --fallback-concorde fallback on Concorde uPET
  -fb-ecat, --fallback-ecat     fallback on ECAT 6.4
  -fb-dicom, --fallback-dicom   fallback on DICOM 3.0

Slices Transform: [-fh -fv] [-rs -cs -cu] [-sqr | -sqr2] [-crop=<X>:<Y>:<W>:<H>]
		[-pad | -padtl | -padbr]
  -fh, --flip-horizontal        flip images horizontally (along x-axis)
  -fv, --flip-vertical          flip images vertically   (along y-axis)
  -sqr, --make-square           make square images (largest dimension)
  -sqr2, --make-square-two      make square images (nearest power)
  -crop, --crop-images          crop image dimensions
  -rs, --reverse-slices         reverse slices sequence
  -cs, --cine-sorting           apply cine sorting
  -cu, --cine-undo              undo  cine sorting
  -pad, --pad-around            padding symmetrical around image
  -padtl, --pad-top-left        padding before first row and column
  -padbr, --pad-bottom-right    padding after last row and column (default)

Color Remap: [-24 | -8 [-g -dith -mh|-mr|-mi|-mc|-lut <file>]]

  -24, --true-color             color mode of 24 bits RGB triplets
  -8, --indexed-color           color mode of  8 bits indexed colormap
  -dith, --dither-color         apply dithering on color reduction

  -g, --make-gray               remap images to grayscale
  -mh, --map-hotmetal           load colormap hotmetal
  -mr, --map-rainbow            load colormap rainbow
  -mi, --map-inverted           load colormap gray inverted
  -mc, --map-combined           load colormap combined (gray/rainbow)
  -lut, --load-lut              load specified LUT colormap

Extras: [-alias -noprefix -preacq -preser -uin]
        [[-splits | -splitf] | [-stacks | -stackf]]

  -alias, --alias-naming        output name based  on patient/study id's
  -noprefix, --without-prefix   output name without default prefix
  -preacq, --prefix-acquisition use acquisition number as filename prefix
  -preser, --prefix-series      use series      number as filename prefix
  -uin, --use-institution-name  override default name of institution

  -split3d, --split-slices      split single image slices in separate files
  -split4d, --split-frames      split volume time frames  in separate files
  -stack3d, --stack-slices      stack single image slices into one 3D file
  -stack4d, --stack-frames      stack volume time  frames into one 4D file

Format Ecat/Matrix: [-byframe]

  -byframe, --sort-by-frame     sort ECAT images by frame (not anatomical)

Format Analyze: [-spm -optspm]

  -spm, --analyze-spm           use analyze format for SPM software

  -optspm, --options-spm        ask for SPM related options

Format DICOM:

 a) general: [-cw=<center>:<width>]
             [-contrast] [-gap] [-implicit] [-nometa]

  -contrast, --enable-contrast  enable support for contrast changes
  -gap, --spacing-true-gap      slice spacing is true gap or overlap
  -implicit, --write-implicit   output file as implicit little endian
  -nometa, --write-without-meta output file without (part 10) meta header
  -cw                           force window center/width contrast

 b) mosaic: [-mosaic | -fmosaic=<W>x<H>x<N> [-interl] [-mfixv]]

  -mosaic, --enable-mosaic      enable mosaic by "detected" stamps layout
  -fmosaic, --force-mosaic      force  mosaic by predefined stamps layout
  -mfixv, --mosaic-fix-voxel    rescale voxel sizes by mosaic factor
  -interl, --mosaic-interlaced  consider mosaic stamp slices as interlaced


Format Gif89a: [-optgif]

  -optgif, --options-gif        ask for GIF related options

Format InterFile: [-skip1 -nopath -one]

  -skip1, --skip-preview-slice  skip first preview slice
  -nopath, --ignore-path        ignore path in 'name of data file' key
  -one, --single-file           write header and image to same file


Patient/Slice/Study: [-anon|-ident] [-vifi]

  -anon, --anonymous            make patient/study anonymous
  -ident, --identify            ask for patient/study information
  -vifi, --edit-fileinfo        edit internal entries (images/slice/origent)

Reslicing: [-tra|-sag|-cor]

  -tra, --tranverse             reslice images transverse
  -sag, --sagittal              reslice images sagittal
  -cor, --coronal               reslice images coronal

Debug/Mode: [-d -v -db -hackacr -ean]

  -d, --debug                   give debug information (printout FI)
  -s, --silent                  force silent mode, suppress all messages
  -v, --verbose                 run in verbose mode
  -db, --database               print database info
  -ean, --echo-alias-name       echo alias name on screen

  -hackacr, --hack-acrtags      try to locate and interpret acr tags in file
```

