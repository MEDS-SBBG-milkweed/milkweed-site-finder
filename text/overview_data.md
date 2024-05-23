# <i class="fa-solid fa-database"></i> Data

In order to create these products a myriad of data sources were used. For further information on the data sets utilized please visit the data sources linked and cited below.

## Disclaimer:

Many data products and outputs archived from this project contain or relate to sensitive data concerning locations of habitat for a federally endangered species. Our team was given permission to share this data by the U.S. Forest Service under the condition that a disclaimer is included: "Plant and seed collection on Forest Service land is not permissible without a plant collection permit from the Los Padres National Forest".

**Date accessed:**

All publicly accessible data was downloaded between 2024-01-10 and 2024-03-22.

------------------------------------------------------------------------

#  Data Sources Overview 

Raw data source details are formatted using the following template:

**Raw data source title**

**Brief description:** 

**How it was accessed:**

**Units (when relevant):**  

**Citation:**

**Licenses:** 



------------------------------------------------------------------------

### **Bioclimatic Data**

**Brief description:** Historical climate data -- 19 bioclimatic variables to represent annual trends, seasonality, extreme/limiting environmental factors based on monthly temperature and rainfall data (.tif)

**How it was accessed: `wallace::envs_worldclim()`**, which utilizes **`raster::getData()`** 

**Units:** Spatial Reference: WGS 1984 (EPSG 4326)

**Citation:** Fick, S.E. and R.J. Hijmans. (2017). WorldClim 2: new 1 km spatial resolution climate surfaces for global land areas. International Journal of Climatology 37 (12): 4302-4315.

<https://www.worldclim.org/data/worldclim21.html> 

**Licenses:** The data are freely available for academic use and other non-commercial use. Redistribution or commercial use is not allowed without prior permission. Using the data to create maps for publishing of academic research articles is allowed.



### **California Multi-Source Land Ownership:** 

**Brief description:** Classification of land ownership, excluding lands under private ownership, in California(.shp)

**How it was accessed:** Downloaded the \"California Land Ownership\" feature layer from California State Geoportal as a shapefile

**Units:** Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:**

California Department of Forestry and Fire Protection; California State Geoportal, hosted on CAL FIRE Portal (via gis.data.ca.gov) 

<https://gis.data.ca.gov/datasets/CALFIRE-Forestry::california-land-ownership/about> 

**Licenses:**

The State of California and the Department of Forestry and Fire Protection make no representations or warranties regarding the accuracy of data or maps. Neither the State nor the Department shall be liable under any circumstances for any direct, special, incidental, or consequential damages with respect to any claim by any user or third party on account of, or arising from, the use of data or maps.

For more information about this product, date or terms of use, contact calfire.egis\@fire.ca.gov.



### **Canopy Cover:**

**Brief description:** Horizontal cover fraction occupied by tree canopies (.tif)

**How it was accessed:** Downloaded from the California Forest Observatory website, selected \"Canopy Cover\" from available datasets to download. If counties need to be selected please select Kern County, Monterey County, San Luis Obispo, and Ventura County

**Units:** Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:** California Forest Observatory. (2020). A Statewide Tree-Level Forest Monitoring System. Salo Sciences, Inc. San Francisco, CA. <https://forestobservatory.com>

**Licenses:** For more information regarding licensing please visit: <https://forestobservatory.com/legal.html>



### **Digital Elevation Model (DEM):**

**Brief description:** Topographic surface of the earth and flattened water surfaces (.tif). Seven tiles were downloaded to cover the extent of the Los Padres National Forest (LPNF). 

Tiles: 

n35w119_20190919

n35w120_20190924

n35w121_20190924

n36w120_20190919

n36w121_20190919

n36w122_20210301

n37w122_20201207 

**How it was accessed:** [USGS\'s The National Map (TNM) download interface;](https://apps.nationalmap.gov/downloader/) searched for California, USA; selected Elevation Products (3DEP) 1 arc-second DEM; downloaded as GeoTIFF.

**Units:** Spatial Reference: NAD 1983 (EPSG 4269)

**Citation:** U.S. Geological Survey, 2019, 2020, 2021, USGS 3D Elevation Program Digital Elevation Model <https://apps.nationalmap.gov/downloader/> , courtesy of the U.S. Geological Survey.

**Licenses:** Data from The National Map is free and in the public domain. There are no restrictions on downloaded data; however, we request that the following statement be used when citing, copying, or reprinting data: "Data available from U.S. Geological Survey, National Geospatial Program."



### **Los Padres National Forest (LPNF) Boundary:**

**Brief description:** Boundary of the northern and southern regions of Los Padres National Forest in California filtered from the Forest Service Administrative Boundaries (.shp)

**How it was accessed:** [USDA Download National Datasets interface](https://data.fs.usda.gov/geodata/edw/datasets.php?dsetCategory=boundaries); Scroll to Administrative Forest Boundaries and Select ESRI Geodatabase; downloaded as GeoDatabase

**Units:** esriMeters, Spatial Reference: WGS 1984 Web Mercator Auxiliary Sphere (EPSG 3857)

**Citation:** United States Department of Agriculture Forest Service,Administrative Forest Boundaries. (2024); <https://data.fs.usda.gov/geodata/edw/datasets.php> 

**Licenses:** The USDA Forest Service makes no warranty, expressed or implied, including the warranties of merchantability and fitness for a particular purpose, nor assumes any legal liability or responsibility for the accuracy, reliability, completeness or utility of these geospatial data, or for the improper or incorrect use of these geospatial data. These geospatial data and related maps or graphics are not legal documents and are not intended to be used as such. The data and maps may not be used to determine title, ownership, legal descriptions or boundaries, legal jurisdiction, or restrictions that may be in place on either public or private land. Natural hazards may or may not be depicted on the data and maps, and land users should exercise due caution. The data are dynamic and may change over time. The user is responsible to verify the limitations of the geospatial data and to use the data accordingly.



### **Santa Barbara Botanic Garden Polygon Data:**

**Brief description:** Polygons indicating the shape of the outer border of observed milkweed plots in the Los Padres National Forest during field surveys in the summer of 2023. Includes information on milkweed species, presence/absence, location and number of plants

**How it was accessed:** Shared directly by the Santa Barbara Botanic Garden as a shapefile.

**Units:** Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:** Santa Barbara Botanic Garden, shared January 2024

**Licenses:** This data was privately shared with the MilkweedMod capstone team and is part of the Santa Barbara Botanic Garden\'s long-term milkweed restoration project. The capstone team was given permission to share this data by the U.S. Forest Service under the condition that the following disclaimer is included: "Plant and seed collection on Forest Service land is not permissible without a plant collection permit from the Los Padres National Forest".



### **Trails & Roads Data --- Los Padres Forest Watch:**

**Brief description:** Trails and road geometries, along with names and open/closed status, within the southern section of the Los Padres National Forest as of June 2023

**How it was accessed:** Downloaded from ArcGIS online with an ArcGIS Pro account as a shapefile

**Units:** esriMeters, Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:** ForestWatchGIS, 2023 Regional Trails and Roads, [Los Padres Forest Watch via ArcGIS](https://services9.arcgis.com/olCAyDMW794Lg7Au/arcgis/rest/services/2023_Regional_Trails_and_Roads/FeatureServer) 

**Licenses:** No license information was provided. For more information, refer to [this](https://services9.arcgis.com/olCAyDMW794Lg7Au/arcgis/rest/services/2023_Regional_Trails_and_Roads/FeatureServer/info/itemInfo?f=pjson) page. 




### **Trails & Roads Data --- USGS:**

**Brief description:** National Transportation Data (NTD) [California Shapefile](https://www.sciencebase.gov/catalog/item/5f6345ee82ce38aaa238c9df), courtesy of the U.S. Geological Survey -- trails and different types of roads in California (.shp), used data from within the northern region of the LPNF 

**How it was accessed:** Downloaded from the National Transportation Dataset via the USGS ScienceBase Catalog.  

**Units:** esriMeters, Spatial Reference: NAD 1983 (EPSG 4269)

**Citation:** Courtesy of the U.S. Geological Survey, 2024, USGS National Transportation Dataset (NTD) for California

<https://www.sciencebase.gov/catalog/item/5f6345ee82ce38aaa238c9df> 

**Licenses:** Data from The National Map is free and in the public domain. There are no restrictions on downloaded data; however, we request that the following statement be used when citing, copying, or reprinting data: "Data available from U.S. Geological Survey, National Geospatial Program."
