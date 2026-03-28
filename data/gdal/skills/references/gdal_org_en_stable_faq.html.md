[![Logo](_static/gdalicon.png)](index.html)

* [Download](download.html)
* [Programs](programs/index.html)
* [Raster drivers](drivers/raster/index.html)
* [Vector drivers](drivers/vector/index.html)
* [User](user/index.html)
* [API](api/index.html)
* [Tutorials](tutorials/index.html)
* [Development](development/index.html)
* [Community](community/index.html)
* [Sponsors](sponsors/index.html)
* [How to contribute?](contributing/index.html)
* FAQ
  + [What does GDAL stand for?](#what-does-gdal-stand-for)
  + [What is this OGR stuff?](#what-is-this-ogr-stuff)
  + [What does OGR stand for?](#what-does-ogr-stand-for)
  + [What does CPL stand for?](#what-does-cpl-stand-for)
  + [What does VSI stand for?](#what-does-vsi-stand-for)
  + [When was the GDAL project started?](#when-was-the-gdal-project-started)
  + [Is GDAL/OGR proprietary software?](#is-gdal-ogr-proprietary-software)
  + [What license does GDAL/OGR use?](#what-license-does-gdal-ogr-use)
  + [What operating systems does GDAL-OGR run on?](#what-operating-systems-does-gdal-ogr-run-on)
  + [Is there a graphical user interface to GDAL/OGR?](#is-there-a-graphical-user-interface-to-gdal-ogr)
    - [Software using GDAL](software_using_gdal.html)
  + [What compiler can I use to build GDAL/OGR?](#what-compiler-can-i-use-to-build-gdal-ogr)
  + [I have a question that's not answered here. Where can I get more information?](#i-have-a-question-that-s-not-answered-here-where-can-i-get-more-information)
  + [How do I add support for a new format?](#how-do-i-add-support-for-a-new-format)
  + [What about file formats for 3D models?](#what-about-file-formats-for-3d-models)
  + [Is GDAL thread-safe ?](#is-gdal-thread-safe)
  + [Does GDAL provide a Section 508 information?](#does-gdal-provide-a-section-508-information)
  + [How do I cite GDAL ?](#how-do-i-cite-gdal)
* [Glossary](glossary.html)
* [License](license.html)
* [Thanks](thanks.html)

[GDAL](index.html)

* [GDAL documentation](index.html)  »
* FAQ
* [Edit on GitHub](https://github.com/OSGeo/gdal/edit/master/doc/source/faq.rst)

[Next](software_using_gdal.html "Software using GDAL")
 [Previous](contributing/index.html "How to contribute?")

---

# FAQ[](#faq "Link to this heading")

Contents

* [FAQ](#faq)

  + [What does GDAL stand for?](#what-does-gdal-stand-for)
  + [What is this OGR stuff?](#what-is-this-ogr-stuff)
  + [What does OGR stand for?](#what-does-ogr-stand-for)
  + [What does CPL stand for?](#what-does-cpl-stand-for)
  + [What does VSI stand for?](#what-does-vsi-stand-for)
  + [When was the GDAL project started?](#when-was-the-gdal-project-started)
  + [Is GDAL/OGR proprietary software?](#is-gdal-ogr-proprietary-software)
  + [What license does GDAL/OGR use?](#what-license-does-gdal-ogr-use)
  + [What operating systems does GDAL-OGR run on?](#what-operating-systems-does-gdal-ogr-run-on)
  + [Is there a graphical user interface to GDAL/OGR?](#is-there-a-graphical-user-interface-to-gdal-ogr)
  + [What compiler can I use to build GDAL/OGR?](#what-compiler-can-i-use-to-build-gdal-ogr)
  + [I have a question that's not answered here. Where can I get more information?](#i-have-a-question-that-s-not-answered-here-where-can-i-get-more-information)
  + [How do I add support for a new format?](#how-do-i-add-support-for-a-new-format)
  + [What about file formats for 3D models?](#what-about-file-formats-for-3d-models)
  + [Is GDAL thread-safe ?](#is-gdal-thread-safe)
  + [Does GDAL provide a Section 508 information?](#does-gdal-provide-a-section-508-information)
  + [How do I cite GDAL ?](#how-do-i-cite-gdal)

## What does GDAL stand for?[](#what-does-gdal-stand-for "Link to this heading")

GDAL - Geospatial Data Abstraction Library

It is sometimes pronounced "goo-doll" (a bit like goo-gle), while others pronounce it "gee-doll," and others pronounce it "gee-dall."

[Listen](https://soundcloud.com/danabauer/how-do-you-pronounce-gdal#t=00:02:58) how Frank Warmerdam pronounces it and the history behind the acronym.

## What is this OGR stuff?[](#what-is-this-ogr-stuff "Link to this heading")

OGR used to be a separate vector IO library inspired by OpenGIS Simple Features which was separated from GDAL. With the GDAL 2.0 release, the GDAL and OGR components were integrated together.

## What does OGR stand for?[](#what-does-ogr-stand-for "Link to this heading")

OGR used to stand for OpenGIS Simple Features Reference Implementation. However, since OGR is not fully compliant with the OpenGIS Simple Feature specification and is not approved as a reference implementation of the spec the name was changed to OGR Simple Features Library. The only meaning of OGR in this name is historical. OGR is also the prefix used everywhere in the source of the library for class names, filenames, etc.

## What does CPL stand for?[](#what-does-cpl-stand-for "Link to this heading")

Common Portability Library. Think of it as GDAL internal cross-platform standard library. Back in the early days of GDAL development, when cross-platform development as well as compatibility and standard conformance of compilers was a challenge (or PITA), CPL proved necessary for smooth portability of GDAL/OGR.

CPL, or parts of it, is used by some projects external to GDAL (eg. MITAB, libgeotiff).

## What does VSI stand for?[](#what-does-vsi-stand-for "Link to this heading")

Virtual System Interface. This is the name of the input/output abstraction layer
that is implemented by different Virtual File Systems (VFS) to provide access
to regular files, in-memory files, network accessible files, compressed files, etc.

See [GDAL Virtual File Systems (compressed, network hosted, etc...): /vsimem, /vsizip, /vsitar, /vsicurl, ...](user/virtual_file_systems.html#virtual-file-systems) for a list of the available VFS.

The VSI functions retain exactly the same calling pattern as the original
Standard C functions they relate to, for the parts where they are common, and
also extend it to provide more specialized functionality.

## When was the GDAL project started?[](#when-was-the-gdal-project-started "Link to this heading")

In late 1998, Frank Warmerdam started to work as independent professional on the GDAL/OGR library.

## Is GDAL/OGR proprietary software?[](#is-gdal-ogr-proprietary-software "Link to this heading")

No, GDAL/OGR is a Free and Open Source Software.

## What license does GDAL/OGR use?[](#what-license-does-gdal-ogr-use "Link to this heading")

See [License](license.html#license)

## What operating systems does GDAL-OGR run on?[](#what-operating-systems-does-gdal-ogr-run-on "Link to this heading")

You can use GDAL/OGR on all modern flavors of Unix: Linux, FreeBSD, Mac OS X; all supported versions of Microsoft Windows; mobile environments (Android and iOS). Both 32-bit and 64-bit architectures are supported.

## Is there a graphical user interface to GDAL/OGR?[](#is-there-a-graphical-user-interface-to-gdal-ogr "Link to this heading")

Plenty! Among the available options, [QGIS](https://qgis.org) is an excellent
free and open source application with a rich graphical user interface. It
allows users to display most GDAL raster and vector supported formats and
provides access to most GDAL utilities through its Processing toolbox.

You can also consult the [list of software using GDAL](software_using_gdal.html#software-using-gdal).

## What compiler can I use to build GDAL/OGR?[](#what-compiler-can-i-use-to-build-gdal-ogr "Link to this heading")

GDAL/OGR must be compiled with a C++17 capable compiler since GDAL 3.9 (C++11 in previous versions)

Build requirements are described in [Build requirements](development/building_from_source.html#build-requirements).

## I have a question that's not answered here. Where can I get more information?[](#i-have-a-question-that-s-not-answered-here-where-can-i-get-more-information "Link to this heading")

See [Community](community/index.html#community)

Keep in mind, the quality of the answer you get does bear some relation to the quality of the question. If you need more detailed explanation of this, you can find it in essay [How To Ask Questions The Smart Way](http://www.catb.org/~esr/faqs/smart-questions.html) by Eric S. Raymond.

## How do I add support for a new format?[](#how-do-i-add-support-for-a-new-format "Link to this heading")

To some extent this is now covered by the [Raster driver implementation tutorial](tutorials/raster_driver_tut.html#raster-driver-tut) and [Vector driver implementation tutorial](tutorials/vector_driver_tut.html#vector-driver-tut)

## What about file formats for 3D models?[](#what-about-file-formats-for-3d-models "Link to this heading")

While some vector drivers in GDAL support 3D geometries (e.g. reading CityGML or
AIXM through the GML driver, or 3D geometries in GeoPackage), 3-dimensional scenes or
models formats (such as glTF, OBJ, 3DS, etc.) are out-of-scope for GDAL.
Users may consider a library such as [ASSIMP (Open-Asset-Importer-Library)](https://github.com/assimp/assimp)
for such formats.

## Is GDAL thread-safe ?[](#is-gdal-thread-safe "Link to this heading")

See [Multi-threading](user/multithreading.html#multithreading)

## Does GDAL provide a Section 508 information?[](#does-gdal-provide-a-section-508-information "Link to this heading")

No, GDAL itself is an open-source software and project, not a Vendor. If your organization considers they need a [VPAT or Section 508](https://www.section508.gov/sell/acr/) form to be able to use GDAL, it is their responsibility to complete the needed steps themselves.

## How do I cite GDAL ?[](#how-do-i-cite-gdal "Link to this heading")

See [CITATION](https://github.com/OSGeo/gdal/blob/master/CITATION)

[Next](software_using_gdal.html "Software using GDAL")
 [Previous](contributing/index.html "How to contribute?")

---

© 1998-2026 [Frank Warmerdam](https://github.com/warmerdam),
[Even Rouault](https://github.com/rouault), and
[others](https://github.com/OSGeo/gdal/graphs/contributors)