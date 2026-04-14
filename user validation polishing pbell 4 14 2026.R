#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#



##we need a variable that users can type into that writes into a vector:
if(!require("bsicons")) install.packages("bsicons")
##this code will check if a package is installed and only install it if it's 
##not there
if(!require("shinyWidgets")) install.packages("shinyWidgets")
if(!require("shiny")) install.packages("shiny")
if(!require("bslib")) install.packages("bslib")
if(!require("readxl")) install.packages("readxl")
if(!require("magrittr")) install.packages("magrittr")
if(!require("dplyr")) install.packages("dplyr")
if(!require("shinyjs")) install.packages("shinyjs")
library(shinyWidgets)
library(shiny)
library(shinyjs) ##lets Shiny do some Javascript, as a treat
library(bslib)
library(bsicons)
library(readxl)
library(magrittr)
library(dplyr)

##u

##userinterface (ui) lays out the user interface of the app
##more options in the shiny application layout guide

ui <- page_sidebar(
  title = "Phenomic Data Dumper",
  useShinyjs(), ##tells R we're using Shinyjs in the ui
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
    primary = "#74a4cd",
    uiOutput("trait_ref") ## waits for trait_ref to come from the server
    ## with the rednerUI() function
  ),
  
  card( ##user uploads trait file, no need to set working directory.
    style = "background-color: #C9FF9B; 
    border-color: #74a4cd;
    border-width: 3px;",
    card_header(
      style = "color: #1E49FF; font-weight: bold; font-size: 20px;",
      "Upload trait excel file"
    ),
    fileInput(##card for uploading the maize_trait file so we don't need to 
      ##worry about the working directory
      inputId="trait_file",
      label="Upload your trait excel file",
      accept=c(".xlsx")##ensures that only excel files are selected for this
      ##upload
    )
  ),

  card(
    style = "background-color: #C9FF9B; 
    border-color: #74a4cd;
    border-width: 3px;
    height: 50%",
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

server <- function(input, output, session) { ##session needed for us to use
  ##shinyjs, i guess it's a java thing
  session$onFlushed(function(){##onFlushed makes sure this code doesn't run
    ##until after the UI is rendered
  shinyjs::disable("download_text") ##disables the download button at startup
  }, once = TRUE) ##makes sure this block of code only runs once
  observe({ ##observe means only run the code once inputs change
    if (is.null(input$checkGroup) || length(input$checkGroup) == 0){
      ##checks to see if 
      shinyjs::disable("download_text")
    }
    else {
      shinyjs::enable("download_text")
    }
  })
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
      name <- trimws(input$filename)
      name <- gsub('[\\\\/:*?"<>|]', "_", name)
      if (is.null(name) || name == "") {
        name <- paste0("EmptyFileName", Sys.time())
      }
      paste0(name, ".trt")
    },
    contentType = "text/plain",
    content = function(file) {
      
      # only use traits the user selected in the checkbox
      trait.list <- input$checkGroup
      
      trait_file <- data.frame(
        "trait" = trait.list,
        "format" = "",
        "defaultValue" = "",
        "minimum" = "",
        "maximum" = "",
        "details" = "",
        "categories" = "",
        "isVisible" = TRUE,
        "realPosition" = seq(from = 1, to = length(trait.list), by = 1)
      )
      
      numeric_traits <- c(
        "Oil Percentage", "Protein Percentage", "Starch Percentage",
        "Plant Height", "Node Number Above the Ear", "Kernel Row Number",
        "Ear Length", "Ear Diameter", "Ear Height", "Ear Number",
        "Husk Length", "Node Number", "Tiller Number", "Days to Silk",
        "AES Maturity", "Growing Degree Units to Silk F",
        "GDU Silking C Lat 40-49", "Days to Shed 40-49 Latitude",
        "Days to Silk 10-19 Latitude", "Days to Silk 40-49 Latitude",
        "GDU Anthesis F Lat 20-29", "GDU Anthesis F Lat 40-49",
        "GDU Silking F Lat 10-19", "GDU Silking F Lat 20-29",
        "GDU Silking F Lat 40-49", "1000 Kernel Weight", "Popping Expansion"
      )
      
      multicat_traits <- c(
        "Kernel Color", "Cob Color", "Endosperm Color",
        "Aleurone Color", "Pericarp Color"
      )
      
      category1 <- "White/Yellow/Purple/Green/Blue/Red/Pink/Orange/None"
      descriptor1 <- "Color"
      
      for (i in 1:nrow(trait_file)) {
        if (trait_file[i, 1] %in% multicat_traits) {
          trait_file[i, 2] <- "multicat"
          trait_file[i, 6] <- descriptor1
          trait_file[i, 7] <- category1
        } else if (trait_file[i, 1] %in% numeric_traits) {
          trait_file[i, 2] <- "numeric"
        } else {
          trait_file[i, 2] <- "text"
        }
      }
      
      write.table(trait_file, sep = ",", quote = T, file = file, row.names = F, col.names = T)
    }
  )
  
}

shinyApp(ui = ui, server = server)

##CAN SAVE AS HTML POTENTIALLY FOR A LOCAL WEBSITE
