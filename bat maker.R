##installing the packages here ensures that we can run the libraries in the
##actual app.  I suppose we could put the install commands in the actual code
##but whatever
##you also have to set the working directory to where you want the .bat file
##made
install.packages('shiny')
install.packages('bslib')
install.packages('bsicons')
install.packages('readxl')
r_path <- Sys.which("Rscript") ##sys.which looks for Rscript and saves it as 
##a variable
if (r_path == ""){
  stop("RScript not found in PATH, make sure it's where it's supposed to be.")
}

cat("Found Rscript at:\n", r_path, "\n\n") ##displays filepath of Rscript

bat_content <- c( ##makes a formatted string for the .bat file
  "@echo off",
  "cd /d \"%~dp0\"",
  paste0('"', r_path, '" -e "shiny::runApp(\'', "app.R", '\', launch.browser=TRUE)"'),
  "pause" ##app.R is whatever R file you want to run
)

writeLines(bat_content, "run_app.bat")

cat("\nMade run_app.bat successfully!\n")

