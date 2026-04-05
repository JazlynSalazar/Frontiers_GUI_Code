install.packages("shinylive") ##installs shinylive package
##NOTE: code file must be called "app.R" and be in the working directory
shinylive::export(".", "site") ##creates the shinylive and server folder
servr::httw("site") ## launches the server
## the user will not run this script, this is just for us :3