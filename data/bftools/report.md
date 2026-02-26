# bftools CWL Generation Report

## bftools_showinf

### Tool Description
To test read a file in any format, run:

### Metadata
- **Docker Image**: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
- **Homepage**: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bftools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bftools/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
To test read a file in any format, run:
  showinf file [-nopix] [-nocore] [-nometa] [-thumbs] [-minmax] 
    [-merge] [-nogroup] [-stitch] [-separate] [-expand] [-omexml]
    [-normalize] [-fast] [-debug] [-range start end] [-series num]
    [-resolution num] [-swap inputOrder] [-shuffle outputOrder]
    [-map id] [-preload] [-crop x,y,w,h] [-autoscale] [-novalid]
    [-omexml-only] [-no-sas] [-no-upgrade] [-noflat] [-format Format]
    [-cache] [-cache-dir dir] [-option key value] [-fill color]

    -version: print the library version and exit
        file: the image file to read
              if - is passed, process multiple files
              with file names read line-wise from stdin
      -nopix: read metadata only, not pixels
     -nocore: do not output core metadata
     -nometa: do not parse format-specific metadata table
   -nofilter: do not filter metadata fields
     -thumbs: read thumbnails instead of normal pixels
     -minmax: compute min/max statistics
      -merge: combine separate channels into RGB image
    -nogroup: force multi-file datasets to be read as individual files
     -stitch: stitch files with similar names
   -separate: split RGB image into separate channels
     -expand: expand indexed color to RGB
     -omexml: populate OME-XML metadata
  -normalize: normalize floating point images (*)
       -fast: paint RGB images as quickly as possible (*)
      -debug: turn on debugging output
      -range: specify range of planes to read (inclusive)
     -series: specify which image series to read
     -noflat: do not flatten subresolutions
 -resolution: used in combination with -noflat to specify which
              subresolution to read (for images with subresolutions)
       -swap: override the default input dimension order
    -shuffle: override the default output dimension order
        -map: specify file on disk to which name should be mapped
    -preload: pre-read entire file into a buffer; significantly
              reduces the time required to read the images, but
              requires more memory
       -crop: crop images before displaying; argument is 'x,y,w,h'
  -autoscale: automatically adjust brightness and contrast (*)
    -novalid: do not perform validation of OME-XML
-omexml-only: only output the generated OME-XML
     -no-sas: do not output OME-XML StructuredAnnotation elements
 -no-upgrade: do not perform the upgrade check
     -format: read file with a particular reader (e.g., ZeissZVI)
      -cache: cache the initialized reader
  -cache-dir: use the specified directory to store the cached
              initialized reader. If unspecified, the cached reader
              will be stored under the same folder as the image file
     -option: add the specified key/value pair to the reader's options list
       -fill: byte value to use for undefined pixels (0-255)

* = may result in loss of precision
```


## bftools_bfconvert

### Tool Description
To convert a file between formats, run:

### Metadata
- **Docker Image**: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
- **Homepage**: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bftools/overview
- **Validation**: PASS

### Original Help Text
```text
To convert a file between formats, run:
  bfconvert [-debug] [-stitch] [-separate] [-merge] [-expand]
    [-bigtiff] [-nobigtiff] [-compression codec] [-series series] [-noflat]
    [-cache] [-cache-dir dir] [-no-sas]
    [-map id] [-range start end] [-crop x,y,w,h]
    [-channel channel] [-z Z] [-timepoint timepoint] [-nogroup]
    [-nolookup] [-autoscale] [-version] [-no-upgrade] [-padded]
    [-option key value] [-novalid] [-validate] [-tilex tileSizeX]
    [-tiley tileSizeY] [-pyramid-scale scale]
    [-swap dimensionsOrderString] [-fill color]
    [-precompressed] [-quality compressionQuality]
    [-pyramid-resolutions numResolutionLevels] in_file out_file

            -version: print the library version and exit
         -no-upgrade: do not perform the upgrade check
              -debug: turn on debugging output
             -stitch: stitch input files with similar names
           -separate: split RGB images into separate channels
              -merge: combine separate channels into RGB image
             -expand: expand indexed color to RGB
            -bigtiff: force BigTIFF files to be written
          -nobigtiff: do not automatically switch to BigTIFF
        -compression: specify the codec to use when saving images
             -series: specify which image series to convert
             -noflat: do not flatten subresolutions
              -cache: cache the initialized reader
          -cache-dir: use the specified directory to store the cached
                      initialized reader. If unspecified, the cached reader
                      will be stored under the same folder as the image file
             -no-sas: do not preserve the OME-XML StructuredAnnotation elements
                -map: specify file on disk to which name should be mapped
              -range: specify range of planes to convert (inclusive)
            -nogroup: force multi-file datasets to be read as individual                      files
           -nolookup: disable the conversion of lookup tables
          -autoscale: automatically adjust brightness and contrast before
                      converting; this may mean that the original pixel
                      values are not preserved
          -overwrite: always overwrite the output file, if it already exists
        -nooverwrite: never overwrite the output file, if it already exists
               -crop: crop images before converting; argument is 'x,y,w,h'
            -channel: only convert the specified channel (indexed from 0)
                  -z: only convert the specified Z section (indexed from 0)
          -timepoint: only convert the specified timepoint (indexed from 0)
             -padded: filename indexes for series, z, c and t will be zero padded
             -option: add the specified key/value pair to the options list
            -novalid: will not validate the OME-XML for the output file
           -validate: will validate the generated OME-XML for the output file
              -tilex: image will be converted one tile at a time using the given tile width
              -tiley: image will be converted one tile at a time using the given tile height
      -pyramid-scale: generates a pyramid image with each subsequent resolution level divided by scale
-pyramid-resolutions: generates a pyramid image with the given number of resolution levels 
      -no-sequential: do not assume that planes are written in sequential order
               -swap: override the default input dimension order; argument is f.i. XYCTZ
               -fill: byte value to use for undefined pixels (0-255)
      -precompressed: transfer compressed bytes from input dataset directly to output.
                      Most input and output formats do not support this option.
                      Do not use -crop, -fill, or -autoscale, or pyramid generation options
                      with this option.
            -quality: double quality value for JPEG compression (0-1)

The extension of the output file specifies the file format to use
for the conversion. The list of available formats and extensions is:

 * Animated PNG: .png
 * Audio Video Interleave: .avi
 * CellH5 File Format: .ch5
 * DICOM: .dcm
 * Encapsulated PostScript: .eps, .epsi
 * Image Cytometry Standard: .ids, .ics
 * JPEG: .jpg, .jpeg, .jpe
 * JPEG-2000: .jp2
 * Java source code: .java
 * OME-TIFF: .ome.tif, .ome.tiff, .ome.tf2, .ome.tf8, .ome.btf
 * OME-XML: .ome, .ome.xml
 * QuickTime: .mov
 * Tagged Image File Format: .tif, .tiff, .tf2, .tf8, .btf
 * Vaa3d: .v3draw

Some file formats offer multiple compression schemes that can be set
using the -compression option. The list of available compressions is:

 * DICOM: Uncompressed, JPEG, JPEG-2000
 * JPEG-2000: JPEG-2000 Lossy, JPEG-2000
 * OME-TIFF: Uncompressed, LZW, JPEG-2000, JPEG-2000 Lossy, JPEG, zlib
 * OME-XML: Uncompressed, zlib
 * QuickTime: Uncompressed
 * Tagged Image File Format: Uncompressed, LZW, JPEG-2000, JPEG-2000 Lossy, JPEG, zlib

If any of the following patterns are present in out_file, they will
be replaced with the indicated metadata value from the input file.

   Pattern:	Metadata value:
   ---------------------------
   %s		series index
   %n		series name
   %c		channel index
   %w		channel name
   %z		Z index
   %t		T index
   %A		acquisition timestamp
   %x		row index of the tile
   %y		column index of the tile
   %m		overall tile index

If any of these patterns are present, then the images to be saved
will be split into multiple files.  For example, if the input file
contains 5 Z sections and 3 timepoints, and out_file is

  converted_Z%z_T%t.tiff

then 15 files will be created, with the names

  converted_Z0_T0.tiff
  converted_Z0_T1.tiff
  converted_Z0_T2.tiff
  converted_Z1_T0.tiff
  ...
  converted_Z4_T2.tiff

Each file would have a single image plane.
```


## bftools_tiffcomment

### Tool Description
This tool requires an ImageDescription tag to be present in the TIFF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
- **Homepage**: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bftools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
tiffcomment [-set comment] [-edit] file1 [file2 ...]

This tool requires an ImageDescription tag to be present in the TIFF file. 

If using the '-set' option, the new TIFF comment must be specified and may take any of the following forms:

  * the text of the comment, e.g. 'new comment!'
  * the name of the file containing the text of the comment, e.g. 'file.xml'
  * '-', to enter the comment using stdin.  Entering a blank line will
    terminate reading from stdin.
```


## bftools_xmlvalid

### Tool Description
Validates an XML file against a schema.

### Metadata
- **Docker Image**: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
- **Homepage**: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bftools/overview
- **Validation**: PASS

### Original Help Text
```text
Parsing schema path
Error parsing schema path from <stdin>
org.xml.sax.SAXParseException: Premature end of file.
	at org.apache.xerces.util.ErrorHandlerWrapper.createSAXParseException(Unknown Source)
	at org.apache.xerces.util.ErrorHandlerWrapper.fatalError(Unknown Source)
	at org.apache.xerces.impl.XMLErrorReporter.reportError(Unknown Source)
	at org.apache.xerces.impl.XMLErrorReporter.reportError(Unknown Source)
	at org.apache.xerces.impl.XMLErrorReporter.reportError(Unknown Source)
	at org.apache.xerces.impl.XMLVersionDetector.determineDocVersion(Unknown Source)
	at org.apache.xerces.parsers.XML11Configuration.parse(Unknown Source)
	at org.apache.xerces.parsers.XML11Configuration.parse(Unknown Source)
	at org.apache.xerces.parsers.XMLParser.parse(Unknown Source)
	at org.apache.xerces.parsers.AbstractSAXParser.parse(Unknown Source)
	at org.apache.xerces.jaxp.SAXParserImpl$JAXPSAXParser.parse(Unknown Source)
	at org.apache.xerces.jaxp.SAXParserImpl.parse(Unknown Source)
	at java.xml/javax.xml.parsers.SAXParser.parse(SAXParser.java:197)
	at loci.common.xml.XMLTools.validateXML(XMLTools.java:811)
	at loci.common.xml.XMLTools.validateXML(XMLTools.java:785)
	at loci.formats.tools.XMLValidate.validate(XMLValidate.java:67)
	at loci.formats.tools.XMLValidate.main(XMLValidate.java:120)
```


## bftools_formatlist

### Tool Description
List supported image formats

### Metadata
- **Docker Image**: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
- **Homepage**: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bftools/overview
- **Validation**: PASS

### Original Help Text
```text
unknown flag: --help; try -help for options

File pattern: can read (pattern)
Zip: can read (zip)
Animated PNG: can read, can write, can write multiple (png)
JPEG: can read, can write (jpg, jpeg, jpe)
SlideBook 7 SLD (native): can read (sldy)
Portable Any Map: can read (pbm, pgm, ppm)
Flexible Image Transport System: can read (fits, fts)
PCX: can read (pcx)
Graphics Interchange Format: can read (gif)
Windows Bitmap: can read (bmp)
IPLab: can read (ipl)
IVision: can read (ipm)
RCPNL: can read (rcpnl)
Deltavision: can read (dv, r3d, r3d_d3d, dv.log, r3d.log)
Medical Research Council: can read (mrc, st, ali, map, rec, mrcs)
Gatan Digital Micrograph: can read (dm3, dm4)
Gatan DM2: can read (dm2)
Bitplane Imaris: can read (ims)
Openlab RAW: can read (raw)
OME-XML: can read, can write, can write multiple (ome, ome.xml)
Leica Image File Format: can read (lif)
Audio Video Interleave: can read, can write, can write multiple (avi)
PICT: can read (pict, pct)
SPCImage Data: can read (sdt)
SPC FIFO Data: can read (spc, set)
Encapsulated PostScript: can read, can write (eps, epsi, ps)
Olympus Slidebook: can read (sld, spl)
Alicona AL3D: can read (al3d)
Multiple-image Network Graphics: can read (mng)
Khoros XV: can read (xv)
Visitech XYS: can read (xys, html)
Laboratory Imaging: can read (lim)
Adobe Photoshop: can read (psd)
InCell 1000/2000: can read (xdce, xml, tiff, tif, xlog)
Li-Cor L2D: can read (l2d, scn, tif)
FEI/Philips: can read (img)
Hamamatsu Aquacosmos: can read (naf)
MINC MRI: can read (mnc)
QuickTime: can read, can write, can write multiple (mov)
Minolta MRW: can read (mrw)
TillVision: can read (vws, pst, inf)
ARF: can read (arf)
Cellomics C01: can read (c01, dib)
LI-FLIM: can read (fli)
Truevision Targa: can read (tga)
Oxford Instruments: can read (top)
VG SAM: can read (dti)
Hamamatsu HIS: can read (his)
WA Technology TOP: can read (wat)
Seiko: can read (xqd, xqf)
TopoMetrix: can read (tfr, ffr, zfr, zfp, 2fl)
UBM: can read (pr3)
Quesant AFM: can read (afm)
Bio-Rad GEL: can read (1sc)
RHK Technologies: can read (sm2, sm3)
Molecular Imaging: can read (stp)
CellWorx: can read (pnl, htd, log)
MetaXpress TIFF: can read (htd, tif)
ECAT7: can read (v)
Varian FDF: can read (fdf)
AIM: can read (aim)
InCell 3000: can read (frm)
SPIDER: can read (spi)
Volocity Library: can read (mvd2, aisf, aiix, dat, atsf)
IMAGIC: can read (hed, img)
Hamamatsu VMS: can read (vms)
CellSens VSI: can read (vsi, ets)
INR: can read (inr)
Kodak Molecular Imaging: can read (bip)
Volocity Library Clipping: can read (acff)
Zeiss CZI: can read (czi)
Andor SIF: can read (sif)
Hamamatsu NDPIS: can read (ndpis)
POV-Ray: can read (df3)
IMOD: can read (mod)
Simulated data: can read (fake)
Aperio AFI: can read (afi)
Lavision Imspector: can read (msr)
Bio-Rad SCN: can read (scn)
Zeiss LMS: can read (lms)
PicoQuant Bin: can read (bin)
FlowSight: can read (cif)
Perkin-Elmer Nuance IM3: can read (im3)
I2I: can read (i2i)
Princeton Instruments SPE: can read (spe)
Olympus OIR: can read (oir)
KLB: can read (klb)
MicroCT: can read (vff)
Leica Object Format: can read (lof)
Extended leica file: can read (xlef)
Olympus .omp2info: can read (omp2info)
JEOL: can read (dat, img, par)
NIfTI: can read (nii, img, hdr, nii.gz)
Analyze 7.5: can read (img, hdr)
Olympus APL: can read (apl, tnb, mtb, tif)
NRRD: can read (nrrd, nhdr)
Image Cytometry Standard: can read, can write, can write multiple (ics, ids)
PerkinElmer: can read (ano, cfg, csv, htm, rec, tim, zpo, tif)
Amira: can read (am, amiramesh, grey, hx, labels)
Olympus ScanR: can read (dat, xml, tif)
BD Pathway: can read (exp, tif)
Unisoku STM: can read (hdr, dat)
Perkin Elmer Densitometer: can read (hdr, img)
Fuji LAS 3000: can read (img, inf)
PerkinElmer Operetta: can read (tif, tiff, xml)
Inveon: can read (hdr)
CellVoyager: can read (tif, xml)
PerkinElmer Columbus: can read (xml)
Yokogawa CV7000: can read (wpi)
Bio-Rad PIC: can read (pic, xml, raw)
Olympus FV1000: can read (oib, oif, pty, lut)
Zeiss Vision Image (ZVI): can read (zvi)
Image-Pro Workspace: can read (ipw)
JPEG-2000: can read, can write (jp2, j2k, jpf)
JPX: can read (jpx)
Nikon ND2: can read (nd2, jp2)
Compix Simple-PCI: can read (cxd)
Bitplane Imaris 5.5 (HDF): can read (ims)
CellH5 (HDF): can read (ch5)
Veeco: can read (hdf)
Tecan Spark Cyto: can read (db)
Zeiss Laser-Scanning Microscopy: can read (lsm, mdb)
Image-Pro Sequence: can read (seq, ips)
Amersham Biosciences GEL: can read (gel)
Bitplane Imaris 3 (TIFF): can read (ims)
Evotec Flex: can read (flex, mea, res)
Aperio SVS: can read (svs)
Imacon: can read (fff)
LEO: can read (sxm, tif, tiff)
JPK Instruments: can read (jpk)
Hamamatsu NDPI: can read (ndpi)
PCO-RAW: can read (pcoraw, rec)
Ventana .bif: can read (bif)
OME-TIFF: can read, can write, can write multiple (ome.tiff, ome.tif, ome.tf2, ome.tf8, ome.btf, companion.ome)
Pyramid TIFF: can read (tif, tiff)
MIAS: can read (tif, tiff, txt)
Leica TCS TIFF: can read (tif, tiff, xml)
Leica: can read (lei, tif, tiff, raw)
Nikon NEF: can read (nef, tif, tiff)
Olympus Fluoview/ABD TIFF: can read (tif, tiff)
Prairie TIFF: can read (tif, tiff, cfg, env, xml)
Metamorph STK: can read (stk, nd, scan, tif, tiff)
Micro-Manager: can read (tif, tiff, txt, xml)
Improvision TIFF: can read (tif, tiff)
Metamorph TIFF: can read (tif, tiff)
Nikon TIFF: can read (tif, tiff)
Mikroscan TIFF: can read (tif, tiff)
Adobe Photoshop TIFF: can read (tif, tiff)
FEI TIFF: can read (tif, tiff)
SimplePCI TIFF: can read (tif, tiff)
Nikon Elements TIFF: can read (tif, tiff)
Trestle: can read (tif)
Olympus SIS TIFF: can read (tif, tiff)
DNG: can read (cr2, crw, jpg, thm, wav, tif, tiff)
Zeiss AxioVision TIFF: can read (tif, xml)
Leica SCN: can read (scn)
PerkinElmer Vectra/QPTIFF: can read (tiff, tif, qptiff)
Slidebook TIFF: can read (tif, tiff)
Ionpath MIBI: can read (tif, tiff)
DICOM: can read, can write, can write multiple (dic, dcm, dicom, jp2, j2ki, j2kr, raw, ima)
Hitachi: can read (txt)
Tagged Image File Format: can read, can write, can write multiple (tif, tiff, tf2, tf8, btf)
Text: can read (txt, csv)
Burleigh: can read (img)
Openlab LIFF: can read (liff)
SM Camera: can read ()
SBIG: can read ()
NOAA-HRD Gridded Data Format: can read ()
Bruker: can read ()
Canon RAW: can read (cr2, crw, jpg, thm, wav)
OBF: can read (obf, msr)
BDV: can read (xml, h5)
```


## bftools_domainlist

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
- **Homepage**: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bftools/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Astronomy:
  Flexible Image Transport System
  OME-TIFF
  OME-XML
  SBIG
Electron Microscopy (EM):
  Gatan Digital Micrograph
  IMAGIC
  LEO
  OME-TIFF
  OME-XML
  Perkin Elmer Densitometer
  Pyramid TIFF
  SPIDER
Fluorescence-Lifetime Imaging:
  Image Cytometry Standard
  LI-FLIM
  Lavision Imspector
  OME-TIFF
  OME-XML
  PicoQuant Bin
  SPC FIFO Data
  SPCImage Data
Gel/Blot Imaging:
  Amersham Biosciences GEL
  Bio-Rad GEL
  Bio-Rad SCN
  Fuji LAS 3000
  Kodak Molecular Imaging
  Li-Cor L2D
  OME-TIFF
  OME-XML
Graphics:
  Adobe Photoshop
  Adobe Photoshop TIFF
  Animated PNG
  Audio Video Interleave
  Canon RAW
  DNG
  Encapsulated PostScript
  Graphics Interchange Format
  Imacon
  JPEG
  JPEG-2000
  JPX
  Khoros XV
  Minolta MRW
  Multiple-image Network Graphics
  Nikon NEF
  PCX
  PICT
  POV-Ray
  Portable Any Map
  QuickTime
  Truevision Targa
  Windows Bitmap
High-Content Screening (HCS):
  BD Pathway
  CellVoyager
  CellWorx
  Cellomics C01
  Evotec Flex
  InCell 1000/2000
  MIAS
  Metamorph STK
  Metamorph TIFF
  OME-TIFF
  OME-XML
  Olympus ScanR
  PerkinElmer Columbus
  PerkinElmer Operetta
  Tecan Spark Cyto
  Yokogawa CV7000
Histology:
  Aperio AFI
  Aperio SVS
  CellSens VSI
  CellVoyager
  Hamamatsu NDPI
  Hamamatsu NDPIS
  Hamamatsu VMS
  Leica SCN
  Mikroscan TIFF
  OME-TIFF
  OME-XML
  PerkinElmer Vectra/QPTIFF
  Trestle
  Ventana .bif
  Zeiss CZI
Light Microscopy:
  Andor SIF
  Bio-Rad PIC
  CellVoyager
  Cellomics C01
  Compix Simple-PCI
  Deltavision
  Hamamatsu Aquacosmos
  I2I
  Image Cytometry Standard
  Laboratory Imaging
  Leica
  Leica Image File Format
  Leica Object Format
  Leica TCS TIFF
  Medical Research Council
  Metamorph STK
  Metamorph TIFF
  Micro-Manager
  Mikroscan TIFF
  Nikon Elements TIFF
  Nikon ND2
  Nikon TIFF
  OME-TIFF
  OME-XML
  Olympus .omp2info
  Olympus APL
  Olympus FV1000
  Olympus Fluoview/ABD TIFF
  Olympus OIR
  Olympus Slidebook
  PerkinElmer
  PerkinElmer Vectra/QPTIFF
  Prairie TIFF
  RCPNL
  SimplePCI TIFF
  SlideBook 7 SLD (native)
  Slidebook TIFF
  TillVision
  Visitech XYS
  Zeiss AxioVision TIFF
  Zeiss CZI
  Zeiss LMS
  Zeiss Laser-Scanning Microscopy
  Zeiss Vision Image (ZVI)
Medical Imaging:
  Analyze 7.5
  Bruker
  DICOM
  ECAT7
  Inveon
  MINC MRI
  Medical Research Council
  MicroCT
  NIfTI
  OME-TIFF
  OME-XML
  Varian FDF
Scanning Electron Microscopy (SEM):
  Alicona AL3D
  Burleigh
  FEI TIFF
  FEI/Philips
  Hamamatsu HIS
  Hitachi
  JEOL
  JPK Instruments
  Molecular Imaging
  OME-TIFF
  OME-XML
  Quesant AFM
  SM Camera
  Seiko
  TopoMetrix
  UBM
  Veeco
  WA Technology TOP
Scanning Probe Microscopy (SPM):
  Gatan DM2
  OME-TIFF
  OME-XML
  Oxford Instruments
  RHK Technologies
  Unisoku STM
  VG SAM
Unknown:
  AIM
  ARF
  Amira
  BDV
  Bitplane Imaris
  Bitplane Imaris 3 (TIFF)
  Bitplane Imaris 5.5 (HDF)
  CellH5 (HDF)
  Flexible Image Transport System
  IMOD
  INR
  IPLab
  IVision
  Image Cytometry Standard
  Image-Pro Sequence
  Image-Pro Workspace
  Improvision TIFF
  InCell 3000
  Ionpath MIBI
  KLB
  NIfTI
  NOAA-HRD Gridded Data Format
  NRRD
  OME-TIFF
  OME-XML
  Olympus SIS TIFF
  Openlab LIFF
  Openlab RAW
  PCO-RAW
  Volocity Library
  Volocity Library Clipping
```

