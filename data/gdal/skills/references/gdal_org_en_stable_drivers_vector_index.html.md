[![Logo](../../_static/gdalicon.png)](../../index.html)

* [Download](../../download.html)
* [Programs](../../programs/index.html)
* [Raster drivers](../raster/index.html)
* Vector drivers
  + [ADBC -- Arrow Database Connectivity](adbc.html)
  + [ADBC BigQuery -- Google BigQuery through Arrow Database Connectivity](adbc_bigquery.html)
  + [Artificial intelligence powered vector driver](aivector.html)
  + [AmigoCloud](amigocloud.html)
  + [(Geo)Arrow IPC File Format / Stream](arrow.html)
  + [Arc/Info Binary Coverage](avcbin.html)
  + [Arc/Info E00 (ASCII) Coverage](avce00.html)
  + [CAD -- AutoCAD DWG](cad.html)
  + [Carto](carto.html)
  + [Comma Separated Value (.csv)](csv.html)
  + [CSW - OGC CSW (Catalog Service for the Web)](csw.html)
  + [Microstation DGN](dgn.html)
  + [Microstation DGN v8](dgnv8.html)
  + [AutoCAD DWG](dwg.html)
  + [AutoCAD DXF](dxf.html)
  + [Google Earth Engine Data API](eeda.html)
  + [EDIGEO](edigeo.html)
  + [Elasticsearch: Geographically Encoded Objects for Elasticsearch](elasticsearch.html)
  + [ESRIJSON / FeatureService driver](esrijson.html)
  + [ESRI File Geodatabase (FileGDB)](filegdb.html)
  + [FlatGeobuf](flatgeobuf.html)
  + [GDALG: GDAL Streamed Algorithm](gdalg.html)
  + [GeoJSON](geojson.html)
  + [GeoJSONSeq: sequence of GeoJSON features](geojsonseq.html)
  + [GeoRSS : Geographically Encoded Objects for RSS feeds](georss.html)
  + [GML - Geography Markup Language](gml.html)
  + [GMLAS - Geography Markup Language (GML) driven by application schemas](gmlas.html)
  + [GMT ASCII Vectors (.gmt)](gmt.html)
  + [GPKG -- GeoPackage vector](gpkg.html)
  + [GPSBabel](gpsbabel.html)
  + [GPX - GPS Exchange Format](gpx.html)
  + [GRASS Vector Format](grass.html)
  + [GTFS - General Transit Feed Specification](gtfs.html)
  + [SAP HANA](hana.html)
  + [IDB](idb.html)
  + [Idrisi Vector (.VCT)](idrisi.html)
  + ["INTERLIS 1" and "INTERLIS 2" drivers](ili.html)
  + [JML: OpenJUMP JML format](jml.html)
  + [JSONFG -- OGC Features and Geometries JSON](jsonfg.html)
  + [KML - Keyhole Markup Language](kml.html)
  + [LIBKML Driver (.kml .kmz)](libkml.html)
  + [Dutch Kadaster LV BAG 2.0 Extract](lvbag.html)
  + [MapML](mapml.html)
  + [MEM -- In Memory datasets](mem.html)
  + [Memory (deprecated)](memory.html)
  + [MiraMon Vector](miramon.html)
  + [MapInfo TAB and MIF/MID](mitab.html)
  + [MongoDBv3](mongodbv3.html)
  + [MSSQLSpatial - Microsoft SQL Server Spatial Database](mssqlspatial.html)
  + [MVT: Mapbox Vector Tiles](mvt.html)
  + [MySQL](mysql.html)
  + [NAS - ALKIS](nas.html)
  + [NetCDF: Network Common Data Form - Vector](netcdf.html)
  + [NGW -- NextGIS Web](ngw.html)
  + [OGC API - Features](oapif.html)
  + [Oracle Spatial](oci.html)
  + [ODBC RDBMS](odbc.html)
  + [ODS - Open Document Spreadsheet](ods.html)
  + [ESRI File Geodatabase vector (OpenFileGDB)](openfilegdb.html)
  + [OSM - OpenStreetMap XML and PBF](osm.html)
  + [(Geo)Parquet](parquet.html)
  + [PDF -- Geospatial PDF](pdf.html)
  + [PDS - Planetary Data Systems TABLE](pds.html)
  + [PostgreSQL SQL Dump](pgdump.html)
  + [ESRI Personal GeoDatabase](pgeo.html)
  + [PostgreSQL / PostGIS](pg.html)
  + [PLScenes (Planet Labs Scenes/Catalog API)](plscenes.html)
  + [PMTiles](pmtiles.html)
  + [IHO S-57 (ENC)](s57.html)
  + [Selafin files](selafin.html)
  + [ESRI Shapefile / DBF](shapefile.html)
  + [Norwegian SOSI Standard](sosi.html)
  + [SQLite / Spatialite RDBMS](sqlite.html)
  + [Storage and eXchange Format - SXF](sxf.html)
  + [TileDB -- TileDB vector](tiledb.html)
  + [TopoJSON driver](topojson.html)
  + [VDV - VDV-451/VDV-452/INTREST Data Format](vdv.html)
  + [VFK - Czech Cadastral Exchange Data Format](vfk.html)
  + [VRT -- OGR Virtual Format](vrt.html)
  + [WAsP - WAsP .map format](wasp.html)
  + [WFS - OGC WFS service](wfs.html)
  + [XLS - MS Excel format](xls.html)
  + [XLSX - MS Office Open XML spreadsheet](xlsx.html)
  + [XODR -- OpenDRIVE Road Description Format](xodr.html)
* [User](../../user/index.html)
* [API](../../api/index.html)
* [Tutorials](../../tutorials/index.html)
* [Development](../../development/index.html)
* [Community](../../community/index.html)
* [Sponsors](../../sponsors/index.html)
* [How to contribute?](../../contributing/index.html)
* [FAQ](../../faq.html)
* [Glossary](../../glossary.html)
* [License](../../license.html)
* [Thanks](../../thanks.html)

[GDAL](../../index.html)

* [GDAL documentation](../../index.html)  »
* Vector drivers
* [Edit on GitHub](https://github.com/OSGeo/gdal/edit/master/doc/source/drivers/vector/index.rst)

[Next](adbc.html "ADBC -- Arrow Database Connectivity")
 [Previous](../raster/zmap.html "ZMap -- ZMap Plus Grid")

---

# Vector drivers[](#vector-drivers "Link to this heading")

| Short Name | Long Name | Creation | Georeferencing | Build Requirements |
| --- | --- | --- | --- | --- |
| [ADBC](adbc.html) | Arrow Database Connectivity | No | No | adbc-driver-manager |
| [AIVector](aivector.html) | Artificial intelligence powered vector driver | No | No | Built-in by default |
| [AmigoCloud](amigocloud.html) | AmigoCloud | **Yes** | **Yes** | libcurl |
| [Arrow](arrow.html) | (Geo)Arrow IPC File Format / Stream | **Yes** | **Yes** | Apache Arrow C++ library |
| [AVCBIN](avcbin.html) | Arc/Info Binary Coverage | No | **Yes** | Built-in by default |
| [AVCE00](avce00.html) | Arc/Info E00 (ASCII) Coverage | No | **Yes** | Built-in by default |
| [CAD](cad.html) | AutoCAD DWG | No | **Yes** | (internal libopencad provided) |
| [CARTO](carto.html) | Carto | **Yes** | **Yes** | libcurl |
| [CSV](csv.html) | Comma Separated Value (.csv) | **Yes** | **Yes** | Built-in by default |
| [CSW](csw.html) | OGC CSW (Catalog Service for the Web) | No | **Yes** | libcurl |
| [DGN](dgn.html) | Microstation DGN | **Yes** | **Yes** | Built-in by default |
| [DGNv8](dgnv8.html) | Microstation DGN v8 | **Yes** | **Yes** | Open Design Alliance Teigha library |
| [DWG](dwg.html) | AutoCAD DWG | No | No | Open Design Alliance Teigha library |
| [DXF](dxf.html) | AutoCAD DXF | **Yes** | No | Built-in by default |
| [EDIGEO](edigeo.html) | EDIGEO | No | **Yes** | Built-in by default |
| [EEDA](eeda.html) | Google Earth Engine Data API | No | **Yes** | libcurl |
| [Elasticsearch](elasticsearch.html) | Elasticsearch: Geographically Encoded Objects for Elasticsearch | **Yes** | **Yes** | libcurl |
| [ESRI Shapefile](shapefile.html) | ESRI Shapefile / DBF | **Yes** | **Yes** | Built-in by default |
| [ESRIJSON](esrijson.html) | ESRIJSON / FeatureService driver | No | **Yes** | Built-in by default |
| [FileGDB](filegdb.html) | ESRI File Geodatabase (FileGDB) | **Yes** | **Yes** | FileGDB API library |
| [FlatGeobuf](flatgeobuf.html) | FlatGeobuf | **Yes** | **Yes** | Built-in by default |
| [GDALG](gdalg.html) | GDALG: GDAL Streamed Algorithm | No | **Yes** | Built-in by default |
| [GeoJSON](geojson.html) | GeoJSON | **Yes** | **Yes** | Built-in by default |
| [GeoJSONSeq](geojsonseq.html) | GeoJSONSeq: sequence of GeoJSON features | **Yes** | **Yes** | Built-in by default |
| [GeoRSS](georss.html) | GeoRSS : Geographically Encoded Objects for RSS feeds | **Yes** | **Yes** | (read support needs libexpat) |
| [GML](gml.html) | Geography Markup Language | **Yes** | **Yes** | (read support needs Xerces or libexpat) |
| [GMLAS](gmlas.html) | Geography Markup Language (GML) driven by application schemas | No | **Yes** | Xerces |
| [GMT](gmt.html) | GMT ASCII Vectors (.gmt) | **Yes** | **Yes** | Built-in by default |
| [GPKG](gpkg.html) | GeoPackage vector | **Yes** | **Yes** | libsqlite3 |
| [GPSBabel](gpsbabel.html) | GPSBabel | **Yes** | **Yes** | (read support needs GPX driver and libexpat) |
| [GPX](gpx.html) | GPS Exchange Format | **Yes** | **Yes** | (read support needs libexpat) |
| [GRASS](grass.html) | GRASS Vector Format | No | No | gdal-grass-driver |
| [GTFS](gtfs.html) | General Transit Feed Specification | No | No | Built-in by default |
| [HANA](hana.html) | SAP HANA | **Yes** | **Yes** | odbc-cpp-wrapper |
| [IDB](idb.html) | IDB | **Yes** | **Yes** | Informix DataBlade |
| [IDRISI](idrisi.html) | Idrisi Vector (.VCT) | No | **Yes** | Built-in by default |
| [INTERLIS 1](ili.html) | "INTERLIS 1" and "INTERLIS 2" drivers | No | **Yes** | Xerces |
| [JML](jml.html) | JML: OpenJUMP JML format | **Yes** | **Yes** | (read support needs libexpat) |
| [JSONFG](jsonfg.html) | OGC Features and Geometries JSON | **Yes** | **Yes** | Built-in by default |
| [KML](kml.html) | Keyhole Markup Language | **Yes** | **Yes** | (read support needs libexpat) |
| [LIBKML](libkml.html) | LIBKML Driver (.kml .kmz) | **Yes** | **Yes** | libkml |
| [LVBAG](lvbag.html) | Dutch Kadaster LV BAG 2.0 Extract | No | No | libexpat |
| [MapInfo File](mitab.html) | MapInfo TAB and MIF/MID | **Yes** | **Yes** | Built-in by default |
| [MapML](mapml.html) | MapML | **Yes** | **Yes** | Built-in by default |
| [MEM](mem.html) | In Memory datasets | **Yes** | **Yes** | Built-in by default |
| [Memory](memory.html) | Memory (deprecated) | No | No | Built-in by default |
| [MiraMonVector](miramon.html) | MiraMon Vector | **Yes** | **Yes** | Built-in by default |
| [MongoDBv3](mongodbv3.html) | MongoDBv3 | No | **Yes** | Mongo CXX >= 3.4.0 client library |
| [MSSQLSpatial](mssqlspatial.html) | Microsoft SQL Server Spatial Database | **Yes** | **Yes** | ODBC library |
| [MVT](mvt.html) | MVT: Mapbox Vector Tiles | **Yes** | **Yes** | (requires SQLite and GEOS for write support) |
| [MySQL](mysql.html) | MySQL | **Yes** | **Yes** | MySQL library |
| [NAS](nas.html) | ALKIS | No | **Yes** | Xerces |
| [netCDF](netcdf.html) | NetCDF: Network Common Data Form - Vector | **Yes** | **Yes** | libnetcdf |
| [NGW](ngw.html) | NextGIS Web | No | **Yes** | libcurl |
| [OAPIF](oapif.html) | OGC API - Features | No | **Yes** | libcurl |
| [OCI](oci.html) | Oracle Spatial | **Yes** | **Yes** | OCI library |
| [ODBC](odbc.html) | ODBC RDBMS | No | **Yes** | ODBC library |
| [ODS](ods.html) | Open Document Spreadsheet | **Yes** | No | libexpat |
| [OpenFileGDB](openfilegdb.html) | ESRI File Geodatabase vector (OpenFileGDB) | **Yes** | **Yes** | Built-in by default |
| [OSM](osm.html) | OpenStreetMap XML and PBF | No | **Yes** | libsqlite3 (and libexpat for OSM XML) |
| [Parquet](parquet.html) | (Geo)Parquet | **Yes** | **Yes** | Parquet component of the Apache Arrow C++ library |
| [PDF](pdf.html) | Geospatial PDF | **Yes** | **Yes** | none for write support, Poppler/PoDoFo/PDFium for read support |
| [PDS](pds.html) | Planetary Data Systems TABLE | No | No | Built-in by default |
| [PGDump](pgdump.html) | PostgreSQL SQL Dump | **Yes** | **Yes** | Built-in by default |
| [PGeo](pgeo.html) | ESRI Personal GeoDatabase | No | **Yes** | ODBC library |
| [PLScenes](plscenes.html) | PLScenes (Planet Labs Scenes/Catalog API) | No | No | libcurl |
| [PMTiles](pmtiles.html) | PMTiles | **Yes** | **Yes** | Built-in by default |
| [PostgreSQL](pg.html) | PostgreSQL / PostGIS | **Yes** | **Yes** | PostgreSQL client library (libpq) |
| [S57](s57.html) | IHO S-57 (ENC) | **Yes** | **Yes** | Built-in by default |
| [Selafin](selafin.html) | Selafin files | **Yes** | **Yes** | Built-in by default |
| [SOSI](sosi.html) | Norwegian SOSI Standard | No | No | FYBA library |
| [SQLite](sqlite.html) | SQLite / Spatialite RDBMS | **Yes** | **Yes** | libsqlite3 or libspatialite |
| [SXF](sxf.html) | SXF | No | **Yes** | Built-in by default |
| [TileDB](tiledb.html) | TileDB vector | **Yes** | No | TileDB >= 2.7 |
| [TopoJSON](topojson.html) | TopoJSON driver | No | **Yes** | Built-in by default |
| [VDV](vdv.html) | VDV-451/VDV-452/INTREST Data Format | **Yes** | **Yes** | Built-in by default |
| [VFK](vfk.html) | Czech Cadastral Exchange Data Format | No | **Yes** | libsqlite3 |
| [VRT](vrt.html) | OGR Virtual Format | No | **Yes** | Built-in by default |
| [WAsP](wasp.html) | WAsP .map format | **Yes** | **Yes** | Built-in by default |
| [WFS](wfs.html) | OGC WFS service | No | **Yes** | libcurl |
| [XLS](xls.html) | MS Excel format | No | No | libfreexl |
| [XLSX](xlsx.html) | MS Office Open XML spreadsheet | **Yes** | No | libexpat |
| [XODR](xodr.html) | OpenDRIVE Road Description Format | No | **Yes** | libOpenDRIVE >= 0.6.0, GEOS |

Note

The following drivers have been removed in GDAL 3.5: AeronavFAA, BNA, HTF, OpenAir, REC, SEGUKOOA, SEGY, SUA, XPlane

The following drivers have been removed in GDAL 3.11: Geoconcept Export, OGDI (VPF/VMAP support), SDTS, SVG, Tiger, UK. NTF

[Next](adbc.html "ADBC -- Arrow Database Connectivity")
 [Previous](../raster/zmap.html "ZMap -- ZMap Plus Grid")

---

© 1998-2026 [Frank Warmerdam](https://github.com/warmerdam),
[Even Rouault](https://github.com/rouault), and
[others](https://github.com/OSGeo/gdal/graphs/contributors)