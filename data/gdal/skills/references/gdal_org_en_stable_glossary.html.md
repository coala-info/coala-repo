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
* [FAQ](faq.html)
* Glossary
  + [Credits and Acknowledgments](#credits-and-acknowledgments)
* [License](license.html)
* [Thanks](thanks.html)

[GDAL](index.html)

* [GDAL documentation](index.html)  »
* Glossary
* [Edit on GitHub](https://github.com/OSGeo/gdal/edit/master/doc/source/glossary.rst)

[Next](license.html "License")
 [Previous](software_using_gdal.html "Software using GDAL")

---

# Glossary[](#glossary "Link to this heading")

The GDAL glossary contains terms and acronyms found throughout the GDAL documentation

Affine Transformation[](#term-Affine-Transformation "Link to this term")
:   A geometric change that preserves points, straight lines, and ratios, including scaling, rotating, or translating.

API[](#term-API "Link to this term")
:   Application Programming Interface. A set of rules that lets different software programs communicate and share data or functions.

Arc[](#term-Arc "Link to this term")
:   A curved segment of a circle or other curve, often used in geographic data to represent smooth curved lines or boundaries between points.

Band[](#term-Band "Link to this term")
:   A single layer of data values within a raster dataset. In a single-band raster, each pixel contains one value - such as elevation in a [DEM](#term-DEM).
    A multi-band raster contains multiple such layers; for example, satellite imagery may include three bands representing Red, Green, and Blue channels.

Band Algebra[](#term-Band-Algebra "Link to this term")
:   A method for performing mathematical operations on one or more raster bands to produce a new output band or raster.
    Band algebra involves applying expressions - such as addition, subtraction, multiplication, division,
    or more complex functions—on pixel values across bands.

    See also

    [GDAL Band Algebra](user/band_algebra.html#gdal-band-algebra).

Block Cache[](#term-Block-Cache "Link to this term")
:   A memory cache that stores recently accessed blocks of data to reduce disk reads and improve performance.

Boolean[](#term-Boolean "Link to this term")
:   A data type representing one of two values: True or False, commonly used in logical operations and conditions.

Coordinate Epoch[](#term-Coordinate-Epoch "Link to this term")
:   The date tied to spatial coordinates in a dynamic reference frame, used to account for positional changes over time (e.g., due to tectonic motion).

Credentials[](#term-Credentials "Link to this term")
:   Information (such as a username and password or tokens) used to verify the identity of a user or system for authentication and access control.

CRS[](#term-CRS "Link to this term")
:   Coordinate Reference System. A system that maps spatial data coordinates to real-world locations,
    combining a coordinate system with a reference surface like a projection or [ellipsoid](#term-Ellipsoid).

curl[](#term-curl "Link to this term")
:   A command-line tool and library for transferring data with URLs, supporting protocols such as HTTP, HTTPS, FTP, and more.
    Commonly used for testing and interacting with web services.

DEM[](#term-DEM "Link to this term")
:   Digital Elevation Model. A raster representation of the height of the earth's surface.

Driver[](#term-Driver "Link to this term")
:   A software component that enables reading, writing, and processing of specific raster or vector data formats.

DTM[](#term-DTM "Link to this term")
:   Digital Terrain Model. A raster representation of the bare ground surface of the earth, excluding natural and man-made
    objects such as vegetation and buildings.

Ellipsoid[](#term-Ellipsoid "Link to this term")
:   A model used to approximate the Earth's shape in coordinate systems.

Environment Variable[](#term-Environment-Variable "Link to this term")
:   A variable in the operating system that can influence the behavior of running processes or applications.

    See also

    [Configuration options](user/configoptions.html#configoptions).

Escaped Character[](#term-Escaped-Character "Link to this term")
:   Refers to a character or sequence modified to prevent it from being interpreted as code or control instructions,
    allowing it to be treated as literal data.

Euclidean Distance[](#term-Euclidean-Distance "Link to this term")
:   A measure of the straight-line distance between two points in space.

EPSG[](#term-EPSG "Link to this term")
:   European Petroleum Survey Group. A group of geospatial experts for the petroleum industry (1986–2005),
    now part of IOGP (International Association of Oil & Gas Producers). Known for creating the EPSG Geodetic Parameter Dataset,
    a widely used database of coordinate systems and geodetic parameters.

File Handle[](#term-File-Handle "Link to this term")
:   An identifier used by an operating system to manage and access an open file during a program's execution.

GEOS[](#term-GEOS "Link to this term")
:   Geometry Engine - Open Source. GEOS is a C/C++ library for computational geometry with a focus on algorithms
    used in geographic information systems (GIS) software. GEOS started as a port of the Java Topology Suite (JTS).

    See also

    <https://libgeos.org/>

Gridding[](#term-Gridding "Link to this term")
:   The process of converting scattered or irregularly spaced data points into a regular, structured grid format.

    See also

    [GDAL Grid Tutorial](tutorials/gdal_grid_tut.html#gdal-grid-tut).

Georeference[](#term-Georeference "Link to this term")
:   Linking data to real-world geographic coordinates so a location can be accurately mapped.

Georeferencing[](#term-Georeferencing "Link to this term")
:   See [Georeference](#term-Georeference).

Geotransform[](#term-Geotransform "Link to this term")
:   A set of parameters that defines how to convert pixel locations in an image to real-world geographic coordinates.

    See also

    [Geotransform Tutorial](tutorials/geotransforms_tut.html#geotransforms-tut).

GNM[](#term-GNM "Link to this term")
:   Geographic Network Model. A GDAL abstraction for different existed network formats.

    See also

    [Geographic Networks Data Model](user/gnm_data_model.html#gnm-data-model).

Interpolation[](#term-Interpolation "Link to this term")
:   A mathematical and statistical technique used to estimate unknown values between known values.

    See also

    [GDAL Grid Tutorial](tutorials/gdal_grid_tut.html#gdal-grid-tut).

Hypsometric[](#term-Hypsometric "Link to this term")
:   The measurement and representation of land elevation (or terrain height) relative to sea level.

Library[](#term-Library "Link to this term")
:   A collection of software routines, functions, or classes that can be used by programs to perform specific tasks
    without having to write code from scratch. Libraries help developers reuse code and simplify software development.

Linestring[](#term-Linestring "Link to this term")
:   A geometric object consisting of a sequence of connected points forming a continuous line, commonly used to represent
    linear features such as roads or rivers in spatial data.

LRU Cache[](#term-LRU-Cache "Link to this term")
:   Least Recently Used Cache. A memory cache that stores a limited number of items, automatically discarding the
    least recently used entries to make space for new ones.

Moving Average[](#term-Moving-Average "Link to this term")
:   A method that smooths data by averaging values over a sliding window of data points.

    See also

    [GDAL Grid Tutorial](tutorials/gdal_grid_tut.html#gdal-grid-tut).

Multithreading[](#term-Multithreading "Link to this term")
:   A programming technique where multiple threads are executed concurrently within a single process,
    allowing parallel execution of tasks to improve performance and responsiveness.

Normalizing[](#term-Normalizing "Link to this term")
:   The process of adjusting data values to a common scale. In raster analysis, normalizing is commonly used to
    scale pixel values to a defined range (such as 0 to 1) to facilitate comparison and visualization.

Nearest Neighbor[](#term-Nearest-Neighbor "Link to this term")
:   A method that finds the closest data point(s) to a given point, often used for classification or estimation based on similarity.

OGC[](#term-OGC "Link to this term")
:   Open Geospatial Consortium. An international, non-profit organization that develops and promotes open standards
    for geospatial data and services.

    See also

    <https://www.ogc.org/>

OSR[](#term-OSR "Link to this term")
:   OGR Spatial Reference (OSR) - module that handles spatial reference systems and coordinate transformations.

    See also

    [OGR Coordinate Reference Systems and Coordinate Transformation tutorial](tutorials/osr_api_tut.html#osr-api-tut).

PAM[](#term-PAM "Link to this term")
:   Persistent Auxiliary Metadata. Metadata stored separately from the main raster data file,
    allowing additional information to persist without modifying the original file.

Raster[](#term-Raster "Link to this term")
:   A type of spatial data used with GIS, consisting of a regular grid of points spaced at a set distance (the resolution);
    often used to represent heights (DEM) or temperature data.

Raster Algebra[](#term-Raster-Algebra "Link to this term")
:   See [Band Algebra](#term-Band-Algebra).

Resampling[](#term-Resampling "Link to this term")
:   The process of changing the resolution or grid alignment of raster data by interpolating pixel values,
    used when scaling, reprojecting, or transforming images to maintain data quality.

RGB[](#term-RGB "Link to this term")
:   An acronym for Red, Green, and Blue - the three primary colors of light used in digital imaging.

Runtime[](#term-Runtime "Link to this term")
:   The period during which a program or process is actively executing. It refers to the time from the start of a program's execution to its termination.

Search Ellipse[](#term-Search-Ellipse "Link to this term")
:   [Search window](#term-Search-Window) in [gridding](#term-Gridding) algorithms specified in the form of rotated ellipse.

    See also

    [GDAL Grid Tutorial](tutorials/gdal_grid_tut.html#gdal-grid-tut).

Search Window[](#term-Search-Window "Link to this term")
:   A defined area within which data is analyzed or searched, often used in spatial analysis or image processing.

    See also

    [GDAL Grid Tutorial](tutorials/gdal_grid_tut.html#gdal-grid-tut).

Shell[](#term-Shell "Link to this term")
:   A command-line interface used to interact with an operating system by typing commands.

Side-car Files[](#term-Side-car-Files "Link to this term")
:   Auxiliary files stored alongside a primary data file that contain metadata or additional information without
    altering the original file.

SRS[](#term-SRS "Link to this term")
:   Spatial Reference System. A system that defines how spatial coordinates map to real-world locations.
    Often used interchangeably with [CRS](#term-CRS), though CRS is the more precise term in modern geospatial standards.

SSL[](#term-SSL "Link to this term")
:   Secure Sockets Layer. A security protocol that encrypts data transmitted over the Internet
    to ensure privacy and data integrity between a client and a server.

stdout[](#term-stdout "Link to this term")
:   Standard output stream used by programs to display output data, typically shown on the console or terminal.

Swath[](#term-Swath "Link to this term")
:   A contiguous block or strip of raster data processed or read at one time.

Thread[](#term-Thread "Link to this term")
:   A sequence of executable instructions within a program that can run independently, often used to perform tasks concurrently for better performance.

Topology[](#term-Topology "Link to this term")
:   The study and representation of spatial relationships between geometric features, such as adjacency, connectivity, and containment,
    ensuring data integrity in GIS by defining how points, lines, and polygons share boundaries and connect.

User-Agent[](#term-User-Agent "Link to this term")
:   A string sent by a web browser or client identifying itself to a web server, often including information
    about the software, version, and operating system.

UTF8[](#term-UTF8 "Link to this term")
:   A character encoding that represents text using one to four bytes per character, and capable of encoding all Unicode characters. Also
    referred to a UTF-8.

VRT[](#term-VRT "Link to this term")
:   Virtual Raster Tile: A lightweight XML-based GDAL format that references multiple rasters or vectors to create a
    virtual mosaic without duplicating data.

    See also

    [VRT -- GDAL Virtual Format](drivers/raster/vrt.html#raster-vrt) and [VRT -- OGR Virtual Format](drivers/vector/vrt.html#vector-vrt)

VSI[](#term-VSI "Link to this term")
:   Virtual System Interface. An interface for accessing files and datasets in non-filesystem locations, such as
    in-memory files, zip files, and over network protocols.

    See also

    [GDAL Virtual File Systems (compressed, network hosted, etc...): /vsimem, /vsizip, /vsitar, /vsicurl, ...](user/virtual_file_systems.html#virtual-file-systems).

Warping[](#term-Warping "Link to this term")
:   The process of geometrically transforming raster data to align with a different coordinate system, projection,
    or spatial reference, often involving [resampling](#term-Resampling) of pixel values.

    See also

    [gdalwarp](programs/gdalwarp.html#gdalwarp).

WFS[](#term-WFS "Link to this term")
:   Web Feature Service, an [OGC](#term-OGC) standard that allows users to access geospatial vector data over the web.

    See also

    [WFS - OGC WFS service](drivers/vector/wfs.html#vector-wfs)

WKT[](#term-WKT "Link to this term")
:   Well-Known Text. Text representation of geometries described in the Simple Features for SQL (SFSQL) specification.

WKT-CRS[](#term-WKT-CRS "Link to this term")
:   Well-Known Text for Coordinate Reference Systems. A text format that defines how to describe coordinate reference
    systems and transformations between them in a standardized way.
    See the [OGC WKT-CRS standard](https://www.ogc.org/standards/wkt-crs/).

WKB[](#term-WKB "Link to this term")
:   Well-Known Binary. Binary representation of geometries described in the Simple Features for SQL (SFSQL) specification.

WMS[](#term-WMS "Link to this term")
:   Web Map Service, an [OGC](#term-OGC) standard that allows users to request and display georeferenced map images over the web.

    See al