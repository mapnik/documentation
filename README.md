# Mapnik Documentation

The home for Mapnik documentation. Currently this only builds Node Mapnik documentation. Here's how it works:

1. A TravisCI cron job runs every day and runs the scripts/generate.sh script
1. This clones the Node Mapnik repository from master, which has all sorts of JSDoc comments in it
1. determines which minor version we are building docs for (i.e. 3.5, 3.6)
1. Runs `documentation` to generate an HTML file from the JSDoc comments and puts it into a folder named after the minor version
1. Runs the scripts/deploy.sh script to put these changes to the gh-pages branch which can be viewed from mapnik.org/documentation
