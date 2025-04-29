# Vegetation data
# Plant composition data from [67 grassland sites](https://portal.edirepository.org/nis/mapbrowse?packageid=edi.418.1) 
# of the Upper Gunnison Basin, CO, USA, 2014.


############################################


    if(!dir.exists(datadir)) {
        dir.create(datadir)
    }


############################################


    if(file.exists(file.path(datadir, "veg.RDS"))) {

        veg <- readRDS(file.path(datadir, "veg.RDS"))
        species <- readRDS(file.path(datadir, "species.RDS"))
        
    } else {

        # obtain vegetation data if necessary and import into R

        if(dir.exists("edi.418")) {
            # previously downloaded data package
            raw <- read.table(file.path("edi.418", "VegCoverDataRMBL2014.csv"), header=TRUE, sep=",")
        } else {
            # if not previously downloaded, get the specific data file
            tf <- tempfile()
            download.file("https://pasta.lternet.edu/package/data/eml/edi/418/1/ea2f923a09983a5a2e286a6ea5ef0489", tf)
            raw <- read.csv(tf, header=TRUE, sep=",")
            rm(tf)
        }

        # drop bare ground
        raw$Kartez <- toupper(raw$Kartez)
        raw <- subset(raw, Kartez != "BAREGROUND")

        # create a site by species matrix 
        veg <- crosstab(do.call(paste, c(subset(raw, select = c(Gradient, Site)), sep = ".")), raw$Kartez, raw$Cover, type="mean")
        

        saveRDS(veg, file = file.path(datadir, "veg.RDS"))


        ###

        # create and clean up list of species

        species <- subset(raw, select = c(Kartez, Family, Genus, Species, Lifeform, LifeHistory, Status))

        # clean up some mismatches
        species$LifeHistory[is.na(species$Genus)] <- NA
        species$Status[is.na(species$Genus)] <- NA

        species$LifeHistory[species$Species == "sp."] <- NA
        species$Status[species$Species == "sp."] <- NA

        species$Lifeform[species$Family == "Poaceae"] <- "g"

        species$Genus <- sub(" $", "", species$Genus)
        species$Family[species$Family == "Asteraeceae"] <- "Asteraceae"
        species$Species[species$Species == "pulcherrima x hippiana"] <- "pulcherrima"

        ###

        species <- unique(species)
        species <- species[order(species$Kartez), ]
        rownames(species) <- NULL

        saveRDS(species, file = file.path(datadir, "species.RDS"))
        
    }


############################################


    if(file.exists(file.path(datadir, "geo.RDS"))) {

        geo <- readRDS(file.path(datadir, "geo.RDS"))

    } else {

        library(sf)
        
        # obtain environmental data if necessary and import into R

        if(dir.exists("edi.418")) {
            # previously downloaded data package
            geo <- read.table(file.path("edi.418", "geographicInfo.csv"), header=TRUE, sep=",")
        } else {
            # if not previously downloaded, get the specific data file
            tf <- tempfile()
            download.file("https://pasta.lternet.edu/package/data/eml/edi/418/1/d14f5a9d05e39a978a5de3d78e7e36c3", tf)
            geo <- read.csv(tf, header=TRUE, sep=",")
            rm(tf)
        }

        # create sf spatial object for sampling points and transform to match USGS DEM

        geo$id <- paste(geo$Gradient, geo$Site, sep=".")
        geo <- geo[order(geo$id), ]

        geo.pts <- st_as_sf(geo, coords = c("Longitude","Latitude"), crs = "epsg:4269")

        # transform to projected coordinates
        geo.pts.aea <- st_transform(geo.pts, crs = "epsg:5070")

        geo <- data.frame(geo, st_coordinates(geo.pts.aea))

        saveRDS(geo, file = file.path(datadir, "geo.RDS"))
        saveRDS(geo.pts, file = file.path(datadir, "geo.pts.RDS"))

    }


############################################


