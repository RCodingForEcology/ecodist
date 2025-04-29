# USGS National Elevation Dataset [3DEP 1/3 arc-second tiles](https://www.usgs.gov/3d-elevation-program/about-3dep-products-services)
# import, mosaic and crop

# NOTE: the proxy package, which is loaded by the spatial packages below, 
# currently overwrites the base dim.dist() method, which causes ecodist to
# fail. Loading ecodist LAST will restore default behavior


############################################


    if(!dir.exists(datadir)) {
        dir.create(datadir)
    }


############################################


if(!file.exists(file.path(datadir, "dem.tif"))) {

    library(sf)
    library(terra)

    # already downloaded
    if(dir.exists("USGS")) {
        r1 <- rast("USGS/USGS_13_n39w107_20211208.tif")
        r2 <- rast("USGS/USGS_13_n39w108_20211208.tif")
        r3 <- rast("USGS/USGS_13_n40w107_20211208.tif")
        r4 <- rast("USGS/USGS_13_n40w108_20211208.tif")
    } else {
        # obtain raster files
        # td <- tempdir() # option to save tiles in a temporary location
        td <- "USGS"
        download.file("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/current/n39w107/USGS_13_n39w107.tif", file.path(td, "USGS_13_n39w107.tif"))
        download.file("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/current/n39w108/USGS_13_n39w108.tif", file.path(td, "USGS_13_n39w108.tif"))
        download.file("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/current/n40w107/USGS_13_n40w107.tif", file.path(td, "USGS_13_n40w107.tif"))
        download.file("https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/current/n40w108/USGS_13_n40w108.tif", file.path(td, "USGS_13_n40w108.tif"))

        # obtain metadata
        download.file("https://thor-f5.er.usgs.gov/ngtoc/metadata/waf/elevation/1-3_arc-second/CO_UpperColorado_Topobathy_2020_D20/USGS_13_n39w107_20220331.xml", file.path(td, "USGS_13_n39w107_20220331.xml"))
        download.file("https://thor-f5.er.usgs.gov/ngtoc/metadata/waf/elevation/1-3_arc-second/CO_UpperColorado_Topobathy_2020_D20/USGS_13_n39w108_20220331.xml", file.path(td, "USGS_13_n39w108_20220331.xml"))
        download.file("https://thor-f5.er.usgs.gov/ngtoc/metadata/waf/elevation/1-3_arc-second/CO_DRCOG_2020_B20/USGS_13_n40w107_20220216.xml", file.path(td, "USGS_13_n40w107_20220216.xml"))
        download.file("https://thor-f5.er.usgs.gov/ngtoc/metadata/waf/elevation/1-3_arc-second/CO_SanLuisJuanMiguel_2020_D20/USGS_13_n40w108_20211208.xml", file.path(td, "USGS_13_n40w108_20211208.xml"))
        

        r1 <- rast(file.path(td, "USGS_13_n39w107.tif"))
        r2 <- rast(file.path(td, "USGS_13_n39w108.tif"))
        r3 <- rast(file.path(td, "USGS_13_n40w107.tif"))
        r4 <- rast(file.path(td, "USGS_13_n40w108.tif"))

    }

    dem <- mosaic(r1, r2, r3, r4, filename=file.path(datadir, "demfull.tif"))

    dem <- crop(dem, ext(-107.3, -106.6, 38.7, 39.2), filename=file.path(datadir, "dem.tif"))

    # optionally remove intermediate raster
    # file.remove(file.path(datadir, "demfull.tif"))

}


