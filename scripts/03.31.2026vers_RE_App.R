#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

##we need a variable that users can type into that writes into a vector:
install.packages("bsicons")

library(shiny)
library(bslib)
library(bsicons)
library(readxl)


##userinterface (ui) blankest template

ui <- page_sidebar(
  
)

server <- function(input,output) {
  
}

shinyApp(ui = ui, server = server)

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
    div(
    style = "color: #3b67ee; font-size: 16px;",
    checkboxGroupInput(
      "checkGroup",
      "Select all that apply",
      choices = list("Serve" = 1, "Slay" = 2, "Devour" = 3),
      selected = 1
      ),
    textOutput("result")
    )
  ),
  card(
    style = "background-color: #d8e8e8; 
    border-color: #1e49ff;
    border-width: 3px;",
    card_header(
      style = "color: #5786de; font-weight: bold; font-size: 20px;",
      "Date range input"
      ),
    div(
    style = "color: #83a665; font-size: 16px;",
    dateRangeInput("dates", "Select dates"),
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
card(
  card_header(
  style = "",
  "Upload Data"
  ),
  card_body(
    fileInput(
      inputId = "phenomicdata",
      label = "Upload your file",
      multiple = FALSE,
      accept = c(".csv", ".txt", ".xlsx", ".tsv", "xls")
    ),
    tableOutput("preview")
  )
)
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
  output$preview <- renderTable({
    req(input$phenomicdata)
    ##gets the file extension
    ext <- tools::file_ext(input$phenomicdata$name)
    
    ##reads the uploaded file based on extension
    switch(ext,
      "csv" = read.csv(input$phenomicdata$datapath),
      "txt" = read.delim(input$phenomicdata$datapath),  
      "tsv" = read.delim(input$phenomicdata$datapath, sep = "\t"),
      "xlsx" = readxl::read_excel(input$phenomicdata$datapath),
      "xls" = read::excel(input$phenomicdata$datapath)
    )
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