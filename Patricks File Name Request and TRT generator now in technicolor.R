library(shiny)
library(bslib)
library(bsicons)
library(readxl)

##userinterface (ui) lays out the user interface of the app

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
  )
)


server <- function(input,output) {
  ##Preview function
  ##this was left over from when i started writing this to accept user text
  ##into the text file, it was nice.  Might be nice to include this in the
  ##final product somehow
  # output$preview <- renderText({ ##converts R text into HTML text
  #   req(input$user_text) ##makes sure that input$user_text isn't empty
  #   input$user_text ##what is being displayed
  # })
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
    }
  )
}

shinyApp(ui = ui, server = server)
