#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

#Preliminary .trt file creation script
#3/31/2026
#Tomas Lopes

trait_names<-c("height", "stem_color", "insect_damage", "flower_color")
format<-c("numeric", "categorical", "boolean", "multicat")

trait_file<-data.frame("trait"=trait_names,"format"=format,"defaultValue"=NA,"minimum"=NA,"maximum"=NA,
                       "details"=NA,"categories"=NA,"isVisible"=TRUE,"realPosition"=seq(from=1, to=length(format), by=1))
#Specifying categories/units
category1<-c("Blue/Green/Orange/Teal/Purple")
descriptor1<-c("Color")
#Changing trait_file values depending on format (i.e: if percent, minvalue=0, max=100)

for (i in 1:nrow(trait_file)){
  if (trait_file[i,2]=="numeric"){
    trait_file[i,6]<-"units"
  }
  else if (trait_file[i,2]=="categorical"){
    trait_file[i,6]<-descriptor1
    trait_file[i,7]<-category1
  }
  else if (trait_file[i,2]=="percent"){
    trait_file[i,4]<-"0"
    trait_file[i,5]<-"100"
  }
  else if (trait_file[i,2]=="boolean"){
    trait_file[i,3]<-"FALSE"
  }
  else if (trait_file[i,2]=="multicat"){
    trait_file[i,7]<-category1
  }
  else if (trait_file[i,2]=="angle"){
    trait_file[i,6]<-"degrees"
  }
}

#creating .trt file
write.csv(trait_file, "traitcsv.csv")
traitcsv<-read.csv("")
write.table<-write.table(trtcsv, sep=",", quote=T, file="traits.trt", row.names=F, col.names=F)

##we need a variable that users can type into that writes into a vector:
install.packages("bsicons")
install.packages("shinyWidgets")
library(shinyWidgets)
library(shiny)
library(bslib)
library(bsicons)
library(readxl)


##userinterface (ui) blankest template

##option for a page with a floating sidebar but idgaf
##ui <- page_fluid(
#layout_sidebar(
# sidebar = sidebar("Sidebar"),
#"Main contents"
#  )   
#)

##userinterface (ui) lays out the user interface of the app
##more options in the shiny application layout guide

ui <- page_sidebar(
  title = "Phenomic Data Dumper",
  fillable = TRUE,
  fillable_mobile = TRUE,
  lang = "en",
  theme = bs_theme(
    bg = "#f3ffe5",
    fg = "#1a1a2e",
    primary = "#c9ff9b",
    warning = "#ff69b4",
    danger = "#ff00ff",
    base_font = "Arial",
    font_scale = 1.2
  ),
  sidebar = sidebar(
    title = "mmm tabs",
    width = 200,
    bg = "#bed2ec",
    fg = "#1a1a3e",
    primary = "#74a4cd"
    ),
  card(
    style = "background-color: #C9FF9B; 
    border-color: #74a4cd;
    border-width: 3px;",
    card_header(
      style = "color: #1E49FF; font-weight: bold; font-size: 20px;",
      "Choices"
                ),
    pickerInput(
      inputId = "checkGroup",
      label = "Select traits to include",
      choices = list(
        "Chemical Composition" = list(
          "Oil Percentage" = "OIL",
          "Protein Percentage" = "PROTEIN",
          "Starch Percentage" = "STARCH"
        ),
        "Disease descriptors" = list(
          "Northern Leaf Blight" = "NORTHERN-LEAF-BLIGHT",
          "Stewarts Wilt" = "STEWARTS-WILT",
          "Gray Leaf Spot" = "GRAY-LEAF-SPOT",
          "Maize Dwarf Mosaic Virus" = "MDMV",
          "Eyespot" = "EYESPOT",
          "Diplodia Ear Rot" = "DIPLODIA-EAR-ROT",
          "Anthracnose Stalk Rot" = "ANTHRACNOSE-STALK-ROT",
          "Northern Leaf Blight Race O" = "NORTHERN-LEAF-BLIGHT_RACE-O",
          "Common Rust Race RP1-D" = "COMMON-RUST_RP1-D"
        ),
        "Insect descriptors" = list(
          "European Corn Borer Gen1" = "EUROPEAN-CORNBORER1",
          "European Corn Borer Gen2" = "EUROPEAN-CORNBORER2",
          "Rootworm Root Damage" = "ROOTWORM-DAMAGE"
        ),
        "Plant Traits" = list(
          "Plant Height" = "PLANT-HEIGHT",
          "Plant Vigor" = "PLANT-VIGOR",
          "Node Number Above the Ear" = "NODES-ABOVE-EAR",
          "Node Number" = "NODE-NUMBER",
          "Root Lodging" = "ROOT-LODGING",
          "Stalk Lodging" = "STALK-LODGING",
          "Tiller Number" = "TILLER-NUMBER"
        ),
        "Kernel Traits" = list(
          "Kernel Type" = "KERNEL-TYPE",
          "Kernel Color" = "KERNEL-COLOR",
          "Kernel Row Arrangement" = "KERNEL-ROW-ARRANGEMENT",
          "Kernel Row Number" = "KERNEL-ROW-NUMBER",
          "Upper Kernel Shape" = "UPPER-KERNEL-SHAPE",
          "Endosperm Color" = "ENDOSPERM-COLOR",
          "Aleurone Color" = "ALEURONE-COLOR",
          "Pericarp Color" = "PERICARP-COLOR",
          "1000 Kernel Weight" = "KERNEL-WEIGHT-1000",
          "Popping Expansion" = "POPPING EXPANSION"
        ),
        "Ear Traits" = list(
          "Ear Length" = "EAR-LENGTH",
          "Ear Diameter" = "EAR-DIAMETER",
          "Ear Height" = "EAR-HEIGHT",
          "Cob Color" = "COB-COLOR",
          "Ear Number" = "EAR-NUMBER",
          "Husk Length" = "HUSK-LENGTH",
          "Ear Shape" = "EAR-SHAPE",
          "Glume Development" = "GLUME-DEVELOPMENT",
          "Colored Silk Scar" = "SILK-SCAR"
        ),
        "Maturity and Flowering" = list(
          "Days to Silk" = "DAYS-TO-SILK",
          "AES Maturity" = "AES-MATURITY",
          "Days to Silk Relative to Check" = "DTS-CHECK-RELATIVE",
          "DTS Relative 40-49 Latitude" = "DTS-CHECK-RELATIVE_LAT40-49",
          "Days to Shed 40-49 Latitude" = "DAYS-TO-POLLEN_LAT40-49",
          "Days to Silk 10-19 Latitude" = "DAYS-TO-SILK_LAT10-19",
          "Days to Silk 40-49 Latitude" = "DAYS-TO-SILK_LAT40-49"
        ),
        "Growing Degree Units" = list(
          "Growing Degree Units to Silk F" = "GDU-SILK-F",
          "GDU Silking C Lat 40-49" = "GDU-SILK-C_LAT40-49",
          "GDU Anthesis F Lat 20-29" = "GDU-POLLEN-F_LAT20-29",
          "GDU Anthesis F Lat 40-49" = "GDU-POLLEN-F_LAT40-49",
          "GDU Silking F Lat 10-19" = "GDU-SILK-F_LAT10-19",
          "GDU Silking F Lat 20-29" = "GDU-SILK-F_LAT20-29",
          "GDU Silking F Lat 40-49" = "GDU-SILK-F_LAT40-49"
        ),
        "Race Data" = list(
          "Primary Race" = "PRIMARY-RACE",
          "Secondary Race" = "SECONDARY-RACE"
        ),
        "Molecular descriptiors" = list(
          "P-PHI024-CCT(SSR)" = "P_PHI024",
          "Notes and Remarks" = "NOTES"
        )
      ),
      multiple = TRUE,          # allows multiple selections
      options = list(
        `actions-box` = TRUE,   # adds Select All / Deselect All buttons
        `live-search` = TRUE,   # adds a search box at the top
        size = 10               # how many options visible at once
      ),
      selected = NULL
    )
),
card( ## Trait File Generator Card
  ##This card prompts the user for text that it then plops into a .txt file
  ##it then asks where you want to download it
  card_header("Create your text file"),
  
  textInput(
    inputId = "filename",
    label = "Enter file name (no extension needed, will be .trt). Naughty characters will be replaced with an underscore:",
    ##We need to ask the user for the file name here because we have to 
    ##save it as a .trt file, which Windows will not give the optino for and
    ##the user may not know they need to do
    placeholder = "i haven't watched enough Ru Paul to make a joke here :("
  ),
  
  downloadButton(
    outputId = "download_text",
    label = "Download Fieldbook Trait (.trt) file"
  )
),
)

server <- function(input,output) {
  output$result <- renderText({
    req(input$checkGroup)
    
    responses <- c()
    
    if ("1" %in% input$checkGroup) responses <- c(responses, "Work Diva!")
    if ("2" %in% input$checkGroup) responses <- c(responses, "Give Mamas!")
    if ("3" %in% input$checkGroup) responses <- c(responses, "Purr!")
    
    paste(responses, collapse = " ")
  })
  output$download_text <- downloadHandler(
    filename = function() {
      name <- trimws(input$filename) ##trimws trims white space from butterfingers
      name <- gsub('[\\\\/:*?"<>|]', "_", name) ##checks for characters Windows
      ##hates.  gsub will replace those characters with an underscore
      if (is.null(name) || name == "") { ## check to make sure filename isn't 
        ##empty or blank
        name <- paste0("EmptyFileName",Sys.time()) ##makes empty file name with
        ##systime so people can differentiate their empty file names and they
        ##dont overwrite old empty file names
      }
      paste0(name, ".trt") ##concat everything in ()
      ##paste0() makes sure there's no spaces, paste() would replace commas
      ##with spaces
    },
    contentType = "text/plain",
    content = function(file) {
      header <- c('"trait","format","defaultValue","minimum","maximum","details","categories","isVisible","realPosition"')
      ##header line for our .trt file
      writeLines(header, file) ##writes header line to .txt file
      ##here is where the rest of the .trt stuff will go.  The extra lines with 
      ##each trait 
    })
}

shinyApp(ui = ui, server = server)

##CAN SAVE AS HTML POTENTIALLY FOR A LOCAL WEBSITE