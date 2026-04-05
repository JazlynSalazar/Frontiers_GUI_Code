bat_content <- c(  ##makes a bat file that starts a local server
  "@echo off",
  "cd /d \"%~dp0\\site\"",
  "echo Starting local server...",
  "start http://localhost:8000",
  "python -m http.server 8000", ## python MUST be installed on the user's device
  "pause"
)

writeLines(bat_content, "run_site.bat") ##change run_site.bat to whatever